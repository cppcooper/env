cd "${BASH_SOURCE%/*}"
function main(){
    source ./installer-functions.bash
    install git
   #install p4 --ignore-checksums
   #install p4merge

    install sublimetext3
    install sublimemerge
    install hxd

    install jre8
    install openjdk
    install StrawberryPerl
   #install python
    install mingw
    install make
    choco install cmake -y

    install codelite
    install intellijidea-community
   #install visualstudio2019community
   #install visualstudio2017buildtools
   #install visualstudio2017-workload-vctools
   #choco install microsoft-visual-cpp-build-tools -y --installargs "/InstallSelectableItems 'Win10SDK_VisibleV1;VisualCppBuildTools_ATLMFC_SDK;VisualCppBuildTools_NETFX_SDK'"
   #install dotnet3.5
    install netfx-4.6.2-devpack #UE4 needs thischoco
    install netfx-4.8-devpack

    install epicgameslauncher

    junction /c/tools/build/make /c/ProgramData/chocolatey/lib/make/tools/install
    junction /c/tools/build/mingw-w64.x86_64-posix-seh /c/ProgramData/chocolatey/lib/mingw/tools/install/mingw64
    junction /c/tools/build/cmake /c/Program\ Files/CMake
    append_path $(convert_path -w /c/tools/build/make/bin)
    append_path $(convert_path -w /c/tools/build/mingw-w64.x86_64-posix-seh/bin)
    append_path $(convert_path -w /c/tools/build/cmake/bin)
}
#functions copied directly from functions.bash
#except conver_path, copied from C:/tools/bin and converted into a function
windows() { [[ -n "$WINDIR" ]]; }
function convert_path(){
  # This is free and unencumbered software released into the public domain.
  #
  # Anyone is free to copy, modify, publish, use, compile, sell, or
  # distribute this software, either in source code form or as a compiled
  # binary, for any purpose, commercial or non-commercial, and by any
  # means.
  #
  # In jurisdictions that recognize copyright laws, the author or authors
  # of this software dedicate any and all copyright interest in the
  # software to the public domain. We make this dedication for the benefit
  # of the public at large and to the detriment of our heirs and
  # successors. We intend this dedication to be an overt act of
  # relinquishment in perpetuity of all present and future rights to this
  # software under copyright law.
  #
  # THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  # EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  # MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
  # IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
  # OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
  # ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  # OTHER DEALINGS IN THE SOFTWARE.
  #
  # For more information, please refer to <http://unlicense.org/>

  # Author: djcj <djcj@gmx.de>

  last=${!#}

  function print_usage() {
    cat <<EOL
  usage:
  $(basename $0) [-u|-w|-m] [-a] path
  $(basename $0) -h|--help
  Convert Unix and Windows format paths.
  Output type options:
    -u, --unix        (default) print Unix form of NAMEs (/c/Windows)
    -w, --windows     print Windows form of NAMEs (C:\\Windows)
    -m, --mixed       like --windows, but with regular slashes (C:/Windows)
  Path conversion options:
    -r, --realpath    output absolute path with resolved symbolic links
    -s, --subst-home  substitute Unix HOME path with Windows user path
  Other options:
    -h, --help        output usage information and exit
EOL
    exit $1
  }

  function checkarg() {
    if [ "$1" = "$last" ]; then
      echo "Error: missing path argument"
      exit 1
    fi
  }

  function win_env() {
    echo $(cmd.exe /C echo %${1}% 2>/dev/null | sed -e 's|\r||;s|\\|/|g')
  }

  # Currently only support Debian or Ubuntu images for WSL

  if [ -z "$1" ]; then
    print_usage 1
  fi

  to_unix=yes
  mixed_mode=no
  realpath=no
  subst_home=no

  while [[ $# -gt 0 ]]; do
    case $1 in
      -w|--windows)
        to_unix=no
        checkarg $1
        ;;
      -u|--unix)
        to_unix=yes
        checkarg $1
        ;;
      -m|--mixed)
        to_unix=no
        mixed_mode=yes
        checkarg $1
        ;;
      -r|--realpath)
        realpath=yes
        checkarg $1
        ;;
      -s|--subst-home)
        subst_home=yes
        ;;
      -h|--help)
        print_usage 0
        ;;
      *)
        ;;
    esac
    shift
  done

  p=$(echo $last | sed -e 's|\\\+|/|g;s|/\+|/|g')

  if [ $subst_home = yes ] && [ $to_unix = no ]; then
    userprofile=$(win_env USERPROFILE)
    drive=${userprofile:0:1}
    win_home=/${drive,,}${userprofile:2}
  fi

  if [ $to_unix = yes ]; then
    # windows to unix
    lxssLen=$(echo $lxss | wc -m)
    if [ "${p:0:$lxssLen}" = "$lxss" ]; then
      subdir=$(echo $p | cut -d'/' -f7)
      lxssDirs=$(grep -e ' lxfs ' /proc/mounts | awk '{print $1}')
      if [ -n "$(echo $lxssDirs | tr ' ' '\n' | grep -e "^$subdir\$")" ]; then
        offset=$(echo $lxss/$subdir | wc -m)
        prefix=$(grep -e "^$subdir " /proc/mounts | awk '{print $2}')
        [ "$prefix" != / ] || prefix=""
        p=$prefix${p:$offset}
      fi
    fi
    if [ -n "$(echo ${p:0:3} | grep -e '^[A-Za-z]:/\?$')" ]; then
      drive=${p:0:1}
      p=/${drive,,}${p:2}
    fi
    if [ $realpath = yes ]; then
      p=$(realpath -m "$p")
    fi
  else
    # unix to windows
    if [ $realpath = yes ]; then
      p=$(realpath -m "$p")
    fi
    if [ "${p:0:1}" = / ]; then
      if [ $subst_home = yes ]; then
        p=$(echo $p | sed "s|^$HOME|$win_home|")
      fi
      if [ -n "$(echo ${p:0:7} | grep -e '^/[a-z]/\?$')" ]; then
        drive=${p:5:1}
        p=${drive^^}:${p:6}
      elif [ -n "$(echo ${p:0:3} | grep -e '^/[a-z]/\?$')" ]; then
          drive=${p:1:1}
          p=${drive^^}:${p:2}
      else
        firstDir=/$(echo $p | cut -d'/' -f2)
        offset=$(printf "$firstDir" | wc -m)
        rootDirs=$(grep -e ' lxfs ' /proc/mounts | awk '{print $2}')
        if [ -z "$(echo $rootDirs | tr ' ' '\n' | grep -e "^$firstDir\$")" ]; then
          firstDir=/
          offset=0
        fi
        p=$lxss/$(grep -e " $firstDir " /proc/mounts | awk '{print $1}')${p:$offset}
      fi
    fi
    if [ $mixed_mode = no ]; then
      p=$(echo $p | tr '/' '\\')
    fi
  fi

  echo $p
}
junction() {
  if [ -z "$1" ] || [ -z "$2" ]
  then
    echo "Error: LINK and TARGET not provided"
    echo "Usage: junction <LINK> <TARGET>"
    return
  fi
  link="$1"
  target="$2"
  if [ ! -d "$(dirname $link)" ]; then
    mkdir -p "$(dirname $link)"
  fi
  if windows; then
    cmd <<< "mklink /J \"$(convert_path -w $link)\" \"$(convert_path -w $target)\"" > /dev/null
  else
    echo "Error: junction can't run in linux"
  fi
}
function append_path(){
    tpath=$(reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" //v Path | grep -oP "%System.*")
    tpath="$tpath;$1"
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" //v Path //t REG_EXPAND_SZ //d "$tpath" //f
}

main
