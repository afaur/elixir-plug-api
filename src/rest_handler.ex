defmodule HttpApp.RestHandler do
  use HttpApp.BaseRouter, first_handler: false

  defp content(),      do: ["Mary", "John", "Jill"]
  defp json(content),  do: Poison.encode! content, pretty: true
  defp type(conn),     do: put_resp_content_type conn, "application/json"
  defp api_resp(conn), do: resp_end type(conn), 200, json(content())

  _ = """
  `/api/users` Returns A JSON Array Of Users
    - Add `application/json` content-type to response headers
    - Respond with 200 OK Status and Body of a JSON Encoded List
  """
  get   "/users", do: api_resp conn
end
