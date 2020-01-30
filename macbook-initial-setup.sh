#!/bin/bash

# install homebrew apps repositories manager
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# add repo with drivers to cask (needed for Steelseries Engine and Logitech Camera Settings)
brew tap homebrew/cask-drivers

# List of non-AppStore apps
nonAppStoreApps=(
#Browsers
    firefox-developer-edition
    chromium
#Developer
    postman # Most popular HTTP requests tool
    visual-studio-code # Modern code editor with community-driven plugins
    tableplus # Modern SQL client
    charles # Web debugging proxy
    mactex # Full LateX installation with supporting apps, about 4GB!
    alacritty # GPU-accelerated terminal emulator
    sketch # UI/UX design tool
    dotnet-sdk # Dotnet language support
    docker # App to make containers for environments 
    # zeplin # UI/UX design viewer
    # typora # Markdown single pane editor
    # sourcetree # GUI for git and gitflow
    # sherlock # App to edit iOS Views on the fly
    # isimulator # App to manage iOS Simulators
    # cyberduck # FTP client
#Video
    iina # Best looking macOS video watching app
    # vlc # Most popular cross-platform video watching app
    handbrake # Video Transcoder
#OTHER
    transmission # Torrents client
    # skype # Communicator
    # keka # Rar extractor
    calibre # Mobi/epub e-book converter
    # virtualbox # Virtual Machine
    # virtualbox-extension-pack # Extensions for virtualbox such as display resolution and USB
    logitech-camera-settings  #drivers for the webcamera
    signal # End-to-end encrypted messenger
    xquartz # X11 windows server needed for wine
    scroll-reverser # Reverse scrolling setting separate for touchpad and mouse. Use instead of bettertouchtool
    bartender # Top bar management
    contexts # Better window switcher
#Audio 
    spotify # Most popular music streaming service
    soundflower # App giving additional audio sources for audio manipulation
    # kode54-cog # Music and audio player    
    # xld # Audio converter
    # musicbrainz-picard # Audio tags editor
#Developer
    # intellij-idea-ce # Java IDE from JetBrains
    # insomnia # Open source HTTP requests tool
    # paw # MacOS native HTTP requests tool
    # reveal # App to edit iOS Views on the fly
#Other
    # anki # App for learning with flashcards
    # zoomus # Video conference App
    # wine-stable # App to open Windows .exe files
    # paragon-ntfs # Support for NTFS file system
    # thunderbird # Open Source Email client
)

# install non-AppStore apps
brew cask install ${nonAppStoreApps[@]}

# Install AppStore CLI installer
brew install mas

# list of AppStore apps
appStoreApps=(
#DaisyDisk
    # 929507092 # PhotoScape X (Photo Editor)
    # 593341977 # PDF Attributes (PDF metadata editor)
    497799835 # Xcode (Apple IDE)
    # 1333542190 # 1Password 7 (Password Manager)
    # 1091189122 # Bear (Notes with markdown support)
    # 904280696 # Things 3 (TODO app)
    # 975937182 # Fantastical 2 (Calendar app)                                 
    # 1335413823 # Ka-Block! (Ads blocking Safari extension)
    # 768053424 # Gapplin (Vector images viewer/converter)
    803453959 # Slack (Communicator)
    # 405399194 # Kindle (Mobi file format reader)
    # 462054704 # Microsoft Word (Documents editor)
    # 462058435 # Microsoft Excel (Spreadsheets editor)
    # 462062816 # Microsoft PowerPoint (Presentations editor)
    # 409201541 # Pages (Apple's documents editor)
    # 409203825 # Numbers (Apple's spreadsheets editor)
    # 409183694 # Keynote (Apple's presentations editor)
    # 1120214373 # Battery Health 2 (Battery stats and health)
    425424353 # The Unarchiver (Archives extractor)
    # 1007457278 # Realm Browser (Realm databases browser)
    # 1278508951 # Trello (Project management tool)
    # 688211836 # EasyRes (resolution changer for retina)
    # 1330801220 # quicktype (JSON to Code generator)
    # 430798174 # HazeOver (App that dims unfocused windows)
    # 425955336 # Skitch (App for marking pictures)
    1014850245 # Monit (Sensors & stats monitoring app for notification centre)
    441258766 # Magnet (Window snapping to edges of screen)
    1150900821 # Caato Time Tracker+ (Time tracking for project work)
#Unused
    # 985367838 # Microsoft Outlook (Email client)
    # 673660806 # Controllers Lite (Gamepads diagnostics app)
)

