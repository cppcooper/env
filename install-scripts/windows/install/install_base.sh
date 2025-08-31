cd "${BASH_SOURCE%/*}"
source ./installer-functions.bash

choco install LinkShellExtension --ignore-checksums -y
install ln
install 7zip
install sysinternals
install explorerplusplus

install sharex
install adobereader
install defraggler
install filezilla
install procexp

install firefox