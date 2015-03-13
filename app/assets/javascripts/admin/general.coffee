#For scripts that are intended for the whole application rather than for specific controller

window.show_error_modal = (title, content) ->
  $("#error-modal-title").html(title)
  $("#error-modal-body").html(content)
  $("#error-modal").modal()