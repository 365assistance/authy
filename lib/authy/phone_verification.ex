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
  @callback start(map) :: Authy.response
  @callback check(map) :: Authy.response

  import Authy.Helpers, only: [parse_response: 1]
  @base_url "/protected/json/phones/verification"
  @http_client Application.get_env(:authy, :http_client, Authy)

  @doc """
  Request a verification token be sent to a user

  params map must include :phone_number
  :via and :country_code are also required but may be specified in config
  :locale and :custom_message are optional and may be specified in config
  """
  def start(params = %{phone_number: _}) do
    params
    |> set_defaults
    |> Map.take([:via, :phone_number, :country_code, :locale, :custom_message])
    |> post_start
  end

  defp post_start(params = %{via: via, phone_number: _, country_code: _}) when via in [:sms, "sms", :call, "call"] do
    @http_client.post!(@base_url <> "/start", params) |> parse_response
  end

  @doc """
  Check the validity of a verification token

  params map must include :phone_number and :verification_code
  :country_code is also required but may be specified in config
  """
  def check(params = %{phone_number: _, verification_code: _}) do
    params
    |> set_defaults
    |> Map.take([:phone_number, :country_code, :verification_code])
    |> get_check
  end

  defp get_check(params = %{phone_number: _, country_code: _, verification_code: _}) do
    @http_client.get!(@base_url <> "/check", [], params: params) |> parse_response
  end

  defp set_defaults(params) do
    Application.get_env(:authy, :phone_verification, [])
    |> Enum.into(%{})
    |> Map.take([:via, :country_code, :locale, :custom_message])
    |> Map.merge(params)
  end
end
