# Authy

Elixir library access to the Authy API, based on the [ruby gem](https://github.com/authy/authy-ruby).

## Features

- [ ] Phone Verification

## Installation

1. Add authy to your list of dependencies in `mix.exs`:

```
def deps do
  [{:authy, github: "365assistance/authy"}]
end
```

2. Ensure authy is started before your application:

```
def application do
  [applications: [:authy]]
end
```

3. Add your authy api key to config

```
config :authy,
  api_key: System.get_env("AUTHY_API_KEY")
```
