ifeq ($(shell uname),Darwin)
SED = /usr/bin/sed -i '' -e
else
SED = sed -i -e
endif

actualEnv = ./conf/.env
sampleEnv = "${actualEnv}_sample"

ConfEnvReq = $(shell grep -ic -e "_CF_PORT" ${actualEnv})

CFSetText  = Enter your Server
CFPortNum  = printf "${CFSetText} Port Number: "
CFSetPort  = read CFV && ${SED} "s/_CF_PORT/$$CFV/" ${actualEnv}
CFReadPort = (${CFPortNum} && ${CFSetPort})

LAB = cd .lab

default: build

ci:
	@${LAB} && mix local.rebar --force
	@${LAB} && mix local.hex --force
	@cp ${sampleEnv} ${actualEnv}

maybeMakeEnv:
	@[[ -f ${actualEnv} ]] || (cp ${sampleEnv} ${actualEnv})

maybeConfEnv:
	@[[ ${ConfEnvReq} -gt 0 ]] || (echo "Error: Env Already configured" && exit 1)

config:
	@make maybeMakeEnv
	@make maybeConfEnv
	@${CFReadPort}
	@echo "Settings saved to ${actualEnv}"

deps:
	@${LAB} && mix deps.get

build:
	@${LAB} && . "../${actualEnv}" && mix

run:
	@${LAB} && . "../${actualEnv}" && iex -S mix run --no-halt

test:
	@${LAB} && . "../${actualEnv}" && mix test
