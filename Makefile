.PHONY: config, ci, deps, build, run, test

LAB_DIR  = cd .lab
BIN_DIR  = ./bin
CONF_DIR = ../conf
ENV_FILE = .env
SET_ENV  = . ${CONF_DIR}/${ENV_FILE}

default: build

ci:
	@${LAB_DIR} && mix local.rebar --force
	@${LAB_DIR} && mix local.hex --force
	@${LAB_DIR} && cp ${CONF_DIR}/${ENV_FILE}_sample ${CONF_DIR}/${ENV_FILE}

config:
	@${LAB_DIR} && ${BIN_DIR}/config

deps:
	@${LAB_DIR} && mix deps.get

build:
	@${LAB_DIR} && ${SET_ENV} && mix

run:
	@${LAB_DIR} && ${SET_ENV} && iex -S mix run --no-halt

test:
	@${LAB_DIR} && ${SET_ENV} && mix test
