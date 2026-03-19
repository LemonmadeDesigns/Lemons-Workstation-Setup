#!/usr/bin/env bash
#
# setup.sh: Full macOS Developer Environment Bootstrap
# by Mr. Lemons (Production Ready)
#

set -e

echo "🔐 Requesting sudo access..."
sudo -K
sudo true
clear

echo "🚀 Starting full macOS developer setup..."

# --------------------------------------------------
# 0. Xcode Command Line Tools
# --------------------------------------------------
if ! xcode-select -p &>/dev/null; then
  echo "⬇️ Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "⚠️ Complete installation, then re-run this script."
  exit 1
else
  echo "✅ Xcode CLI Tools installed"
fi

# --------------------------------------------------
# 1. Homebrew Installation
# --------------------------------------------------
if ! command -v brew &>/dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Ensure brew works (Intel + Apple Silicon)
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"

echo "✅ Homebrew ready"
brew update

# --------------------------------------------------
# 2. Install Core Packages
# --------------------------------------------------
brew install git curl wget

# --------------------------------------------------
# 3. NVM + Node (LTS)
# --------------------------------------------------
if [ ! -d "$HOME/.nvm" ]; then
  echo "⬇️ Installing NVM..."
  brew install nvm
  mkdir -p ~/.nvm
fi

export NVM_DIR="$HOME/.nvm"
source "$(brew --prefix nvm)/nvm.sh"

if ! command -v node &>/dev/null; then
  echo "⬇️ Installing Node LTS..."
  nvm install --lts
  nvm use --lts
else
  echo "✅ Node installed: $(node -v)"
fi

# --------------------------------------------------
# 4. MongoDB
# --------------------------------------------------
if ! command -v mongod &>/dev/null; then
  echo "⬇️ Installing MongoDB..."
  brew tap mongodb/brew
  brew install mongodb-community@7.0
  brew services start mongodb/brew/mongodb-community@7.0
else
  echo "✅ MongoDB already installed"
fi

# --------------------------------------------------
# 5. mongosh
# --------------------------------------------------
if ! command -v mongosh &>/dev/null; then
  echo "⬇️ Installing mongosh..."
  brew install mongosh
fi

# --------------------------------------------------
# 6. Global npm tools (safe path)
# --------------------------------------------------
echo "⬇️ Installing global npm tools..."

mkdir -p ~/.npm-global
npm config set prefix "${HOME}/.npm-global"
export PATH="$HOME/.npm-global/bin:$PATH"

npm install -g \
  prettier \
  eslint \
  nodemon \
  typescript \
  yarn \
  firebase-tools

# --------------------------------------------------
# 7. Docker
# --------------------------------------------------
if [ ! -d "/Applications/Docker.app" ]; then
  echo "⬇️ Installing Docker Desktop..."
  brew install --cask docker
  echo "⚠️ Open Docker.app after install to finish setup"
else
  echo "✅ Docker already installed"
fi

# --------------------------------------------------
# 8. Supabase CLI
# --------------------------------------------------
if ! command -v supabase &>/dev/null; then
  echo "⬇️ Installing Supabase CLI..."
  brew install supabase/tap/supabase
else
  echo "✅ Supabase CLI installed"
fi

# --------------------------------------------------
# 9. IDEs
# --------------------------------------------------
if [ ! -d "/Applications/iTerm.app" ]; then
  brew install --cask iterm2
fi

if [ ! -d "/Applications/Visual Studio Code.app" ]; then
  brew install --cask visual-studio-code
fi

# --------------------------------------------------
# 10. Git Configuration
# --------------------------------------------------
if ! git config --global user.name &>/dev/null; then
  echo "🔧 Setting up Git..."

  read -p "Enter your Git name: " git_name
  read -p "Enter your Git email: " git_email

  git config --global user.name "$git_name"
  git config --global user.email "$git_email"

  git config --global init.defaultBranch main
  git config --global pull.rebase false
  git config --global core.editor "code --wait"

  echo "✅ Git configured"
else
  echo "✅ Git already configured"
fi

# --------------------------------------------------
# 11. Oh My Zsh
# --------------------------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "⬇️ Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "✅ Oh My Zsh installed"
fi

ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# Plugins
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

# --------------------------------------------------
# 12. Firebase Check
# --------------------------------------------------
if command -v firebase &>/dev/null; then
  echo "✅ Firebase CLI ready"
fi

# --------------------------------------------------
# 13. Final Output
# --------------------------------------------------
echo ""
echo "📦 Installed Versions:"
echo "Node: $(node -v)"
echo "npm: $(npm -v)"
echo "mongod: $(mongod --version | head -n 1)"
echo "mongosh: $(mongosh --version)"
echo "Docker: Installed"
echo "Firebase: $(firebase --version)"
echo "Supabase: $(supabase --version)"
echo "Git: $(git --version)"

echo ""
echo "⚠️ FINAL STEPS:"
echo "1. Open Docker.app"
echo "2. Open VSCode → enable 'code' command"
echo "3. Add to ~/.zshrc:"
echo "   plugins=(git zsh-autosuggestions zsh-syntax-highlighting)"
echo "4. Run: source ~/.zshrc"

echo ""
echo "🎉 Setup complete. System is ready."
