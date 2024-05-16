# Bash function to URL-encode a string using Python
urlencode() {
    local string="$1"
    python3 -c "import sys, urllib.parse as up; print(up.quote_plus(sys.argv[1]),end='')" "$string"
}

# Bash function to URL-decode a string using Python
urldecode() {
    local string="$1"
    python3 -c "import sys, urllib.parse as up; print(up.unquote_plus(sys.argv[1]),end='')" "$string"
}

# Function to capture state information for easy cloning into new terminals, such as IP=x.x.x.x declarations 
store_env() {
    local file=~/.shell_env
    {
        # Save the current PWD
        echo "export PWD='$PWD'"
        
        # Save all variables (exported and non-exported)
        if [ -n "$BASH_VERSION" ]; then
            declare -p
        elif [ -n "$ZSH_VERSION" ]; then
            typeset -p
        fi
    } > "$file"
    echo cd "$PWD" >> "$file"
    echo "Environment stored in $file"
}

# Function to restore state information
recall_env() {
    local file=~/.shell_env
    if [[ -f "$file" ]]; then
        # Source the file to restore environment variables
        source "$file"
        echo "Environment restored from $file"
    else
        echo "File $file not found"
    fi
}
