#!/usr/bin/env bash

#ppa flatpak

echo "Checking flatpak PPA status"

if [[ "$(grep -iR flatpak/stable /etc/apt)" = "" ]]; then

  echo " PPA missing so adding it"
  sudo add-apt-repository ppa:flatpak/stable -y
  sudo apt update
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  clear
elif [[ "$(grep -iR flatpak/stable /etc/apt)" != "" ]]; then
  echo "PPA already added"
  sudo apt update
  clear
else
  echo "Aborted"
fi

#flatpak install
if [ "$(command -v flatpak)" = "" ] && [[ "$(grep -iR flatpak/stable /etc/apt)" != "" ]]; then
  echo "Installing Flatpak"
  sudo apt install flatpak -y
  clear

elif [ "$(command -v flatpak)" != "" ] && [[ "$(grep -iR flatpak/stable /etc/apt)" != "" ]]; then
  echo "Flatpak is installed"

else
  echo "Aborted"
fi

echo "Updating and cleaning unused flatpak apps"
flatpak uninstall --unused
flatpak update
flatpak list --app
