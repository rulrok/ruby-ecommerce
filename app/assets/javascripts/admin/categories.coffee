# Place all the behaviors and hooks related to the matching controller here.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#tree').jstree({
    'core': {
      'data': {
        'url': '/admin/categories.json'
      }
      , 'check_callback': (operation, node, node_parent, node_position) ->
        check_passed = false
        switch operation
          when 'move_node'
            if node.original != undefined and node_parent.original != undefined #and node.original.depth - 1 == node_parent.original.depth
              check_passed = true
          when 'delete_node'
            check_passed = confirm("Are you sure?") && fn_remove(node.id)

#            if !confirm_remove
#              create_aux_tree node.id
#              choose_replacement
#              check_passed = false
#            else
#              idDescritor = $('#jstree_div').jstree(true).get_selected().toString()
#              idDescritorSubs = $('#jstree_div_aux').jstree(true).get_selected().toString().substr(2)
#              check_passed = removerDescritor(idDescritor, idDescritorSubs)
#              confirm_remove = false
          when 'create_node'
            check_passed = fn_create(node_parent, node)
          when 'rename_node'
            check_passed = fn_rename(node.id, node_position)
        check_passed
    }
    , 'contextmenu': {
    #Contextmenu doc: http://www.jstree.com/api/#/?q=$.jstree.defaults.contextmenu
      "items": (node, fn) ->
        if node.parent == '#'
          'create': menu_create
        else if node.original.depth < 2
          'create': menu_create
          'rename': menu_rename
          'remove': menu_remove
        else
          'rename': menu_rename
          'remove': menu_remove
    }
  #Types docs: http://www.jstree.com/api/#/?q=types
    , "types": {
      "default": {
        "max_depth": 2
      }
    }
    , 'plugins': ['contextmenu', 'types', 'dnd', 'unique', 'state', 'search', 'sort']
  }).on 'move_node.jstree', (e, data) ->
    fn_move(data.node, data.parent)

  to = false
  $('#category-search').keyup ->
    if to
      clearTimeout to
    to = setTimeout((->
      v = $('#category-search').val()
      $('#tree').jstree(true).search v
      return
    ), 250)
    return

  $('#expand-tree').on 'click', ->
    tree = $.jstree.reference('tree')
    $(this).addClass 'hidden'
    $('#collapse-tree').removeClass 'hidden'
    tree.open_all undefined, false
    return

  $('#collapse-tree').on 'click', ->
    tree = $.jstree.reference('tree')
    $(this).addClass 'hidden'
    $('#expand-tree').removeClass 'hidden'
    tree.close_all()
    tree.open_node tree.get_json('#'), undefined, false
    return


menu_create =
  'separator_before': false
  'separator_after': true
  '_disabled': false
  'label': 'Create new'
  'action': (data) ->
    initial_name = 'New category'
    inst = $.jstree.reference(data.reference)
    obj = inst.get_node(data.reference)
    child = inst.get_children_dom(data.reference)
    larger_number = -1
    $(child).each (index, data) ->
      node_name = inst.get_node(data).text
      if initial_name == node_name.substr(0, initial_name.length)
        found_number = parseInt(node_name.substr(initial_name.length, node_name.length))
        if isNaN(found_number)
          found_number = 0
        if larger_number < found_number
          larger_number = found_number
      return
    larger_number++
    if larger_number > 0
      initial_name = initial_name + ' ' + larger_number
    inst.create_node obj, {text: initial_name}, 'last', (new_node) ->
      setTimeout (->
        inst.edit new_node
        return
      ), 0
      return
    return
menu_rename =
  'separator_before': false
  'separator_after': false
  '_disabled': false
  'label': 'Rename'
  'action': (data) ->
    inst = $.jstree.reference(data.reference)
    obj = inst.get_node(data.reference)
    inst.edit obj
    return
menu_remove =
  'separator_before': false
  'icon': false
  'separator_after': false
  '_disabled': false
  'label': 'Remove'
  'action': (data) ->
    inst = $.jstree.reference(data.reference)
    obj = inst.get_node(data.reference)
    if inst.is_selected(obj)
      inst.delete_node inst.get_selected()
    else
      inst.delete_node obj
    return

#Callbacks to send the requests to the server
fn_rename = (id, new_name) ->
  success = undefined
  $.ajax
    async: false
    type: 'PATCH'
    url: '/admin/categories/' + id + '.json'
    data:
      'category':
        id: id
        name: new_name
    dataType: 'json'
    success: (json) ->
      success = true
    error: (xhr, ajaxOptions, thrownError) ->
      show_error_modal("Ooops!", xhr.responseText)
      success = false
  success

fn_create = (parent, new_obj) ->
  success = undefined
  $.ajax
    async: false
    type: 'POST'
    url: '/admin/categories.json'
    data:
      category:
        'parent_id': parent.id
        'name': new_obj.text
    success: (json) ->
      new_obj.id = json.id
      setTimeout(()->
        new_obj_parent = $.jstree.reference('tree').get_node(parent.id)
        new_obj_node = $.jstree.reference('tree').get_node(json.id)
        new_obj_node.original.depth = new_obj_parent.original.depth + 1
      )
      success = true
      return
    error: (xhr, ajaxOptions, thrownError) ->
      show_error_modal("Ooops!", xhr.responseText)
      success = false
  success

fn_move = (obj, new_parent_id) ->
  success = undefined
  $.ajax
    async: false
    type: 'PATCH'
    url: '/admin/categories/' + obj.id + '.json'
    data:
      category:
        id: obj.id
        parent_id: new_parent_id
    dataType: 'json'
    success: (json) ->
      success = true
    error: (xhr, ajaxOptions, thrownError) ->
      show_error_modal("Ooops!", xhr.responseText)
      success = false

  success

fn_remove = (obj_id) ->
  success = undefined
  $.ajax
    async: false
    type: 'DELETE'
    url: '/admin/categories/' + obj_id + '.json'
    data:
      category:
        id: obj_id
      dataType: 'json'
    success: (json) ->
      setTimeout(() -> $.jstree.reference('tree').refresh())
      success = true
    error: (xhr, ajaxOptions, thrownError) ->
#      console.log xhr
      show_error_modal("Ooops!", xhr.responseText)
      success = false
  success