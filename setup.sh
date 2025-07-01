#!/usr/bin/env bash
#
# setup.sh: Standalone developer environment bootstrap script for macOS
#

# Stop on first error
set -e

echo "🔐 Requesting sudo access to start setup..."
sudo -K
sudo true
clear

echo "🚀 Starting setup for your macOS development workstation..."

# 1. Install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "✅ Homebrew already installed"
fi

# 2. Update Homebrew
brew update

# 3. Install Node.js (includes npm + npx)
if ! command -v node &>/dev/null; then
  echo "⬇️ Installing Node.js..."
  brew install node
else
  echo "✅ Node.js already installed: $(node -v)"
fi

# 4. Install MongoDB Community Edition
if ! command -v mongod &>/dev/null; then
  echo "⬇️ Installing MongoDB Community..."
  brew tap mongodb/brew
  brew install mongodb-community
  brew services start mongodb/brew/mongodb-community
else
  echo "✅ MongoDB already installed: $(mongod --version | head -n 1)"
fi

# 5. Install mongosh (MongoDB shell)
if ! command -v mongosh &>/dev/null; then
  echo "⬇️ Installing mongosh..."
  brew install mongosh
else
  echo "✅ mongosh already installed: $(mongosh --version)"
fi

# 6. Install common global dev tools
echo "⬇️ Installing global npm packages..."
npm install -g prettier eslint nodemon typescript yarn

# 7. Output tool versions
echo ""
echo "📦 Installed Versions:"
echo "Node:     $(node -v)"
echo "npm:      $(npm -v)"
echo "npx:      $(npx -v)"
echo "mongod:   $(mongod --version | head -n 1)"
echo "mongosh:  $(mongosh --version)"
echo "Prettier: $(prettier --version)"
echo "ESLint:   $(eslint -v)"
echo "Nodemon:  $(nodemon -v)"
echo "TSC:      $(tsc -v)"
echo "Yarn:     $(yarn -v)"

echo ""
echo "🎉 Setup complete, Mr. Lemons. You're ready to build something legendary."

