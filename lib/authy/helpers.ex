defmodule Authy.Helpers do
  @moduledoc """
  Helpers for working with Authy requests and responses
  """

  @doc """
  Parses a %HTTPoison struct and return a simplified value

  iex> Authy.Helpers.parse_response(%HTTPoison.Response{body: %{"success" => true, "message" => "Text message sent to +61 47-777-7777."}})
  {:ok, "Text message sent to +61 47-777-7777."}

  iex> Authy.Helpers.parse_response(%HTTPoison.Response{body: %{"success" => false, "message" => "Phone verification couldn't be created: Phone number is invalid"}})
  {:error, "Phone verification couldn't be created: Phone number is invalid"}
  """
  @spec parse_response(HTTPoison.Response.t()) :: Authy.response()
  def parse_response(%HTTPoison.Response{body: %{"success" => true, "message" => message}}) do
    {:ok, message}
  end

  def parse_response(%HTTPoison.Response{body: %{"success" => false, "message" => message}}) do
    {:error, message}
  end
end
