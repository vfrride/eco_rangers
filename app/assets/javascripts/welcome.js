  // $(document).ready(function() {
  //   if (navigator.geolocation) {
  //     navigator.geolocation.getCurrentPosition(function(position) {
  //       handler = Gmaps.build('Google');
  //       handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
  //         console.log("lat:" + position.coords.latitude + "&lng=" + position.coords.longitude);
  //         markers = handler.addMarkers([
  //           <% @local_places.each do |place| %>
  //             {
  //               "lat": <%= place.lat %>,
  //               "lng": <%= place.lng %>,
  //               "picture": {
  //                 "url": "<%= image_url place.place_type.img_url %>",
  //                 "width":  32,
  //                 "height": 32
  //               },
  //               "infowindow": "<%= place.name %><br/><%= place.address1 %><br/><%= place.city %>, <%= place.state_code %>"
  //             },
  //           <% end %>
  //         ]);
  //         handler.bounds.extendWith(markers);
  //         handler.fitMapToBounds();
  //       });
  //     }, function(e) {
  //       console.log("Error: " + e);
  //     });
  //   } else {
  //     console.log("Cannot use html 5 location API");
  //   }
  // });
var map;
var grouped_markers = {};
// function initMap() {
//   map = new google.maps.Map(document.getElementById('map'), {
//     center: {lat: -34.397, lng: 150.644},
//     zoom: 8
//   });
// }

$(document).ready(function() {
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
