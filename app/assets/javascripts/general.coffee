#For scripts that are intended for the whole application rather than for specific controller
random_hex_color () ->
  Math.floor(Math.random() * 16777215).toString(16);