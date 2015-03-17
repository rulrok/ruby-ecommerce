# Place all the behaviors and hooks related to the matching controller here.
# You can use CoffeeScript in this file: http://coffeescript.org/

#The event 'page:load' is to workaround the side-effect of turbolink when and page of the controller Products is called
#after another page on the same controller. Basically, the body content is replaced as an typical ajax wesite, and the
#script is not executed properly.
#See http://stackoverflow.com/questions/28078480/rails-turbolinks-breaking-pnotify for details.

$(document).on 'page:load', ->
  $('#product_image_delete').on 'click', ->
      $('#photo_field').toggleClass('hidden')
      return
  return