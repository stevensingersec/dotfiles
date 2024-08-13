# Bash function to URL-encode a string using Python
urldecode() {
    if [[ -n "$1" ]]; then
        # If an argument is provided, decode the argument
        local string="$1"
        python3 -c "import sys, urllib.parse as up; print(up.unquote_plus(sys.argv[1]), end='')" "$string"
    else
        # If no argument is provided, read from stdin and decode
        python3 -c "import sys, urllib.parse as up; print(up.unquote_plus(sys.stdin.read()), end='')"
    fi
}

# Bash function to URL-decode a string using Python
urlencode() {
    if [[ -n "$1" ]]; then
        # If an argument is provided, encode the argument
        local string="$1"
        python3 -c "import sys, urllib.parse as up; print(up.quote_plus(sys.argv[1]), end='')" "$string"
    else
        # If no argument is provided, read from stdin and encode
        python3 -c "import sys, urllib.parse as up; print(up.quote_plus(sys.stdin.read()), end='')"
    fi
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

# Function to perform DNS-over-HTTPS queries
function doh_query() {
    local domain="$1"
    local type="${2:-A}"  # Default to A record if not specified
    local doh_url="https://cloudflare-dns.com/dns-query"

    # Perform the DNS query over HTTPS
    curl -s -H "accept: application/dns-json" "${doh_url}?name=${domain}&type=${type}" 
}
