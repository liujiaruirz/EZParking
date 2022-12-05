// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// import * as gmap_style from './gmap_style.json';
// const stylesArray = gmap_style;

var styleArray = [
    {
    "elementType": "labels",
    "stylers": [
    {
    "visibility": "off"
    }
    ]
    },
    {
    "featureType": "administrative.land_parcel",
    "stylers": [
    {
    "visibility": "off"
    }
    ]
    },
    {
    "featureType": "administrative.neighborhood",
    "stylers": [
    {
    "visibility": "on"
    }
    ]
    },
    {
    "featureType": "landscape",
    "stylers": [
    {
    "visibility": "on"
    }
    ]
    },
    {
    "featureType": "road",
    "stylers": [
    {
    "visibility": "on"
    }
    ]
    }
]

function markerStyle(remainingT) {
    if (remainingT < 900) {
        var icon = {
            url: "http://maps.google.com/mapfiles/ms/icons/green-dot.png"
        }
    }
    else if (900 <= remainingT && remainingT < 7200) {
        var icon = {
            url: "http://maps.google.com/mapfiles/ms/icons/yellow-dot.png"
        }
    }
    else if (7200 <= remainingT && remainingT < 21600) {
        var icon = {
            url: "http://maps.google.com/mapfiles/ms/icons/red-dot.png"
        }
    }
    else if (remainingT >= 21600) {
        var icon = {
            url: "http://maps.google.com/mapfiles/ms/icons/purple-dot.png"
        }
    }
    return icon;
}

function indexMap(spots_l) {
    var centerCoords = new google.maps.LatLng(40.807501, -73.962601);
    var mapOptions = {
    styles: styleArray,
    center: centerCoords,
    zoom: 17
    };
    var map = new google.maps.Map(document.getElementById('indexMap'), mapOptions);
    for (let i = 0; i < spots_l.length; i++) {
        spotCoords = new google.maps.LatLng(spots_l[i][1], spots_l[i][2]);
        var geocoder = new google.maps.Geocoder();
        var infowindow = new google.maps.InfoWindow();
        
        var marker = new google.maps.Marker({
            position: spotCoords,
            map: map,
            icon: markerStyle(spots_l[i][0])
        });
        google.maps.event.addListener(marker, 'click', function(){
            window.open("spots/"+spots_l[i][3], "_self");
        })

        // google.maps.event.addListener(marker, 'click', function() {
            // map.setCenter(marker.getPosition());
        geocodeLatLng(geocoder, map, infowindow, spotCoords, spots_l[i][0], marker);
        // });
    }

    infoWindow = new google.maps.InfoWindow();

    const locationButton = document.createElement("button");

    locationButton.textContent = "Center to Current Location";
    locationButton.setAttribute(
        'style',
        'background-color: #fff; border: 0; border-radius: 2px; box-shadow: 0 1px 4px -1px rgba(0, 0, 0, 0.3); margin: 10px; padding: 0 0.5em; font: 400 18px Roboto, Arial, sans-serif; overflow: hidden; height: 40px; cursor: pointer;'
    )
    locationButton.classList.add("custom-map-control-button");
    map.controls[google.maps.ControlPosition.TOP_CENTER].push(locationButton);
    locationButton.addEventListener("click", () => {
        // Try HTML5 geolocation.
        if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
            (position) => {
            const pos = {
                lat: position.coords.latitude,
                lng: position.coords.longitude,
            };

            infoWindow.setPosition(pos);
            infoWindow.setContent("You are here.");
            infoWindow.open(map);
            map.setCenter(pos);
            },
            () => {
            handleLocationError(true, infoWindow, map.getCenter());
            }
        );
        } else {
        // Browser doesn't support Geolocation
        handleLocationError(false, infoWindow, map.getCenter());
        }
    });
}

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
    infoWindow.setPosition(pos);
    infoWindow.setContent(
      browserHasGeolocation
        ? "Error: The Geolocation service failed. Check location sharing permission for your browser."
        : "Error: Your browser doesn't support geolocation."
    );
    infoWindow.open(map);
  }

function geocodeLatLng(geocoder, map, infowindow, spotCoords, t, marker) {
    // const input = document.getElementById("latlng").value;
    // const latlngStr = input.split(",", 2);
    var latlng = spotCoords;
  
    geocoder
      .geocode({ location: latlng })
      .then((response) => {
        if (response.results[0]) {
        //   map.setZoom(11);
  
  
          infowindow.setContent('<b>Address</b>: '+response.results[0].formatted_address+'<br>'+'<b>Time to Leave: </b>' + time_difference(t));
          infowindow.open(map, marker);
        } else {
          console.log("No location details found");
        }
      })
    //   .catch((e) => window.alert("Some of Geocoders failed due to: " + e));
      .catch((e) => console.error(e));
  }

function initMap(time, lat, lng) {
    var myCoords = new google.maps.LatLng(lat, lng);
    var mapOptions = {
    // styles: styleArray,
    center: myCoords,
    zoom: 18
    };
    var map = new google.maps.Map(document.getElementById('map'), mapOptions);
    var marker = new google.maps.Marker({
        position: myCoords,
        map: map,
        icon: markerStyle(time)
    });

    var geocoder = new google.maps.Geocoder();
    var infowindow = new google.maps.InfoWindow();
    geocodeLatLng(geocoder, map, infowindow, myCoords, time, marker);
}
    
