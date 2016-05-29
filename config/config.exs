use Mix.Config

config :authy,
  api_key: System.get_env("AUTHY_API_KEY")
