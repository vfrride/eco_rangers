var map;
var grouped_markers = {};
var infowindow;
var shown_place_type_ids = [];

$(document).ready(function() {
  $('.fox').one("webkitAnimationEnd oanimationend msAnimationEnd animationend", function () {
    $('.fox').fadeOut();
  });

  $(".welcome button.place_type").on("click", togglePlaceType);
  $(".welcome button.ranger").on("click", toggleRangerMarkers);

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      if (typeof google !== "undefined") {
        map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: position.coords.latitude, lng: position.coords.longitude},
          zoom: 15
        });

        infowindow = new google.maps.InfoWindow();

        $.get("locations").then(function (locations) {
          Object.keys(locations).forEach(function (key) {
            if(!grouped_markers[key]) {
              grouped_markers[key] = [];
            }

            locations[key].forEach(function (loc) {
              var pos = {"lat": parseFloat(loc["lat"]), "lng": parseFloat(loc["lng"])};
              var label = loc["label"];
              var marker = new google.maps.Marker({
                  position: pos,
                  content: label,
                  icon: place_type_icons[key],
                  rangerIds: loc["rangerIds"]
                });

              marker.addListener("click", function() {
                infowindow.setContent(marker.content);
                infowindow.open(map, marker);
              });

              grouped_markers[key].push(marker)
            });

            showMarkers(key);
          });
        });
      };
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

function toggleRangerMarkers() {
  var rangerButton = $(this);
  var isSelected = rangerButton.hasClass("active");

  if (isSelected) {
    rangerButton.removeClass("active");
    shown_place_type_ids.forEach(function (place_type_id) {
      hideMarkers(place_type_id, rangerButton.data("rangerId"));
    });
  } else {
    rangerButton.addClass("active");
    shown_place_type_ids.forEach(function (place_type_id) {
      showMarkers(place_type_id, rangerButton.data("rangerId"));
    });
  }
}

function mk(placeTypeId) {
  return "pt" + placeTypeId;
}

function showMarkers(placeTypeId, rangerId) {
  console.log("showMarkers" + placeTypeId + " rangerId " + rangerId);
  if (shown_place_type_ids.indexOf(placeTypeId) === -1) {
    shown_place_type_ids.push(placeTypeId)
  }
  grouped_markers[placeTypeId].forEach(function(marker) {
    if (_.isEmpty(rangerId)) {
      marker.setMap(map);
      return;
    }

    if (marker.rangerIds.indexOf(rangerId) !== -1) {
      marker.setMap(map);
    }
  });
}

function hideMarkers(placeTypeId, rangerId) {
  console.log("hideMarkers " + placeTypeId + " rangerId " + rangerId);
  var index = shown_place_type_ids.indexOf(placeTypeId);
  if (index !== -1) {
    shown_place_type_ids.splice(index, 1);
  }

  grouped_markers[placeTypeId].forEach(function(marker) {
    if (_.isEmpty(rangerId)) {
      marker.setMap(null);
      return;
    }

    if (marker.rangerIds.indexOf(rangerId) !== -1) {
      marker.setMap(null);
    }
  });
}