// the functionalities (drag markers, default coords) refers to https://pjbelo.medium.com/using-google-maps-api-v3-with-rails-5-2-b066a4b2cf14

function initMap2() {
    var lat = document.getElementById('spot_latitude').value;
    var lng = document.getElementById('spot_longitude').value;
    
    // if not defined create default position
    if (!lat || !lng){
        lat=40.807501;
        lng=-73.962601;
        document.getElementById('spot_latitude').value = lat;
        document.getElementById('spot_longitude').value = lng;
    }
    var myCoords = new google.maps.LatLng(lat, lng);
    var mapOptions = {
    center: myCoords,
    zoom: 20
    };
    var map = new google.maps.Map(document.getElementById('map2'), mapOptions);
    var marker = new google.maps.Marker({
        position: myCoords,
        animation: google.maps.Animation.DROP,
        map: map,
        draggable: true
    });
    // refresh marker position and recenter map on marker
    function refreshMarker(){
        var lat = document.getElementById('spot_latitude').value;
        var lng = document.getElementById('spot_longitude').value;
        var myCoords = new google.maps.LatLng(lat, lng);
        marker.setPosition(myCoords);
        map.setCenter(marker.getPosition());   
    }
    // when input values change call refreshMarker
    document.getElementById('spot_latitude').onchange = refreshMarker;
    document.getElementById('spot_longitude').onchange = refreshMarker;
    // when marker is dragged update input values
    marker.addListener('drag', function() {
        latlng = marker.getPosition();
        newlat=(Math.round(latlng.lat()*1000000))/1000000;
        newlng=(Math.round(latlng.lng()*1000000))/1000000;
        document.getElementById('spot_latitude').value = newlat;
        document.getElementById('spot_longitude').value = newlng;
    });
    // When drag ends, center (pan) the map on the marker position
    marker.addListener('dragend', function() {
        map.panTo(marker.getPosition());   
    });
    infoWindow = new google.maps.InfoWindow();

    const locationButton = document.createElement("button");
    locationButton.setAttribute(
        'type', 
        'button'
    );
    locationButton.setAttribute(
        'style',
        'background-color: #fff; border: 0; border-radius: 2px; box-shadow: 0 1px 4px -1px rgba(0, 0, 0, 0.3); margin: 10px; padding: 0 0.5em; font: 400 14px Roboto, Arial, sans-serif; overflow: hidden; height: 40px; cursor: pointer;'
    )

    locationButton.textContent = "Use My Current Location";
    locationButton.classList.add("custom-map-control-button");
    map.controls[google.maps.ControlPosition.TOP_CENTER].push(locationButton);
    locationButton.addEventListener("click", () => {
        // Try HTML5 geolocation.
        if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
            (position) => {
            const pos = {
                lat: position.coords.latitude,
                lng: position.coords.longitude,
            };

            infoWindow.setPosition(pos);
            // infoWindow.setContent("You are here.");
            // infoWindow.open(map);
            map.setCenter(pos);
            marker.setPosition(pos);
            document.getElementById('spot_latitude').value = pos['lat'];
            document.getElementById('spot_longitude').value = pos['lng'];
            // when input values change call refreshMarker
            document.getElementById('spot_latitude').onchange = refreshMarker;
            document.getElementById('spot_longitude').onchange = refreshMarker;
            // when marker is dragged update input values
            marker.addListener('drag', function() {
                latlng = marker.getPosition();
                newlat=(Math.round(latlng.lat()*1000000))/1000000;
                newlng=(Math.round(latlng.lng()*1000000))/1000000;
                document.getElementById('spot_latitude').value = newlat;
                document.getElementById('spot_longitude').value = newlng;
            });
            // When drag ends, center (pan) the map on the marker position
            marker.addListener('dragend', function() {
                map.panTo(marker.getPosition());   
            });
            },
            () => {
            handleLocationError(true, infoWindow, map.getCenter());
            }
        );
        } else {
        // Browser doesn't support Geolocation
        handleLocationError(false, infoWindow, map.getCenter());
        }
    });

}


function time_difference(difference) {
        
    if (difference < 0) {
        return 'Available Now'
    }

    differenceInYears = Math.floor(difference / (60 * 60 * 24 * 30 * 12))

    difference -= differenceInYears * (60 * 60 * 24 * 30 * 12)

    differenceInMonths = Math.floor(difference / (60 * 60 * 24 * 30))

    difference -= differenceInMonths * (60 * 60 * 24 * 30)

    differenceInDays = Math.floor(difference / (60 * 60 * 24))

    difference -= differenceInDays * (60 * 60 * 24)
    
    differenceInHours = Math.floor(difference / (60 * 60))

    difference -= differenceInHours * (60 * 60)
    
    differenceInMinutes = Math.floor(difference / 60)

    difference -= differenceInMinutes * 60
    
    differenceInSeconds = Math.floor(difference)

    var out = ''
    console.log(differenceInDays)

    if (differenceInYears > 0) {
    out += differenceInYears.toString() + " years "
    }

    if (differenceInMonths > 0) {
    out += differenceInMonths.toString() + " months "
    }

    if (differenceInDays > 0) {
    out += differenceInDays.toString() + " days "
    }

    if (differenceInHours > 0) {
    out += differenceInHours.toString() + " hours "
    }
    if (differenceInMinutes > 0) {
    out += differenceInMinutes.toString() + " mins "
    }
    if (differenceInSeconds > 0) {
    out += differenceInSeconds.toString() + " secs "
    }
    
    return out
}