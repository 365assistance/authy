defmodule Authy do
  @defmodule """
  Client for the Authy HTTP API

  See https://docs.authy.com/api_docs.html
  """
  use HTTPoison.Base
  @base_uri %{scheme: "https", authority: nil, host: "api.authy.com", port: 443}

  @doc """
  Sets the correct base url and correct API key in the query string

  iex> Application.put_env(:authy, :api_key, "supersecret")
  iex> Authy.process_url("/some-endpoint")
  "#{@base_uri.scheme}://#{@base_uri.host}/some-endpoint?api_key=supersecret"

  iex> Application.put_env(:authy, :api_key, "supersecret")
  iex> Authy.process_url("http://wrong-domain.com/some-endpoint?api_key=wrong_api_key")
  "#{@base_uri.scheme}://#{@base_uri.host}/some-endpoint?api_key=supersecret"

  """
  def process_url(url) do
    URI.parse(url)
    |> Map.merge(@base_uri)
    |> Map.update!(:query, &add_api_key/1)
    |> URI.to_string
  end

  defp api_key do
    Application.get_env(:authy, :api_key)
  end

  defp add_api_key(nil), do: add_api_key("")
  defp add_api_key(query) do
    query
    |> URI.decode_query
    |> Map.put("api_key", api_key)
    |> URI.encode_query
  end
end
