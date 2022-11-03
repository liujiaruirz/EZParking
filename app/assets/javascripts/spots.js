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

function markerStyle(time2leave) {
    if (time2leave < 10) {
        var icon = {
            url: "http://maps.google.com/mapfiles/ms/icons/green-dot.png"
        }
    }
    else if (10 <= time2leave && time2leave < 30) {
        var icon = {
            url: "http://maps.google.com/mapfiles/ms/icons/yellow-dot.png"
        }
    }
    else if (time2leave >= 30) {
        var icon = {
            url: "http://maps.google.com/mapfiles/ms/icons/red-dot.png"
        }
    }
    return icon;
}

function indexMap(spots_l) {
    var centerCoords = new google.maps.LatLng(40.8075, -73.9626);
    var mapOptions = {
    styles: styleArray,
    center: centerCoords,
    zoom: 17
    };
    var map = new google.maps.Map(document.getElementById('indexMap'), mapOptions);
    for (let i = 0; i < spots_l.length; i++) {
        spotCoords = new google.maps.LatLng(spots_l[i][1], spots_l[i][2]);
        
        var marker = new google.maps.Marker({
            position: spotCoords,
            map: map,
            icon: markerStyle(spots_l[i][0])
        });
    }
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
}
    
// the functionalities (drag markers, default coords) refers to https://pjbelo.medium.com/using-google-maps-api-v3-with-rails-5-2-b066a4b2cf14

function initMap2() {
    var lat = document.getElementById('spot_latitude').value;
    var lng = document.getElementById('spot_longitude').value;
    
    // if not defined create default position
    if (!lat || !lng){
        lat=40.8075;
        lng=-73.9626;
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
}