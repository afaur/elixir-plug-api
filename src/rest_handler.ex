defmodule HttpApp.RestHandler do
  use Plug.Router
  use Plug.ErrorHandler

  plug(:match)
  plug(:dispatch)

  # `/api/users` Returns A JSON Array Of Users
  get "/users" do send_resp(
    # Add `application/json` content-type to response headers
    ( conn |> put_resp_content_type("application/json") ),
    # Respond with 200 OK Status and Body of a JSON Encoded List
    200, Poison.encode!( [ "Mary", "John", "Jill" ] )
  ) end

  # Any non matching `/api` routes should say they are not implemented
  match _ do send_resp(conn, 501, "API Request Not Implemented") end
end
