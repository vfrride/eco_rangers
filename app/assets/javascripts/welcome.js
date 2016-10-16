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
var place_type_icons = ["bus_icon.png", "charging.png"];
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
        var markers = locations.map(function (loc) {
          var pos = {"lat": parseFloat(loc["lat"]), "lng": parseFloat(loc["lng"])};
          var label = loc["label"];
          return new google.maps.Marker({
            position: pos,
            label: label,
            map: map
          });
        });

        // var markerCluster = new MarkerClusterer(map, markers,
        //     {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
      });
    });
  }
});

function togglePlaceType() {
  var placeTypeButton = $(this);
  var isSelected = placeTypeButton.hasClass("active");

  console.log("btn: " + placeTypeButton.data("placeTypeId") + " selected: " +isSelected);

  if (isSelected) {
    placeTypeButton.removeClass("active");
  } else {
    placeTypeButton.addClass("active");
  }
}
