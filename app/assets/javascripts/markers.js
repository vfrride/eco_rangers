$(document).ready(function() {
  $('.marker-container button').on("click", function() {
    var buttons = $('.marker-container button');
    buttons.attr('disabled', true);
    buttons.addClass('disabled');
    var placeTypeId = $(this).data("placeTypeId");
    $("#marker_place_type_id").val(placeTypeId);
    $("form#new_marker").submit();
  });
});
