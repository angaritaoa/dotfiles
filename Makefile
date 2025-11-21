PWD=$(shell pwd)

.PHONY: brew
brew:
	xcode-select --install
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

.PHONY: dotfiles
dotfiles:
	ln -fns ${PWD}/zshrc ~/.zshrc
	ln -fns ${PWD}/gitconfig ~/.gitconfig
	eval "$(/opt/homebrew/bin/brew shellenv)"

.PHONY: macos
macos:
	brew update
	brew upgrade
	brew install tree p7zip xz gzip exa ripgrep grep exa zstd fd sqlite hub gpg2 coreutils \
		gnu-tar direnv libtool git-delta universal-ctags shellcheck aspell languagetool \
		clang-format google-java-format pandoc


.PHONY: emacs
emacs:
#	brew tap d12frosted/emacs-plus
#	brew install emacs-plus --with-native-comp
#	brew install emacs-plus
	rm -rf ~/.emacs.d
	ln -fns ${PWD}/doom.d ~/.doom.d
	git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
	~/.emacs.d/bin/doom install
	~/.emacs.d/bin/doom sync
	~/.emacs.d/bin/doom doctor
