[![Build Status](https://travis-ci.org/afaur/elixir-plug-api.svg?branch=master)](https://travis-ci.org/afaur/elixir-plug-api)

## Project Overview
  - Exposes one `GET` route
    - GET `/api/users` returns `200 OK` result of `["Mary", "John", "Jill"]`
  - Includes e2e test to check that the endpoint responds correctly
  - Uses four dependencies
    - [Cowboy](https://github.com/ninenines/cowboy)
      - Small Fast Http2 / Websocket Server
    - [Plug](https://github.com/elixir-plug/plug)
      - Middleware / Composable Modules 
    - [Poison](https://github.com/devinus/poison)
      - JSON Encoding / Decoding
    - [HTTPoison](https://github.com/edgurgel/httpoison)
      - Testing Endpoints (Elixir CURL / Fetch)
      - Uses binaries instead of string lists
    - These deps do have [sub deps](https://github.com/afaur/elixir-plug-api/blob/master/.lab/mix.lock)
      - Goal is to minimize dep reliance as much as possible
    - This branch adds the new relic agent as an additional dependency
      - Follow this [guide to configure it](https://github.com/newrelic/elixir_agent#via-application-config)

## Organization
  - Uses a `.lab` folder, a `Makefile`, and a `Justfile`
    - `.lab` contains all `mix new` generated files / folders
    - Uses symlinks to / from `.lab` to simplify organization
    - Has a `Makefile` and `Justfile` to manage project commands

## Laboratory Folder
  - Allows important folders / files to stay in the primary project dir
    - `.lab` folder is short for `laboratory` (where we `mix` our `elixir` :D)
      - `src` folder is linked to the `lib` folder in `.lab`
      - `conf` folder contains both the:
        - `mix.exs` from the root of `.lab` folder
        - `config.exs` from the `config` dir of `.lab` folder
      - `test` folder is linked to the `test` folder in `.lab`

## Install Elixir
  - [OSX](https://elixir-lang.org/install.html#mac-os-x)
  - [Linux](https://elixir-lang.org/install.html#unix-and-unix-like)
  - [Windows](https://elixir-lang.org/install.html#windows)

## Using Make / Just
  - This project uses `Make` or `Just` to simplify `mix` and `iex` commands
  - If using `just`, replace all commands starting with `make` to `just`

## Installing Make / Just
  - Having either one on your machine will work and setup is easy
    - OSX / Linux
      - By default you should already have `make` on your machine
      - If you want to install `just` you can get it here
        - [Just Github Repository](https://github.com/casey/just)
      - On OSX you can run `brew install just`
    - Windows
      - Make doesn't come by default 
        - [Using Make On Windows](https://stackoverflow.com/questions/12881854/how-to-use-gnu-make-on-windows)
      - If you want to install `just` you can get it here
        - [Just Github Repository](https://github.com/casey/just)

## Install Dependencies
  - `make deps`
    - See code in `conf/mix.exs`

## Build Project
  - `make build`
    - See code in `conf/*.exs`

## Running Project
  - Start the server
    - `make run`
  - See code in `src/*.ex`

## Testing
  - How to test either manually or automatically
  ### Manual Testing
  - After running `make run` you can either:
    - Use CURL
      - `curl -v "http://127.0.0.1:8085/api/users"`
    - Use Browser
      - `open http://127.0.0.1:8085/api/users`
  ### Automatic Testing
  - ExUnit
    - `make test`
      - Runs project and asserts correct response is returned
      - See code in `test/http_app_test.ex`
