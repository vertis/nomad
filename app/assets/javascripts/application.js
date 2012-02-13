//= require jquery  
//= require jquery_ujs  
//= require twitter/bootstrap
//= require_self  
//= require_tree .

$(document).ready(function(){
  /* Your javascripts goes here... */
  
  $('#new-mapping form').bind("ajax:before", function() {
    console.log("ajax:before");
  });

  $('#new-mapping form').bind("ajax:success", function(data, status, xhr) {
    console.log("ajax:success");
    console.log(data)
    console.log(xhr.responseText)
  });

  $('#new-mapping form').bind("ajax:complete", function() {
    console.log("ajax:complete");
  });
  $('#new-mapping form').bind("ajax:error", function(xhr, status, error) {
      console.log("ajax:error");
      console.log(error);
  });
});
  