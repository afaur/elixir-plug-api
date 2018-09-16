defmodule HttpAppTest do
  use WebCase, async: true

  doctest HttpApp.Application

  test "/api/users should return list of users", context do
    assert get(context, "/api/users") == res(["Mary", "John", "Jill"])
  end
end
