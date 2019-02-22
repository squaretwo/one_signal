defmodule OneSignal.Player do
  use Injector

  inject(OneSignal.API)

  @players "/players"

  @spec csv_export(map(), api_key: String.t()) :: {:ok, map()} | {:error, map()}
  def csv_export(), do: csv_export(%{}, [])
  def csv_export(%{} = params), do: csv_export(params, [])
  def csv_export(opts) when is_list(opts), do: csv_export(%{}, opts)
  def csv_export(%{} = params, opts) when is_list(opts) do
    api_key = Keyword.get(opts, :api_key, OneSignal.fetch_api_key())

    (OneSignal.endpoint() <> @players <> "/csv_export")
    |> API.post(params, api_key: api_key)
  end

  @spec all(map(), api_key: String.t()) :: {:ok, map()} | {:error, map()}
  def all(params \\ %{}, opts \\ []) do
    api_key = Keyword.get(opts, :api_key, OneSignal.fetch_api_key())

    (OneSignal.endpoint() <> @players)
    |> API.get(params, api_key: api_key)
  end

  @spec get(String.t(), api_key: String.t()) :: {:ok, map()} | {:error, map()}
  def get(id, opts \\ []) do
    api_key = Keyword.get(opts, :api_key, OneSignal.fetch_api_key())

    (OneSignal.endpoint() <> @players <> "/#{id}")
    |> API.get(api_key: api_key)
  end

  @spec all(map(), api_key: String.t()) :: {:ok, map()} | {:error, map()}
  def create(params, opts \\ []) do
    api_key = Keyword.get(opts, :api_key, OneSignal.fetch_api_key())

    (OneSignal.endpoint() <> @players)
    |> API.post(params, api_key: api_key)
  end

  @spec create_session(String.t(), map(), api_key: String.t()) :: {:ok, map()} | {:error, map()}
  def create_session(id, params, opts \\ []) do
    api_key = Keyword.get(opts, :api_key, OneSignal.fetch_api_key())

    (OneSignal.endpoint() <> @players <> "/#{id}" <> "/on_session")
    |> API.post(params, api_key: api_key)
  end

  @spec create_purchase(String.t(), map(), api_key: String.t()) :: {:ok, map()} | {:error, map()}
  def create_purchase(id, params, opts \\ []) do
    api_key = Keyword.get(opts, :api_key, OneSignal.fetch_api_key())

    (OneSignal.endpoint() <> @players <> "/#{id}" <> "/on_purchase")
    |> API.post(params, api_key: api_key)
  end

  @spec create_focus(String.t(), map(), api_key: String.t()) :: {:ok, map()} | {:error, map()}
  def create_focus(id, params, opts \\ []) do
    api_key = Keyword.get(opts, :api_key, OneSignal.fetch_api_key())

    (OneSignal.endpoint() <> @players <> "/#{id}" <> "/on_focus")
    |> API.post(params, api_key: api_key)
  end

  @spec update(String.t(), map(), api_key: String.t()) :: {:ok, map()} | {:error, map()}
  def update(id, params, opts \\ []) do
    api_key = Keyword.get(opts, :api_key, OneSignal.fetch_api_key())

    (OneSignal.endpoint() <> @players <> "/#{id}")
    |> API.put(params, api_key: api_key)
  end
end
