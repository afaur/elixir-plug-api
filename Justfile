LAB_DIR          = cd .lab
CONF_DIR         = ../conf
PRIV_SAMPLE_FILE = private_sample.exs
PRIV_FILE        = private.exs

default: build

ci:
	@${LAB_DIR} && mix local.rebar --force
	@${LAB_DIR} && mix local.hex --force
	@${LAB_DIR} && cp ${CONF_DIR}/${PRIV_SAMPLE_FILE} ${CONF_DIR}/${PRIV_FILE}

deps:
	@${LAB_DIR} && mix deps.get

build:
	@${LAB_DIR} && mix

run:
	@${LAB_DIR} && iex -S mix run --no-halt

test:
	@${LAB_DIR} && mix test
