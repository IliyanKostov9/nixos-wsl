.PHONY: build
build:
	sudo nixos-rebuild switch

.PHONY: update
update:
	sudo nixos-rebuild switch --flake .#nixos --show-trace --impure

