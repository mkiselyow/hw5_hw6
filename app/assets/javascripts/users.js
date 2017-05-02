$(document).ready(function(){
  $("body").on("click", "h2", function(){
    alert("CLICKED");
  });
  // $("#flash_notice").on({
  //   click: function() {
  //     $(this).css("background-color", "pink");
  //   },
  //   click : function() {
  //     $(this).fadeOut(5000);
  //   }
  // });

  setTimeout(function(){$("#flash_notice").fadeOut(6000)},3000);
  

  $("body").on("click", "#list_toggle", function(e){
    // list = $('.user_list');
    // list.fadeIn();
    text = $(e.target).text();
    text = text === "Hide" ? "Show" : "Hide";
    $(e.target).text(text);

    return false;
  });
});








