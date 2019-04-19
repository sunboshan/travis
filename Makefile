TOP_DIR=.
VERSION=$(strip $(shell cat version))

dep:
	@echo "Install dependencies required for this repo..."
	@mix deps.get

build:
	@echo "Building the software..."
	@mix format; mix compile

run:
	@echo "Running the software..."
	@iex -S mix

test:
	@echo "Running test suites..."
	@mix test

travis-init:
	@echo "Initialize software required for travis (normally ubuntu software)"

travis-libsecp:
	ls -lah /usr/local/Cellar
	rm /usr/local/lib/libgmp.dylib
	HOMEBREW_NO_AUTO_UPDATE=1 brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/438814082094bdac172648b5efa03f2596d46f38/Formula/erlang.rb --ignore-dependencies # erlang 21.3.5
	HOMEBREW_NO_AUTO_UPDATE=1 brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/c19ee54756997f56ea407d0817a8c33213b2e10b/Formula/elixir.rb --ignore-dependencies # elixir 1.8.1
	erl -version
	elixir --version
	brew list --versions
	mix local.hex --force
	mix local.rebar --force
	mix do deps.get, deps.compile
	otool -L deps/libsecp256k1/priv/libsecp256k1_nif.so

travis-rocksdb:
	rm /usr/local/lib/libzstd.dylib
	HOMEBREW_NO_AUTO_UPDATE=1 brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/438814082094bdac172648b5efa03f2596d46f38/Formula/erlang.rb --ignore-dependencies # erlang 21.3.5
	HOMEBREW_NO_AUTO_UPDATE=1 brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/c19ee54756997f56ea407d0817a8c33213b2e10b/Formula/elixir.rb --ignore-dependencies # elixir 1.8.1
	erl -version
	elixir --version
	mix local.hex --force
	mix local.rebar --force
	ERLANG_ROCKSDB_OPTS="-DWITH_ZSTD=ON" mix do deps.get, deps.compile
	otool -L deps/rocksdb/priv/liberocksdb.so

travis:
	HOMEBREW_NO_AUTO_UPDATE=1 brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/438814082094bdac172648b5efa03f2596d46f38/Formula/erlang.rb --ignore-dependencies # erlang 21.3.5
	erl -version
	otool -L /usr/local/opt/erlang/lib/erlang/lib/crypto-4.4.2/priv/lib/crypto.so
	erl -eval 'io:format("~p~n",[crypto:info_lib()])' -noshell -s init stop
	pwd
	cp -v priv/crypto.so /usr/local/opt/erlang/lib/erlang/lib/crypto-4.4.2/priv/lib/crypto.so
	otool -L /usr/local/opt/erlang/lib/erlang/lib/crypto-4.4.2/priv/lib/crypto.so
	erl -eval 'io:format("~p~n",[crypto:info_lib()])' -noshell -s init stop

travis-deploy: release
	@echo "Deploy the software by travis"

include .makefiles/*.mk

.PHONY: test
