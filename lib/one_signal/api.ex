defmodule OneSignal.API do
  use Injector

  alias HTTPoison.Response

  inject(HTTPoison)

  @spec get(String.t(), api_key: String.t()) :: {:ok, map()} | {:error, map()}
  @spec get(String.t(), List.t(), api_key: String.t()) :: {:ok, map()} | {:error, map()}
  def get(url, query \\ [], api_key: api_key) do
    HTTPoison.start()
    query = OneSignal.Utils.encode_body(query)

    url = if String.length(query) == 0 do
      url
    else
      "#{url}?#{query}"
    end

    HTTPoison.get!(url, headers(api_key))
    |> handle_response
  end

  @spec post(String.t(), map(), api_key: String.t()) :: {:ok, map()} | {:error, map()}
  def post(url, body, api_key: api_key) do
    HTTPoison.start()

    req_body = Poison.encode!(body)

    HTTPoison.post!(url, req_body, headers(api_key))
    |> handle_response
  end

  @spec put(String.t(), map(), api_key: String.t()) :: {:ok, map()} | {:error, map()}
  def put(url, body, api_key: api_key) do
    HTTPoison.start()

    req_body = Poison.encode!(body)

    HTTPoison.put!(url, req_body, headers(api_key))
    |> handle_response
  end

  @spec delete(String.t(), api_key: String.t()) :: {:ok, map()} | {:error, map()}
  def delete(url, api_key: api_key) do
    HTTPoison.start()

    HTTPoison.delete!(url, headers(api_key))
    |> handle_response
  end

  defp handle_response(%Response{body: body, status_code: code}) when code in 200..299 do
    {:ok, Poison.decode!(body)}
  end

  defp handle_response(%Response{body: body, status_code: _}) do
    {:error, Poison.decode!(body)}
  end

  defp headers(api_key) do
    %{"Authorization" => "Basic " <> api_key, "Content-type" => "application/json"}
  end
end
