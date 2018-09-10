.PHONY: run, build, test

default: build

ci:
	@cd .lab && mix local.rebar --force
	@cd .lab && mix local.hex --force

deps:
	@cd .lab && mix deps.get

build:
	@cd .lab && mix

run:
	@cd .lab && iex -S mix run --no-halt

test:
	@cd .lab && mix test
