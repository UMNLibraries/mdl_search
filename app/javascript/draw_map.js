import Needle from './needle.js';
import LinkedThumbnail from './linked_thumbnail.js';

function pinHTML(location) {
  return (new LinkedThumbnail(location.title_ssi,
                              location.id,
                              location.type_ssi,
                              location.anchor)).toHtml();
}

function reDrawMap(coordinates, needle) {
  const coords = `${coordinates.lat},${coordinates.lng}`.replace(/\./g, '+');
  $.ajax({
    url: `/nearbys/${coords}`,
    jsonp: 'callback',
    dataType: 'jsonp',
    success: function (nearbyLocations) {
      nearbyLocations.forEach((location) => {
        needle.pinIt(location.coordinates_llsi.split(','), pinHTML(location));
      });
    },
    error: function (xhr, type, exception) {
      console(`${type} ---- ${exception}`);
    },
  });
}

export default function drawMap(coordinates, nearbyLocations, mapName) {
  const needle = new Needle(coordinates, mapName);
  nearbyLocations.forEach((location) => {
    needle.pinIt(location.coordinates_llsi.split(','), pinHTML(location), `${location.title_ssi.substring(0, 50)}...`);
  });
  needle.onMove(reDrawMap, needle);
  return needle;
}

