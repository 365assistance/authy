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

  @doc """
  Request a verification token be sent to a user

  params map must include :phone_number
  :via and :country_code are also required but may be specified in config
  :locale and :custom_message are optional and may be specified in config

  post_fn replaces the actual call to Authy.post
  """
  def start(params, post_fn \\ &post_start/1)
  def start(params = %{phone_number: _}, post_fn) do
    params
    |> set_defaults
    |> Map.take([:via, :phone_number, :country_code, :locale, :custom_message])
    |> post_fn.()
  end

  defp post_start(params = %{via: via, phone_number: _, country_code: _}) when via in [:sms, "sms", :call, "call"] do
    Authy.post(@base_url <> "/start", params)
  end

  defp set_defaults(params) do
    Application.get_env(:authy, :phone_verification, [])
    |> Dict.take([:via, :country_code, :locale, :custom_message])
    |> Dict.merge(params)
    |> Enum.into(%{})
  end
end
