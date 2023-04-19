#!/opt/homebrew/bin/python3

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Variables
GITHUB_REPO="https://github.com/iconoir-icons/iconoir/tree/main/icons"
ASSETS_DIR="Sources/Iconoir/Assets.xcassets"
ICON_ENUM_FILE="Sources/Iconoir/Icon.swift"

# Check if CairoSVG is installed
if ! command_exists cairosvg; then
    echo "CairoSVG is not installed. Please install it using 'pip install cairosvg'."
    exit 1
fi

# Create directories if they don't exist
mkdir -p "${ASSETS_DIR}"

# Fetch icons from the GitHub repository and save them to the Assets.xcassets folder
icon_list=$(curl -sL "${GITHUB_REPO}" | grep -o 'blob/main/icons/[^"]*\.svg' | sed 's/blob\/main\//main\//')

# Function to download and process an icon
download_and_process_icon() {
    svg_url=$1
    icon_file=$(basename "${svg_url}")
    icon_name="${icon_file%.*}"
    local_icon_path="${ASSETS_DIR}/${icon_name}.imageset"

    if [[ ! -f "${local_icon_path}/${icon_name}.pdf" ]]; then
        mkdir -p "${local_icon_path}"

        # Download the SVG file
        curl -sL -o "${local_icon_path}/${icon_file}" "https://raw.githubusercontent.com/iconoir-icons/iconoir/${svg_url}"
        
        sed -i '' -e 's/stroke="currentColor"/stroke="#000000"/g' -e 's/stroke-width="[0-9.]*"/stroke-width="1.5"/g' "${local_icon_path}/${icon_file}"

        # Create JSON file for the icon in Assets.xcassets
        json_file="${local_icon_path}/Contents.json"
        cat <<-JSON > "${json_file}"
{
  "images" : [
    {
      "filename" : "${icon_name}.svg",
      "idiom" : "universal",
      "scale" : "1x"
    },
    {
      "idiom" : "universal",
      "scale" : "2x"
    },
    {
      "idiom" : "universal",
      "scale" : "3x"
    }
  ],
    "info" : {
        "author" : "xcode",
        "version" : 1
    }
}
JSON
        echo "Downloaded ${icon_name}"
    fi
}

# Download icons in parallel
echo "Downloading icons:"
export -f download_and_process_icon
export ASSETS_DIR
echo "${icon_list}" | xargs -n 1 -P 10 -I {} bash -c 'download_and_process_icon "$@"' _ {}
echo

# Create Icon.swift enum file
echo "public enum Iconoir: String, CaseIterable {" > "${ICON_ENUM_FILE}"

# Initialize an array to store the enum cases
enum_cases=()

# Iterate through the downloaded icons using process substitution
while read -r icon_path; do
    icon_file=$(basename "${icon_path}")
    icon_name="${icon_file%.*}"
    
    # Replace special characters with spaces
    icon_name_clean=$(echo "${icon_name}" | tr "[:punct:]" " ")

    # Convert to camel case
    icon_case=$(echo "${icon_name_clean}" | awk '{for(i=1;i<=NF;i++){if(i==1){printf("%s",$i)}else{printf("%s",toupper(substr($i,1,1)) substr($i,2))}}}')
    
    # Handle reserved keywords and starting with numbers
    case "${icon_case}" in
        import|default|case|var|let|class|struct|func|enum)
            icon_case="${icon_case}Icon"
            ;;
        [0-9]*)
            icon_case="icon${icon_case}"
            ;;
    esac

    # Store the case with its raw value in the array
    enum_cases+=("    case ${icon_case} = \"${icon_name}\"")
done < <(find "${ASSETS_DIR}" -name "*.svg")

# Sort the enum cases alphabetically
IFS=$'\n' sorted_cases=($(sort <<<"${enum_cases[*]}"))
unset IFS

# Write the sorted cases to the Icon.swift enum file
for case_line in "${sorted_cases[@]}"; do
    echo "${case_line}" >> "${ICON_ENUM_FILE}"
done

# Close the enum declaration
echo "}" >> "${ICON_ENUM_FILE}"
echo "Script completed successfully."
