SHELL := /bin/bash

tests:
	symfony console doctrine:fixtures:load -n
	symfony run bin/phpunit
.PHONY: tests
