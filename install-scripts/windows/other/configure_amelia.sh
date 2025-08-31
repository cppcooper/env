cd "${BASH_SOURCE%/*}"
cmd "//C %amelia.cmd"
cmd "//C %power_management.cmd"
regedit //s registry_keys/local-machine/DisableUAC.reg
regedit //s registry_keys/local-machine/FileExplorer.reg
regedit //s registry_keys/local-machine/RemoveShortcutArrows.reg