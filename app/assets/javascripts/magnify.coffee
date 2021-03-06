###
Credits:
https://github.com/marcaube/bootstrap-magnify
###

!(($) ->
  'use strict'
  # jshint ;_;

  ### MAGNIFY PUBLIC CLASS DEFINITION
  # ===============================
  ###

  Magnify = (element, options) ->
    @init 'magnify', element, options
    return

  Magnify.prototype =
    constructor: Magnify
    init: (type, element, options) ->
      event = 'mousemove'
      eventOut = 'mouseleave'
      @type = type
      @$element = $(element)
      @options = @getOptions(options)
      @nativeWidth = 0
      @nativeHeight = 0
      @$element.wrap '<div class="magnify" >'
      @$element.parent('.magnify').append '<div class="magnify-large" >'
      @$element.siblings('.magnify-large').css 'background', 'url(\'' + @$element.attr('src') + '\') no-repeat'
      @$element.parent('.magnify').on event + '.' + @type, $.proxy(@check, this)
      @$element.parent('.magnify').on eventOut + '.' + @type, $.proxy(@check, this)
      return
    getOptions: (options) ->
      options = $.extend({}, $.fn[@type].defaults, options, @$element.data())
      if options.delay and typeof options.delay == 'number'
        options.delay =
          show: options.delay
          hide: options.delay
      options
    check: (e) ->
      container = $(e.currentTarget)
      self = container.children('img')
      mag = container.children('.magnify-large')
      # Get the native dimensions of the image
      if !@nativeWidth and !@nativeHeight
        image = new Image
        image.src = self.attr('src')
        @nativeWidth = image.width
        @nativeHeight = image.height
      else
        magnifyOffset = container.offset()
        mx = e.pageX - magnifyOffset.left
        my = e.pageY - magnifyOffset.top
        if mx < container.width() and my < container.height() and mx > 0 and my > 0
          mag.fadeIn 100
        else
          mag.fadeOut 100
        if mag.is(':visible')
          rx = Math.round(mx / container.width() * @nativeWidth - (mag.width() / 2)) * -1
          ry = Math.round(my / container.height() * @nativeHeight - (mag.height() / 2)) * -1
          bgp = rx + 'px ' + ry + 'px'
          px = mx - (mag.width() / 2)
          py = my - (mag.height() / 2)
          mag.css
            left: px
            top: py
            backgroundPosition: bgp
      return

  ### MAGNIFY PLUGIN DEFINITION
  # =========================
  ###

  $.fn.magnify = (option) ->
    @each ->
      $this = $(this)
      data = $this.data('magnify')
      options = typeof option == 'object' and option
      if !data
        $this.data 'tooltip', data = new Magnify(this, options)
      if typeof option == 'string'
        data[option]()
      return

  $.fn.magnify.Constructor = Magnify
  $.fn.magnify.defaults = delay: 0

  ### MAGNIFY DATA-API
  # ================
  ###

  $(window).on 'load', ->
    $('[data-toggle="magnify"]').each ->
      $mag = $(this)
      $mag.magnify()
      return
    return
  return
)(window.jQuery)

# ---
# generated by js2coffee 2.0.1