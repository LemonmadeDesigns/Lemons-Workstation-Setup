#!/usr/bin/env bash
#
# setup.sh: Standalone developer environment bootstrap script for macOS
# by Mr. Lemons (Updated)
#

# Exit immediately if any command fails
set -e

echo "🔐 Requesting sudo access to start setup..."
sudo -K
sudo true
clear

echo "🚀 Starting setup for your macOS development workstation..."

# --------------------------------------------------
# 0. Ensure Xcode Command Line Tools are installed
# --------------------------------------------------
# Required for git, compilers, and Homebrew
if ! xcode-select -p &>/dev/null; then
  echo "⬇️ Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "⚠️ Please complete the installation, then re-run this script."
  exit 1
else
  echo "✅ Xcode Command Line Tools already installed"
fi

# --------------------------------------------------
# 1. Install Homebrew if not already installed
# --------------------------------------------------
if ! command -v brew &>/dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# --------------------------------------------------
# 1.1 Add Homebrew to PATH (Apple Silicon + Intel safe)
# --------------------------------------------------
# Ensures brew works immediately after install
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"

echo "✅ Homebrew ready"

# --------------------------------------------------
# 2. Update Homebrew
# --------------------------------------------------
brew update

# --------------------------------------------------
# 3. Install NVM (better than raw Node install)
# --------------------------------------------------
if [ ! -d "$HOME/.nvm" ]; then
  echo "⬇️ Installing NVM (Node Version Manager)..."
  brew install nvm
  mkdir -p ~/.nvm
else
  echo "✅ NVM already installed"
fi

# Load NVM into current shell
export NVM_DIR="$HOME/.nvm"
source "$(brew --prefix nvm)/nvm.sh"

# Install latest LTS Node
if ! command -v node &>/dev/null; then
  echo "⬇️ Installing Node.js (LTS)..."
  nvm install --lts
  nvm use --lts
else
  echo "✅ Node already installed: $(node -v)"
fi

# --------------------------------------------------
# 4. Install MongoDB Community Edition
# --------------------------------------------------
if ! command -v mongod &>/dev/null; then
  echo "⬇️ Installing MongoDB Community..."
  brew tap mongodb/brew
  brew install mongodb-community@7.0
  brew services start mongodb/brew/mongodb-community@7.0
else
  echo "✅ MongoDB already installed"
fi

# --------------------------------------------------
# 5. Install mongosh
# --------------------------------------------------
if ! command -v mongosh &>/dev/null; then
  echo "⬇️ Installing mongosh..."
  brew install mongosh
else
  echo "✅ mongosh already installed"
fi

# --------------------------------------------------
# 6. Install global dev tools (safe mode)
# --------------------------------------------------
echo "⬇️ Installing global npm packages..."

# Avoid permission issues by ensuring npm uses user directory
npm config set prefix "${HOME}/.npm-global"
export PATH="${HOME}/.npm-global/bin:$PATH"

npm install -g \
  prettier \
  eslint \
  nodemon \
  typescript \
  yarn

# --------------------------------------------------
# 7. Install iTerm2
# --------------------------------------------------
if [ ! -d "/Applications/iTerm.app" ]; then
  echo "⬇️ Installing iTerm2..."
  brew install --cask iterm2
else
  echo "✅ iTerm2 already installed"
fi

# --------------------------------------------------
# 8. Install Visual Studio Code
# --------------------------------------------------
if [ ! -d "/Applications/Visual Studio Code.app" ]; then
  echo "⬇️ Installing Visual Studio Code..."
  brew install --cask visual-studio-code
else
  echo "✅ VSCode already installed"
fi

# --------------------------------------------------
# 9. (Optional) Windsurf IDE — SKIPPED for security
# --------------------------------------------------
echo "⚠️ Windsurf install skipped (unverified source). Install manually if needed."

# --------------------------------------------------
# 10. Output tool versions
# --------------------------------------------------
echo ""
echo "📦 Installed Versions:"
echo "Node:     $(node -v)"
echo "npm:      $(npm -v)"
echo "mongod:   $(mongod --version | head -n 1)"
echo "mongosh:  $(mongosh --version)"
echo "Prettier: $(prettier --version)"
echo "ESLint:   $(eslint -v)"
echo "Nodemon:  $(nodemon -v)"
echo "TSC:      $(tsc -v)"
echo "Yarn:     $(yarn -v)"
echo "VSCode:   Installed"
echo "iTerm2:   Installed"

echo ""
echo "🎉 Setup complete! Your workstation is locked, loaded, and ready to build something serious."
