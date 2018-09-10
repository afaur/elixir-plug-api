defmodule HttpApp.ViewHandler do
  require EEx
  EEx.function_from_file(
    # Define a function named `index` that takes one argument
    # That argument is what `dynamic_value` will be set as
    # when we render the compiled template from `www/index.eex`
    :def, :index, "../www/index.eex", [ :dynamic_value ]
  )
end
