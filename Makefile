.PHONY: setup-bash setup-zsh setup-commons test

setup-bash:
	bash scripts/setup_bashrc.sh

setup-zsh:
	bash scripts/setup_zshrc.sh

setup-commons:
	bash scripts/setup_commons.sh

test:
	bash tests/01-test-estructura.sh
	bash tests/02-test-setup-bashrc.sh
	bash tests/03-test-setup-zshrc.sh
	bash tests/04-test-setup-commons.sh
	bash tests/05-test-init-repo.sh
