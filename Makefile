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


.PHONY: clean clean-sys clean-usr optimise
clean: clean-sys clean-usr optimise

clean-usr : ## Remove old user generations
	nix-collect-garbage -d |& nom

clean-sys: ## Remove old system generations
	sudo -v && sudo nix-collect-garbage -d |& nom

optimise: ## Optimize nix store by making each package unique. Warning: The operation is resource intensive
	nix store optimise

