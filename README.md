sudo apt update
sudo apt upgrade -y
sudo apt install -y zsh unzip
sudo hostname fishy
mkdir -p ~/.local/bin
mkdir -p ~/.config/{git,nvim,home-manager,ohmyposh}

chsh

rm ~/.bash*
rm ~/.profile
rm ~/.motd_shown
rm ~/.zcompdump
rm ~/.sudo_as_admin_successful

exit

bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

# Is there a way to pass -y?

curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin

export PATH=$PATH:/home/warren/.local/bin

git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

git clone https://github.com/wsgavin/ubuntu-nix.git ~/.config/home-manager

curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate

. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

cd .config/home-manager

nix run home-manager -- switch -b backup
nix flake update
home-manager switch -b backup --flake .

--

sudo determinate-nixd upgrade
nix-env --upgrade
nix flake update
home-manager switch -b backup --flake .
nix-collect-garbage

