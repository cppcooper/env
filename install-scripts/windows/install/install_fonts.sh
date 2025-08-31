cd "${BASH_SOURCE%/*}"
cp "../../ProggyCleanSZ.ttf" "/c/Windows/Fonts"
cp "../../ProggySquareSZ.ttf" "/c/Windows/Fonts"
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" //v "ProggyCleanSZ (TrueType)" //t REG_SZ //d ProggyCleanSZ.ttf //f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" //v "ProggySquareSZ (TrueType)" //t REG_SZ //d ProggySquareSZ.ttf //f