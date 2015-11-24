$(document).ready(function() {

  // if they click on a boxed image, enlarge it
  $('div.img-box img').click(function(event) {
    $(this).removeClass("img-belittled").addClass("img-enlarged").closest('div.img-box').addClass("lightbox");
    // if they click an enlarged image, close it
  });
  $('body').on("click", ".lightbox", function(event) {
    console.log($(".active-lightbox").length);
    if ($(".active-lightbox").length > 0) {
      $('div.img-box img').addClass("img-belittled").removeClass("img-enlarged").closest('div.img-box').removeClass("lightbox");
      $(".active-lightbox").removeClass("active-lightbox");
      return;
    } else {
      $('div.img-box').addClass("active-lightbox");
    }
  });
});
