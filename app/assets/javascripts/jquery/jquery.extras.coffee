# jQuery extras - Custom extensions to jQuery
# This file will be replaced with plain JavaScript as part of the CoffeeScript to JS migration

# Add a method to format numbers with separators
$.fn.formatNumber = (options = {}) ->
  defaults =
    separator: '.'
    delimiter: ','
    precision: 2
  
  settings = $.extend({}, defaults, options)
  
  # Format the number with the specified options
  format = (number) ->
    number = number.toFixed(settings.precision)
    parts = number.split('.')
    
    # Format the integer part with delimiters
    integerPart = parts[0]
    formattedInteger = ''
    
    while integerPart.length > 3
      formattedInteger = settings.delimiter + integerPart.substr(integerPart.length - 3) + formattedInteger
      integerPart = integerPart.substr(0, integerPart.length - 3)
    
    formattedInteger = integerPart + formattedInteger
    
    # Add the decimal part if needed
    if settings.precision > 0
      decimalPart = parts[1] || '0'.repeat(settings.precision)
      return formattedInteger + settings.separator + decimalPart
    else
      return formattedInteger
  
  # Apply to each element
  @each ->
    $this = $(this)
    value = parseFloat($this.text())
    
    if !isNaN(value)
      $this.text(format(value))
    
    return this

# Add a method to parse formatted numbers
$.fn.parseFormattedNumber = (options = {}) ->
  defaults =
    separator: '.'
    delimiter: ','
  
  settings = $.extend({}, defaults, options)
  
  @each ->
    $this = $(this)
    value = $this.text() || $this.val()
    
    if value
      # Remove all delimiters and replace separator with a dot
      regex = new RegExp('\\' + settings.delimiter, 'g')
      cleanValue = value.replace(regex, '')
      
      if settings.separator != '.'
        cleanValue = cleanValue.replace(settings.separator, '.')
      
      parsedValue = parseFloat(cleanValue)
      
      if !isNaN(parsedValue)
        $this.data('parsed-value', parsedValue)
    
    return this

# Add a method to toggle element visibility with animation
$.fn.toggleVisibility = (speed = 400, callback) ->
  @each ->
    $this = $(this)
    
    if $this.is(':visible')
      $this.fadeOut(speed, callback)
    else
      $this.fadeIn(speed, callback)
    
    return this

# Add a method to serialize form data to JSON
$.fn.serializeJSON = ->
  json = {}
  
  $.each $(@).serializeArray(), ->
    json[@name] = @value
  
  return json

# Add a method to flash an element to draw attention
$.fn.flash = (options = {}) ->
  defaults =
    duration: 500
    times: 3
    color: '#FFFF9C'
    originalColor: null
  
  settings = $.extend({}, defaults, options)
  
  @each ->
    $this = $(this)
    originalColor = settings.originalColor || $this.css('backgroundColor')
    
    flashCount = 0
    flash = ->
      if flashCount < settings.times
        $this.animate { backgroundColor: settings.color }, settings.duration / 2, ->
          $this.animate { backgroundColor: originalColor }, settings.duration / 2, ->
            flashCount++
            flash()
    
    flash()
    
    return this

# Add a method to center an element in the viewport
$.fn.centerInViewport = ->
  @each ->
    $this = $(this)
    
    $this.css
      position: 'fixed'
      top: '50%'
      left: '50%'
      transform: 'translate(-50%, -50%)'
    
    return this

# Add support for placeholder in older browsers
$.fn.placeholder = ->
  @each ->
    $this = $(this)
    placeholder = $this.attr('placeholder')
    
    if placeholder
      if !('placeholder' in document.createElement('input'))
        if $this.val() == ''
          $this.val(placeholder).addClass('placeholder')
        
        $this.focus ->
          if $this.val() == placeholder
            $this.val('').removeClass('placeholder')
        
        $this.blur ->
          if $this.val() == ''
            $this.val(placeholder).addClass('placeholder')
    
    return this
