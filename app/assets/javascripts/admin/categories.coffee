# Place all the behaviors and hooks related to the matching controller here.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#tree').jstree({
    'core': {
      'data': {
        'url': 'http://127.0.0.1:3000/admin/categories.json'
      }
      , 'check_callback': true
    }
    , 'contextmenu': {
    #Contextmenu doc: http://www.jstree.com/api/#/?q=$.jstree.defaults.contextmenu
      "items": (o, cb) ->
        console.log($.jstree.get_node(o))
    }
  #Types docs: http://www.jstree.com/api/#/?q=types
    , "types": {
      "default": {
        "max_depth": 2
      }
    }
    , 'plugins': ['contextmenu', 'types']
  });

