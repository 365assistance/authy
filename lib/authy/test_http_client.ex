defmodule Authy.TestHTTPClient do
  @behaviour Authy.HTTPClient

  def post!(url, body, headers \\ [], params \\ []) do
    Kernel.send(self(), {:post!, url, body, headers, params})
    %HTTPoison.Response{body: %{"success" => true, "message" => "201"}}
  end

  def get!(url, headers \\ [], params) do
    Kernel.send(self(), {:get!, url, headers, params})
    %HTTPoison.Response{body: %{"success" => true, "message" => "200"}}
  end
end
