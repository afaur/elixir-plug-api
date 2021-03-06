defmodule HttpApp.ViewHandler do
  require EEx

  _ = """
  Define a function named `index` that takes one argument
    - argument is what `dynamic_value` will be set as
      when we render the compiled template from `www/index.eex`
  """
  EEx.function_from_file :def, :index, "../www/index.eex", [ :dynamic_value ]
end
