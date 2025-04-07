// jQuery extras - Plain JavaScript version of the CoffeeScript extensions
// Part of the CoffeeScript to JS migration

(function($) {
  // Add a method to format numbers with separators
  $.fn.formatNumber = function(options = {}) {
    const defaults = {
      separator: '.',
      delimiter: ',',
      precision: 2
    };
    
    const settings = $.extend({}, defaults, options);
    
    // Format the number with the specified options
    const format = function(number) {
      number = number.toFixed(settings.precision);
      const parts = number.split('.');
      
      // Format the integer part with delimiters
      let integerPart = parts[0];
      let formattedInteger = '';
      
      while (integerPart.length > 3) {
        formattedInteger = settings.delimiter + integerPart.substr(integerPart.length - 3) + formattedInteger;
        integerPart = integerPart.substr(0, integerPart.length - 3);
      }
      
      formattedInteger = integerPart + formattedInteger;
      
      // Add the decimal part if needed
      if (settings.precision > 0) {
        const decimalPart = parts[1] || '0'.repeat(settings.precision);
        return formattedInteger + settings.separator + decimalPart;
      } else {
        return formattedInteger;
      }
    };
    
    // Apply to each element
    return this.each(function() {
      const $this = $(this);
      const value = parseFloat($this.text());
      
      if (!isNaN(value)) {
        $this.text(format(value));
      }
      
      return this;
    });
  };

  // Add a method to parse formatted numbers
  $.fn.parseFormattedNumber = function(options = {}) {
    const defaults = {
      separator: '.',
      delimiter: ','
    };
    
    const settings = $.extend({}, defaults, options);
    
    return this.each(function() {
      const $this = $(this);
      const value = $this.text() || $this.val();
      
      if (value) {
        // Remove all delimiters and replace separator with a dot
        const regex = new RegExp('\\' + settings.delimiter, 'g');
        let cleanValue = value.replace(regex, '');
        
        if (settings.separator !== '.') {
          cleanValue = cleanValue.replace(settings.separator, '.');
        }
        
        const parsedValue = parseFloat(cleanValue);
        
        if (!isNaN(parsedValue)) {
          $this.data('parsed-value', parsedValue);
        }
      }
      
      return this;
    });
  };

  // Add a method to toggle element visibility with animation
  $.fn.toggleVisibility = function(speed = 400, callback) {
    return this.each(function() {
      const $this = $(this);
      
      if ($this.is(':visible')) {
        $this.fadeOut(speed, callback);
      } else {
        $this.fadeIn(speed, callback);
      }
      
      return this;
    });
  };

  // Add a method to serialize form data to JSON
  $.fn.serializeJSON = function() {
    const json = {};
    
    $.each($(this).serializeArray(), function() {
      json[this.name] = this.value;
    });
    
    return json;
  };

  // Add a method to flash an element to draw attention
  $.fn.flash = function(options = {}) {
    const defaults = {
      duration: 500,
      times: 3,
      color: '#FFFF9C',
      originalColor: null
    };
    
    const settings = $.extend({}, defaults, options);
    
    return this.each(function() {
      const $this = $(this);
      const originalColor = settings.originalColor || $this.css('backgroundColor');
      
      let flashCount = 0;
      const flash = function() {
        if (flashCount < settings.times) {
          $this.animate({ backgroundColor: settings.color }, settings.duration / 2, function() {
            $this.animate({ backgroundColor: originalColor }, settings.duration / 2, function() {
              flashCount++;
              flash();
            });
          });
        }
      };
      
      flash();
      
      return this;
    });
  };

  // Add a method to center an element in the viewport
  $.fn.centerInViewport = function() {
    return this.each(function() {
      const $this = $(this);
      
      $this.css({
        position: 'fixed',
        top: '50%',
        left: '50%',
        transform: 'translate(-50%, -50%)'
      });
      
      return this;
    });
  };

  // Add support for placeholder in older browsers
  $.fn.placeholder = function() {
    return this.each(function() {
      const $this = $(this);
      const placeholder = $this.attr('placeholder');
      
      if (placeholder) {
        if (!('placeholder' in document.createElement('input'))) {
          if ($this.val() === '') {
            $this.val(placeholder).addClass('placeholder');
          }
          
          $this.focus(function() {
            if ($this.val() === placeholder) {
              $this.val('').removeClass('placeholder');
            }
          });
          
          $this.blur(function() {
            if ($this.val() === '') {
              $this.val(placeholder).addClass('placeholder');
            }
          });
        }
      }
      
      return this;
    });
  };
})(jQuery);
