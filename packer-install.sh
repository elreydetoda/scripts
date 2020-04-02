#!/usr/bin/env bash

set -euo pipefail
# debug
# set -x

## vars
hashicorp_tool='packer'
# local filesystem vars for packer
packer_bin_folder='/opt/packer/bin/'
packer_bin="${packer_bin_folder}/packer"

# dir to install packer
install_dir='/usr/local/bin'

# dependencies
# from: https://stackoverflow.com/questions/12545066/shell-script-to-check-ubuntu-version-and-then-copy-files
if [[ $(lsb_release -rs | tr -d '.') -lt "1910" ]]; then # replace 8.04 by the number of release you want

  deps=( 'bsdtar' )
else
  deps=( 'libarchive-tools' )
fi

function deps_check(){
  for dep in "${deps[@]}" ; do
    if ! command -v "${dep}" 1>/dev/null ; then
      printf "You don't have this dependency: %s\n" "${dep}"
      read -rp 'Would you like to install it? [Y/n] ' install_answer

      install_cmd="sudo apt install -y ${dep}"

      case "${install_answer}" in
        Y|y|'')
          if ! eval "${install_cmd}"  ; then
            sudo apt-get update
            eval "${install_cmd}"
          fi
          ;;
        *)
          printf "Sorry, you can't continue\n"
          exit 1
          ;;
      esac

    fi

  done
}

## installing packer
function download_packer(){
  # variables to identify packer version
  hashicorp_base_url='https://releases.hashicorp.com'
  packer_base_url="${hashicorp_base_url}/packer"

  # getting hyperlinks for packer releases
  packer_releases="$(curl -fsSL "${packer_base_url}")"

  # getting most recent release
  current_packer_release="$(echo "${packer_releases}" | grep -oP '\/packer\/[\d\.]+\/' | grep -oP '[\d\.]+' | head -n 1)"

  # getting packer download url
  current_packer_url="${packer_base_url}/${current_packer_release}"

  # getting linux amd64 url
  # credit for sed is from here: https://github.com/SamuraiWTF/samuraiwtf/pull/103#commitcomment-35941962
  packer_url="$(curl -fsSL "${current_packer_url}" | sed -n '/href=".*linux_amd64.zip"/p' | awk -F'["]' '{print $10}')"

  # download zip and extract to the bin folder
  printf '\nDownloading %s\n' "${hashicorp_tool}"
  printf 'this can take a little bit.\n'
  curl -fsSL "${hashicorp_base_url}${packer_url}" | sudo bsdtar -C "${packer_bin_folder}" -xf -
}

deps_check

# creating packer bin folder
sudo mkdir -p "${packer_bin_folder}"

download_packer

printf 'installing to %s\n' "${install_dir}"
sudo install "${packer_bin}" "${install_dir}"
