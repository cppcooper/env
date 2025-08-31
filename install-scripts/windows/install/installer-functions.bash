function install(){
    echo "choco install $1"
    choco install $1 -y --no-progress --allow-empty-checksums | grep -e "The install of" -e "Chocolatey installed" -e "ERROR" -e "not installed. The package"
    echo 
}
export PATH="/c/ProgramData/chocolatey/bin:$PATH"