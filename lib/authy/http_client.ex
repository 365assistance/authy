defmodule Authy.HTTPClient do
  @type headers :: [{binary, binary}] | %{binary => binary}
  @type body :: binary | {:form, [{atom, any}]} | {:file, binary}

  @callback post!(binary, body, headers, Keyword.t()) :: HTTPoison.Response.t()
  @callback get!(binary, headers, Keyword.t()) :: HTTPoison.Response.t()
end
