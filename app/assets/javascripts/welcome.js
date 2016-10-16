var map;
var grouped_markers = {};

$(document).ready(function() {
  $('.fox').one("webkitAnimationEnd oanimationend msAnimationEnd animationend", function () {
    $('.fox').fadeOut()
  });

  $(".place_type").on("click", togglePlaceType);
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: position.coords.latitude, lng: position.coords.longitude},
        zoom: 15
      });

      $.get("locations").then(function (locations) {
        Object.keys(locations).forEach(function (key) {
          console.log("key " +  key);
          if(!grouped_markers[key]) {
            grouped_markers[key] = [];
          }

          locations[key].forEach(function (loc) {
            var pos = {"lat": parseFloat(loc["lat"]), "lng": parseFloat(loc["lng"])};
            var label = loc["label"];

            grouped_markers[key].push(new google.maps.Marker({
                position: pos,
                label: label,
                icon: place_type_icons[key]
              })
            );
          });

          showMarkers(key);
        });
      });
    });
  }

  $('[data-toggle="tooltip"]').tooltip()
});

function togglePlaceType() {
  var placeTypeButton = $(this);
  var isSelected = placeTypeButton.hasClass("active");

  if (isSelected) {
    placeTypeButton.removeClass("active");
    hideMarkers(mk(placeTypeButton.data("placeTypeId")));
  } else {
    placeTypeButton.addClass("active");
    showMarkers(mk(placeTypeButton.data("placeTypeId")));
  }
}

function mk(placeTypeId) {
  return "pt" + placeTypeId;
}

function showMarkers(placeTypeId) {
  console.log("showMarkers" + placeTypeId);
  grouped_markers[placeTypeId].forEach(function(marker) {
    marker.setMap(map);
  });
}

function hideMarkers(placeTypeId) {
  console.log("hideMarkers " + placeTypeId);
  grouped_markers[placeTypeId].forEach(function(marker) {
    marker.setMap(null);
  });
}
