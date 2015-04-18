#For scripts that are intended for the whole application rather than for specific controller

setCookie = (cname, cvalue, exdays) ->
  d = new Date
  d.setTime d.getTime() + exdays * 24 * 60 * 60 * 1000
  expires = 'expires=' + d.toUTCString()
  document.cookie = cname + '=' + cvalue + '; ' + expires
  return

getCookie = (cname) ->
  name = cname + '='
  ca = document.cookie.split(';')
  i = 0
  while i < ca.length
    c = ca[i]
    while c.charAt(0) == ' '
      c = c.substring(1)
    if c.indexOf(name) == 0
      return c.substring(name.length, c.length)
    i++
  ''


$(document).ready (ev) ->
  $('#custom_carousel').on 'slide.bs.carousel', (evt) ->
    $('#custom_carousel .controls li.active').removeClass 'active'
    $('#custom_carousel .controls li:eq(' + $(evt.relatedTarget).index() + ')').addClass 'active'
    return
  $('[data-toggle="tooltip"]').tooltip()


  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '200px'

  return