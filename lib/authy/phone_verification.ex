defmodule Authy.PhoneVerification do
  @moduledoc """
  Access to the Authy Phone Verification API

  See: https://docs.authy.com/phone_verification.html

  Defaults for :via, :country_code, :locale, and :custom_message can be set in config:

  ```
  config :authy,
    phone_verification: [
      via: "sms",
      country_code: "61",
      locale: "en-AU",
      custom_message: "Verification code, yo!"]
  ```
  """

  @base_url "/protected/json/phones/verification"

  defp set_defaults(params) do
    Application.get_env(:authy, :phone_verification, [])
    |> Dict.take([:via, :country_code, :locale, :custom_message])
    |> Dict.merge(params)
    |> Enum.into(%{})
  end
end
