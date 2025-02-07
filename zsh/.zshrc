# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"
# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
plugins=(
	git
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias k="kubectl"
alias docker-compose="podman-compose"
alias tlqc="telepresence quit && telepresence connect"

wpo () {
	local default_name_space="default"
	local pod=$1
	local ns=$2
	if [ -z "$ns" ]
	then
	  watch "kubectl get po | grep $pod"
  else
	  watch "kubectl get po -n $ns | grep $pod"
	fi
}

prt-fw () {
	local default_name_space="default"
	local dp=$1
	local local_port=$2
	local dp_port=$3
	local ns=$4
	if [ -z "$ns" ]
	then
		ns=$default_name_space
	fi
	kubectl port-forward deployment/$dp $local_port:$dp_port --namespace="$ns"
}

gitPersonal() {
	git config core.sshCommand 'ssh -i ~/.ssh/personal_id_rsa'
}

ct-auth-ar() {
  local token=$(gcloud auth print-access-token)
  echo ${token} | podman login https://asia-docker.pkg.dev \
--username=oauth2accesstoken \
--password-stdin

}

PS1='$(kube_ps1)'$PS1

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/hieu.letrong/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/hieu.letrong/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/hieu.letrong/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/hieu.letrong/google-cloud-sdk/completion.zsh.inc'; fi

#brew
export HOMEBREW_NO_AUTO_UPDATE=1
export PATH=/opt/homebrew/bin:$PATH
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
# kubectl autocomplete
autoload -Uz compinit
compinit
source <(kubectl completion zsh)

source "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source <(fzf --zsh)

# forge autocomplete
forge completions zsh > /opt/homebrew/completions/zsh/_forge
cast completions zsh > /opt/homebrew/completions/zsh/_cast
anvil completions zsh > /opt/homebrew/completions/zsh/_anvil

#GKE plugin
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
#export GOBIN
#export PATH="$PATH:$(go env GOPATH)/bin"
eval "$(fnm env --use-on-cd)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GOPROXY=direct
export GOSUMDB=off
export GOPRIVATE=github.com/carousell/*
