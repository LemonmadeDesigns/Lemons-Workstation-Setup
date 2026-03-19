#!/usr/bin/env bash
#
# setup.sh: Universal macOS Developer Environment Bootstrap (Configurable)
# by Mr. Lemons
#

set -e

echo "🔐 Requesting sudo access..."
sudo -K
sudo true
clear

echo "🚀 Starting macOS development environment setup..."

# --------------------------------------------------
# LOAD ENV CONFIG (OPTIONAL)
# --------------------------------------------------
# Supports team-level overrides via .env file
if [ -f ".env" ]; then
  echo "📦 Loading configuration from .env..."
  export $(grep -v '^#' .env | xargs)
fi

# --------------------------------------------------
# DEFAULT CONFIG (SAFE FALLBACKS)
# --------------------------------------------------
NODE_VERSION="${NODE_VERSION:-20}"
INSTALL_DOCKER="${INSTALL_DOCKER:-true}"
INSTALL_SUPABASE="${INSTALL_SUPABASE:-true}"
INSTALL_FIREBASE="${INSTALL_FIREBASE:-true}"
INSTALL_MONGODB="${INSTALL_MONGODB:-true}"

# --------------------------------------------------
# 0. Xcode Command Line Tools
# --------------------------------------------------
if ! xcode-select -p &>/dev/null; then
  echo "⬇️ Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "⚠️ Complete installation, then re-run script."
  exit 1
else
  echo "✅ Xcode CLI Tools ready"
fi

# --------------------------------------------------
# 1. Homebrew
# --------------------------------------------------
if ! command -v brew &>/dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Load brew into environment (Intel + Apple Silicon)
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"

brew update
echo "✅ Homebrew ready"

# --------------------------------------------------
# 2. Core Packages
# --------------------------------------------------
brew install git curl wget

# --------------------------------------------------
# 3. NVM + Node (VERSION CONTROLLED)
# --------------------------------------------------
if [ ! -d "$HOME/.nvm" ]; then
  echo "⬇️ Installing NVM..."
  brew install nvm
  mkdir -p ~/.nvm
fi

export NVM_DIR="$HOME/.nvm"
source "$(brew --prefix nvm)/nvm.sh"

echo "⬇️ Installing Node version: $NODE_VERSION"
nvm install $NODE_VERSION
nvm use $NODE_VERSION
nvm alias default $NODE_VERSION

# Persist NVM in shell
if ! grep -q 'NVM_DIR' ~/.zshrc; then
  echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
  echo '[ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"' >> ~/.zshrc
fi

# --------------------------------------------------
# 4. MongoDB (Optional)
# --------------------------------------------------
if [ "$INSTALL_MONGODB" = true ]; then
  if ! command -v mongod &>/dev/null; then
    echo "⬇️ Installing MongoDB..."
    brew tap mongodb/brew
    brew install mongodb-community@7.0
    brew services start mongodb/brew/mongodb-community@7.0
  else
    echo "✅ MongoDB already installed"
  fi
fi

# --------------------------------------------------
# 5. mongosh
# --------------------------------------------------
if [ "$INSTALL_MONGODB" = true ]; then
  if ! command -v mongosh &>/dev/null; then
    brew install mongosh
  fi
fi

# --------------------------------------------------
# 6. Global npm Tools (SAFE PATH)
# --------------------------------------------------
mkdir -p ~/.npm-global
npm config set prefix "${HOME}/.npm-global"

if ! grep -q '.npm-global/bin' ~/.zshrc; then
  echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.zshrc
fi

export PATH="$HOME/.npm-global/bin:$PATH"

echo "⬇️ Installing global dev tools..."
npm install -g prettier eslint nodemon typescript yarn

if [ "$INSTALL_FIREBASE" = true ]; then
  npm install -g firebase-tools
fi

# --------------------------------------------------
# 7. Docker (Optional but Recommended)
# --------------------------------------------------
if [ "$INSTALL_DOCKER" = true ]; then
  if [ ! -d "/Applications/Docker.app" ]; then
    echo "⬇️ Installing Docker Desktop..."
    brew install --cask docker
    echo "⚠️ Open Docker.app after install"
  else
    echo "✅ Docker already installed"
  fi
fi

# --------------------------------------------------
# 8. Supabase CLI (Optional)
# --------------------------------------------------
if [ "$INSTALL_SUPABASE" = true ]; then
  if ! command -v supabase &>/dev/null; then
    brew install supabase/tap/supabase
  else
    echo "✅ Supabase CLI installed"
  fi
fi

# --------------------------------------------------
# 9. IDEs
# --------------------------------------------------
[ -d "/Applications/iTerm.app" ] || brew install --cask iterm2
[ -d "/Applications/Visual Studio Code.app" ] || brew install --cask visual-studio-code

# --------------------------------------------------
# 10. Git (RESPECT EXISTING CONFIG)
# --------------------------------------------------
if ! git config --global user.name &>/dev/null; then
  echo "🔧 Git not configured. Applying defaults..."
  git config --global init.defaultBranch main
  git config --global pull.rebase false
  git config --global core.editor "code --wait"

  echo "⚠️ Set your Git identity:"
  echo "git config --global user.name \"Your Name\""
  echo "git config --global user.email \"your@email.com\""
else
  echo "✅ Git already configured"
fi

# --------------------------------------------------
# 11. Zsh + Plugins
# --------------------------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "⬇️ Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || \
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] || \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# Enforce plugins
if ! grep -q "zsh-autosuggestions" ~/.zshrc; then
  sed -i '' 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
fi

# --------------------------------------------------
# 12. Final Output
# --------------------------------------------------
echo ""
echo "📦 Environment Summary:"
echo "Node: $(node -v)"
echo "npm: $(npm -v)"
[ "$INSTALL_MONGODB" = true ] && echo "MongoDB: $(mongod --version | head -n 1)"
[ "$INSTALL_DOCKER" = true ] && echo "Docker: Installed"
[ "$INSTALL_FIREBASE" = true ] && echo "Firebase: $(firebase --version)"
[ "$INSTALL_SUPABASE" = true ] && echo "Supabase: $(supabase --version)"
echo "Git: $(git --version)"

echo ""
echo "⚠️ FINAL STEPS:"
echo "1. Open Docker (if installed)"
echo "2. Enable VS Code CLI (Cmd+Shift+P → 'code')"
echo "3. Restart terminal or run: source ~/.zshrc"

echo ""
echo "🎉 Setup complete."