# Install AppStore apps
mas install ${appStoreApps[@]}

# Copy SF Mono font (available only in Xcode and Terminal.app) to the system
cp -R /System/Applications/Utilities/Terminal.app/Contents/Resources/Fonts/. /Library/Fonts/

# Remove ALL icons (except Finder) from dock
echo "Removing all icons (except Finder) from the dock…"
defaults write com.apple.dock persistent-apps -array

# List of dock icons
dockIcons=(
    /System/Applications/Launchpad.app
    "/Applications/Firefox Developer Edition.app"
    /System/Applications/Mail.app
    /System/Applications/Messages.app
    /Applications/Slack.app
    "/Applications/Caato Time Tracker+.app"
    /Applications/Alacritty.app
    "/Applications/Visual Studio Code.app"
    /Applications/Xcode.app
)

# Adding icons
for icon in "${dockIcons[@]}"
do
    echo "Adding $icon to the dock…"
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$icon</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
done

echo "Setting up dock size…"
defaults write com.apple.dock tilesize -int 45

echo "Restarting dock…"
killall Dock

# List of brew packages
brewPackages=(
    swiftlint # Linter for swift language
    carthage # Dependency manager for iOS apps
    gnupg # OpenPGP for signing and encrypting
    pinentry-mac # App to use macOS native keychain for PGP passwords
    python # Python version 3.7, preinstalled is 2.7
    neovim # Modern version of vim
    fish # Even better shell
    topgrade # Upgrade everything at once
    git # Up-to-date version of git
    tmux # Terminal multiplexer
    byobu # tmux wrapper
    gotop
    htop
    asciiquarium
)

# install brew packages
brew install ${brewPackages[@]}

# install CocoaPods dependency manager for iOS apps
# sudo gem install cocoapods

# install CocoaPods Keys plugin
# sudo gem install cocoapods-keys

# Xcode won't ask for password with every build
DevToolsSecurity -enable

# Make pinentry-mac your default pientry choice
echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf

# #Export GPG keys (from the other mac!)
# #Get the keys IDs
# gpg --list-keys
# gpg --list-secret-keys
# #Export keys
# gpg --export-secret-keys --armor <key> > ./file-sec.gpg
# gpg --export --armor <key> > ./file.gpg
# 
# # Import GPG keys. 
# # WARNING: You need to replace the <Path to pub key> and <Path to prv key> with the actual paths.
# gpg --import <Path to pub key>
# gpg --allow-secret-key-import --import <Path to prv key>

# Configure git
git config --global user.email "soren@neros.dev"
git config --global user.name "Søren Mortensen"

# Switch to fish
cat /etc/shells | grep -q "fish" || echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

# Install homeshick
git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
homeshick clone git@git.sr.ht:~nerosnm/dotfiles
homeshick clone git@git.sr.ht:~nerosnm/secrets

homeshick link dotfiles
homeshick link secrets

# Install rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env

# Install nightly rust
rustup toolchain install nightly
rustup component add --toolchain nightly rls rust-src rust-analysis rustfmt

# Cargo packages
cargoPackages=(
    exa
    bat
    ripgrep
    fd-find
    sd
    du-dust
    starship
)

cargo install ${cargoPackages[@]}

# Reload fish config
exec fish

## CRUCIAL TO CHECK IF YOUR MAC HAD PREVIOUS OWNERS (OR IS NOT YOURS)
# To check if your Mac is enrolled to Mobile Device Management try renewing it
sudo profiles renew -type enrollment
# And then validate
sudo profiles validate -type enrollment
# By default you should not be enrolled. If you are, external organisation can manage your macOS!

# Update installed apps and clear caches
brew update
brew upgrade
brew cask upgrade
brew cleanup
rm -rf ~/Library/Caches/Homebrew

# As we installed homebrew before xcode, we need to switch to Xcode Command Line Tools
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
