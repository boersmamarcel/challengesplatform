var templateEngine = (function() {
  return {
    compile: function(template) {
      return {
        render: function(context) {
          var result = template;
          for(var property in context)
            if(typeof property === 'string') {
              var key = new RegExp('{{' + property + '}}', 'g');
              result = result.replace(key, context[property]);
            }
          return result;
        }
      }
    }
  };
})();