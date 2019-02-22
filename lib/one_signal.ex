defmodule OneSignal do
  def endpoint, do: "https://onesignal.com/api/v1"

  def new do
    %OneSignal.Param{}
    |> struct(api_key: fetch_api_key())
  end

  defp config do
    Application.get_env(:one_signal, OneSignal)
  end

  def fetch_api_key do
    config()[:api_key] ||
      System.get_env("ONE_SIGNAL_API_KEY")
  end

  def fetch_app_id do
    config()[:app_id] ||
      System.get_env("ONE_SIGNAL_APP_ID")
  end
end
