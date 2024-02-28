shinyjs.custom_print = function(params){
 var defaultParams = {
  name: ""
  };
 params = shinyjs.getParams(params, defaultParams);
 popup = window.open();
 popup.document.write(params.name);
 popup.focus();
 popup.print();
 }
