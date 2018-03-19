defmodule OneSignal.Player do
  use Injector

  inject OneSignal.API

  @players "/players"

  @spec csv_export(map()) :: {:ok, map()} | {:error, map()}
  def csv_export(params \\ %{}) do
    OneSignal.endpoint() <> @players <> "/csv_export"
    |> API.post(params)
  end

  @spec all(map()) :: {:ok, map()} | {:error, map()}
  def all(params \\ %{}) do
    OneSignal.endpoint() <> @players
    |> API.get(params)
  end

  @spec get(String.t) :: {:ok, map()} | {:error, map()}
  def get(id) do
    OneSignal.endpoint() <> @players <> "/#{id}"
    |> API.get()
  end

  @spec all(map()) :: {:ok, map()} | {:error, map()}
  def create(params) do
    OneSignal.endpoint() <> @players
    |> API.post(params)
  end

  @spec create_session(String.t, map()) :: {:ok, map()} | {:error, map()}
  def create_session(id, params) do
    OneSignal.endpoint() <> @players <> "/#{id}" <> "/on_session"
    |> API.post(params)
  end

  @spec create_purchase(String.t, map()) :: {:ok, map()} | {:error, map()}
  def create_purchase(id, params) do
    OneSignal.endpoint() <> @players <> "/#{id}" <> "/on_purchase"
    |> API.post(params)
  end

  @spec create_focus(String.t, map()) :: {:ok, map()} | {:error, map()}
  def create_focus(id, params) do
    OneSignal.endpoint() <> @players <> "/#{id}" <> "/on_focus"
    |> API.post(params)
  end

  @spec update(String.t, map()) :: {:ok, map()} | {:error, map()}
  def update(id, params) do
    OneSignal.endpoint() <> @players <> "/#{id}"
    |> API.put(params)
  end

end
