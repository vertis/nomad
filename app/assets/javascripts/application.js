//= require jquery  
//= require jquery_ujs  
//= require twitter/bootstrap
//= require_self  
//= require_tree .

$(document).ready(function(){
  /* Your javascripts goes here... */
  $(document).on('ajax:error', function(data) {
    alert("Error");
    alert(data)
  });
});
  