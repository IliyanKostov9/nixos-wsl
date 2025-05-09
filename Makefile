.PHONY: build sys-update home-update
build: sys-update home-update

sys-update:
	sudo nixos-rebuild switch --flake .#nixos --show-trace --impure

home-update:  ## Build home configuration for default user
	home-manager switch --flake .#$(shell whoami) --show-trace --impure |& nom
#	tmux source-file ~/.config/tmux/tmux.conf 

.PHONY: flake-update
flake-update:
	nix flake update |& nom

