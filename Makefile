##########################
# TARGET
# #######################

.PHONY: help
help:  ## help target to show available commands with information
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) |  awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: build sys-update home-update
build: sys-update home-update

sys-update:
	sudo nixos-rebuild switch --flake .#nixos --show-trace --impure

home-update:  ## Build home configuration for default user
	home-manager switch --flake .#$(shell whoami) --show-trace --impure |& nom
#	tmux source-file ~/.config/tmux/tmux.conf 

.PHONY: clean clean-sys clean-usr optimise
clean: clean-sys clean-usr optimise

clean-usr : ## Remove old user generations
	nix-collect-garbage -d |& nom

clean-sys: ## Remove old system generations
	sudo -v && sudo nix-collect-garbage -d |& nom

optimise: ## Optimize nix store by making each package unique. Warning: The operation is resource intensive
	nix store optimise

.PHONY: flake flake-check flake-upgrade flake-meta
flake: 
	$(MAKE) --no-print-directory help

flake-check: ## Evaluate flake and build its checks
	nix flake check -L |& nom

flake-upgrade:  ## Upgrade flake related dependencies
	nix flake update |& nom

flake-meta: ## Check flake deps
	nix flake metadata |& nom

