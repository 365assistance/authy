defmodule Authy do
  @defmodule """
  Client for the Authy HTTP API

  See https://docs.authy.com/api_docs.html
  """
  @behaviour Authy.HTTPClient

  use HTTPoison.Base
  @base_uri %{scheme: "https", authority: nil, host: "api.authy.com", port: 443}
  @type response :: {:ok, binary} | {:error, binary}

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

  @doc """
  Forces headers to application/json for all requests

  iex> Authy.process_request_headers([{"Content-Type", "application/xml"}])
  [{"Accept", "application/json"}, {"Content-Type", "application/json"}]

  iex> Authy.process_request_headers([{"User-Agent", "HTTPoison"}])
  [{"Accept", "application/json"}, {"Content-Type", "application/json"}, {"User-Agent", "HTTPoison"}]
  """
  def process_request_headers(headers) do
    headers
    |> Enum.into(%{})
    |> Map.put("Content-Type", "application/json")
    |> Map.put("Accept", "application/json")
    |> Enum.into([])
  end

  @doc """
  Encode request body to JSON when specified as a Map
  """
  def process_request_body(body = %{}) do
    body |> Poison.encode!
  end

  def process_request_body(body) do
    body
  end

  @doc """
  Decode response body JSON
  """
  def process_response_body(body) do
    body |> Poison.decode!
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
