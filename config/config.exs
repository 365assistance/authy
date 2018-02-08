use Mix.Config

config :authy,
  api_key: System.get_env("AUTHY_API_KEY"),
  phone_verification: [via: :sms, country_code: 61]

import_config "#{Mix.env()}.exs"
