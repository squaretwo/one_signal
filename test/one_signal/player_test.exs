defmodule OneSignal.PlayerTest do
  use ExUnit.Case, async: true

  import Mocker

  alias HTTPoison.Response
  alias OneSignal.Player

  setup do
    System.put_env("ONE_SIGNAL_API_KEY", "alksd49peoi8apgbknm34klr53")
    mock(HTTPoison)
    :ok
  end

  describe "csv_export" do
    test "should fetch csv_export" do
      expectation =
        intercept(
          HTTPoison,
          :post!,
          [
            "https://onesignal.com/api/v1/players/csv_export",
            "{}",
            %{
              "Authorization" => "Basic alksd49peoi8apgbknm34klr53",
              "Content-type" => "application/json"
            }
          ],
          with: fn _, _, _ ->
            %Response{body: ~s({"foo": "bar"}), status_code: 200}
          end
        )

      {:ok, data} = Player.csv_export()
      assert data == %{"foo" => "bar"}
      assert expectation |> was_called() == once()
    end

    test "should fetch csv_export and return error if unsuccessful" do
      expectation =
        intercept(
          HTTPoison,
          :post!,
          [
            "https://onesignal.com/api/v1/players/csv_export",
            "{}",
            %{
              "Authorization" => "Basic alksd49peoi8apgbknm34klr53",
              "Content-type" => "application/json"
            }
          ],
          with: fn _, _, _ ->
            %Response{body: ~s({"bad": "server error"}), status_code: 500}
          end
        )

      {:error, data} = Player.csv_export()
      assert data == %{"bad" => "server error"}
      assert expectation |> was_called() == once()
    end
  end

  describe "all" do
    test "should fetch all" do
      expectation =
        intercept(
          HTTPoison,
          :get!,
          [
            "https://onesignal.com/api/v1/players",
            %{
              "Authorization" => "Basic alksd49peoi8apgbknm34klr53",
              "Content-type" => "application/json"
            }
          ],
          with: fn _, _ ->
            %Response{body: ~s({"foo": "bar"}), status_code: 200}
          end
        )

      {:ok, data} = Player.all()
      assert data == %{"foo" => "bar"}
      assert expectation |> was_called() == once()
    end

    test "should fetch all and return error if unsuccessful" do
      expectation =
        intercept(
          HTTPoison,
          :get!,
          [
            "https://onesignal.com/api/v1/players",
            %{
              "Authorization" => "Basic alksd49peoi8apgbknm34klr53",
              "Content-type" => "application/json"
            }
          ],
          with: fn _, _ ->
            %Response{body: ~s({"bad": "server error"}), status_code: 500}
          end
        )

      {:error, data} = Player.all()
      assert data == %{"bad" => "server error"}
      assert expectation |> was_called() == once()
    end
  end

  describe "get" do
    test "should get" do
      expectation =
        intercept(
          HTTPoison,
          :get!,
          [
            "https://onesignal.com/api/v1/players/abc123",
            %{
              "Authorization" => "Basic alksd49peoi8apgbknm34klr53",
              "Content-type" => "application/json"
            }
          ],
          with: fn _, _ ->
            %Response{body: ~s({"foo": "bar"}), status_code: 200}
          end
        )

      {:ok, data} = Player.get("abc123")
      assert data == %{"foo" => "bar"}
      assert expectation |> was_called() == once()
    end

    test "should get and return error if unsuccessful" do
      expectation =
        intercept(
          HTTPoison,
          :get!,
          [
            "https://onesignal.com/api/v1/players/abc123",
            %{
              "Authorization" => "Basic alksd49peoi8apgbknm34klr53",
              "Content-type" => "application/json"
            }
          ],
          with: fn _, _ ->
            %Response{body: ~s({"bad": "server error"}), status_code: 500}
          end
        )

      {:error, data} = Player.get("abc123")
      assert data == %{"bad" => "server error"}
      assert expectation |> was_called() == once()
    end
  end

  describe "create" do
    test "should create" do
      expectation =
        intercept(
          HTTPoison,
          :post!,
          [
            "https://onesignal.com/api/v1/players",
            any(),
            %{
              "Authorization" => "Basic alksd49peoi8apgbknm34klr53",
              "Content-type" => "application/json"
            }
          ],
          with: fn _, params, _ ->
            %Response{body: params, status_code: 200}
          end
        )

      {:ok, data} = Player.create(%{first_name: "foo", last_name: "bar"})
      assert data == %{"first_name" => "foo", "last_name" => "bar"}
      assert expectation |> was_called() == once()
    end

    test "should create and return error if unsuccessful" do
      expectation =
        intercept(
          HTTPoison,
          :post!,
          [
            "https://onesignal.com/api/v1/players",
            any(),
            %{
              "Authorization" => "Basic alksd49peoi8apgbknm34klr53",
              "Content-type" => "application/json"
            }
          ],
          with: fn _, params, _ ->
            %Response{body: params, status_code: 500}
          end
        )

      {:error, data} = Player.create(%{first_name: "foo", last_name: "bar"})
      assert data == %{"first_name" => "foo", "last_name" => "bar"}
      assert expectation |> was_called() == once()
    end
  end

  describe "create_session" do
    test "should create session" do
      expectation =
        intercept(
          HTTPoison,
          :post!,
          [
            "https://onesignal.com/api/v1/players/abc123/on_session",
            ~s({"foo":"bar"}),
            %{
              "Authorization" => "Basic alksd49peoi8apgbknm34klr53",
              "Content-type" => "application/json"
            }
          ],
          with: fn _, _, _ ->
            %Response{body: ~s({"foo": "bar"}), status_code: 200}
          end
        )

      {:ok, data} = Player.create_session("abc123", %{foo: "bar"})
      assert data == %{"foo" => "bar"}
      assert expectation |> was_called() == once()
    end

    test "should create session and return error if unsuccessful" do
      expectation =
        intercept(
          HTTPoison,
          :post!,
          [
            "https://onesignal.com/api/v1/players/abc123/on_session",
            ~s({"foo":"bar"}),
            %{
              "Authorization" => "Basic alksd49peoi8apgbknm34klr53",
              "Content-type" => "application/json"
            }
          ],
          with: fn _, _, _ ->
            %Response{body: ~s({"bad": "server error"}), status_code: 500}
          end
        )

      {:error, data} = Player.create_session("abc123", %{foo: "bar"})
      assert data == %{"bad" => "server error"}
      assert expectation |> was_called() == once()
    end
  end

  describe "create_purchase" do
    test "should create purchase" do
      expectation =
        intercept(
          HTTPoison,
          :post!,
          [
            "https://onesignal.com/api/v1/players/abc123/on_purchase",
            ~s({"foo":"bar"}),
            %{
              "Authorization" => "Basic alksd49peoi8apgbknm34klr53",
              "Content-type" => "application/json"
            }
          ],
          with: fn _, _, _ ->
            %Response{body: ~s({"foo": "bar"}), status_code: 200}
          end
        )

      {:ok, data} = Player.create_purchase("abc123", %{foo: "bar"})
      assert data == %{"foo" => "bar"}
      assert expectation |> was_called() == once()
    end

    test "should create purchase and return error if unsuccessful" do
      expectation =
        intercept(
          HTTPoison,
          :post!,
          [
            "https://onesignal.com/api/v1/players/abc123/on_purchase",
            ~s({"foo":"bar"}),
            %{
              "Authorization" => "Basic alksd49peoi8apgbknm34klr53",
              "Content-type" => "application/json"
            }
          ],
          with: fn _, _, _ ->
            %Response{body: ~s({"bad": "server error"}), status_code: 500}
          end
        )

      {:error, data} = Player.create_purchase("abc123", %{foo: "bar"})
      assert data == %{"bad" => "server error"}
      assert expectation |> was_called() == once()
    end
  end

  describe "create_focus" do
    test "should create focus" do
      expectation =
        intercept(
          HTTPoison,
          :post!,
          [
            "https://onesignal.com/api/v1/players/abc123/on_focus",
            ~s({"foo":"bar"}),
            %{
              "Authorization" => "Basic alksd49peoi8apgbknm34klr53",
              "Content-type" => "application/json"
            }
          ],
          with: fn _, _, _ ->
            %Response{body: ~s({"foo": "bar"}), status_code: 200}
          end
        )

      {:ok, data} = Player.create_focus("abc123", %{foo: "bar"})
      assert data == %{"foo" => "bar"}
      assert expectation |> was_called() == once()
    end

    test "should create focus and return error if unsuccessful" do
      expectation =
        intercept(
          HTTPoison,
          :post!,
          [
            "https://onesignal.com/api/v1/players/abc123/on_focus",
            ~s({"foo":"bar"}),
            %{
              "Authorization" => "Basic alksd49peoi8apgbknm34klr53",
              "Content-type" => "application/json"
            }
          ],
          with: fn _, _, _ ->
            %Response{body: ~s({"bad": "server error"}), status_code: 500}
          end
        )

      {:error, data} = Player.create_focus("abc123", %{foo: "bar"})
      assert data == %{"bad" => "server error"}
      assert expectation |> was_called() == once()
    end
  end

  describe "update" do
    test "should update player" do
      expectation =
        intercept(
          HTTPoison,
          :put!,
          [
            "https://onesignal.com/api/v1/players/abc123",
            ~s({"foo":"bar"}),
            %{
              "Authorization" => "Basic alksd49peoi8apgbknm34klr53",
              "Content-type" => "application/json"
            }
          ],
          with: fn _, _, _ ->
            %Response{body: ~s({"foo": "bar"}), status_code: 200}
          end
        )

      {:ok, data} = Player.update("abc123", %{foo: "bar"})
      assert data == %{"foo" => "bar"}
      assert expectation |> was_called() == once()
    end

    test "should update player and return error if unsuccessful" do
      expectation =
        intercept(
          HTTPoison,
          :put!,
          [
            "https://onesignal.com/api/v1/players/abc123",
            ~s({"foo":"bar"}),
            %{
              "Authorization" => "Basic alksd49peoi8apgbknm34klr53",
              "Content-type" => "application/json"
            }
          ],
          with: fn _, _, _ ->
            %Response{body: ~s({"bad": "server error"}), status_code: 500}
          end
        )

      {:error, data} = Player.update("abc123", %{foo: "bar"})
      assert data == %{"bad" => "server error"}
      assert expectation |> was_called() == once()
    end
  end
end
