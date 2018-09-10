defmodule HttpAppTest do
  use ExUnit.Case
  doctest HttpApp.Application

  test "/api/users should return list of users" do
    assert (
      "http://127.0.0.1:8085/api/users"
        |> HTTPoison.get()
        |> response()
    ) == { :ok, Poison.encode!( [ "Mary", "John", "Jill" ] ) }
  end

  defp response(
    { :ok, %{ status_code: 200, body: body } }
  ), do: { :ok, body }

  defp response(
    { :ok, %{ status_code: status_code } }
  ), do: { :error, "HTTP Status #{status_code}" }

  defp response(
    { :error, %{ reason: reason } }
  ), do: { :error, reason }
end
