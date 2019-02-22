defmodule OneSignalTest do
  use ExUnit.Case
  doctest OneSignal

  test "create one signal structure" do
    assert %OneSignal.Param{} = OneSignal.new()
  end

  test "sets api_key from config" do
    api_key = "alksd49peoi8apgbknm34klr53"
    Application.put_env(:one_signal, OneSignal, api_key: api_key)
    assert %OneSignal.Param{api_key: ^api_key} = OneSignal.new()
  end
end
