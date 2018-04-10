// "[Pine] Needle," a Leaflet wrapper
export default class Needle {
  static config(coordinates) {
    return {
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors',
      center: coordinates,
      id: 'cj17xqnh8003j2rquui5gm3ar',
      minZoom: 7,
    };
  }

  constructor(coordinates, mapName = 'mdl_map') {
    this.coordinates = coordinates;
    this.mapName = mapName;
    this._map = this._map.bind(this);
    this._tileIt = this._tileIt.bind(this);
    this.pinIt = this.pinIt.bind(this);
    this._attachMap = this._attachMap.bind(this);
    this._attachMap();
    this.onMove = this.onMove.bind(this);
  }

  onMove(handler, ...args) {
    this.map.on('dragend', function(e) {
      handler(e.target.getCenter(), ...args);
    });
  }

  pinIt(coordinates, pinHTML, altText) {
    return (L.marker(coordinates, {alt: `Pin for: ${altText}`})
      .bindPopup(pinHTML)
      .addTo(this.map));
  }

  // Initialize the map and attach it to the DOM
  _attachMap() {
    this.map = this._map();
    this._tileIt();
  }

  _tileIt() {
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      Needle.config(this.coordinates)).addTo(this.map);
  }

  _map() {
    if (!this.maplib) {
      this.maplib = L.map(this.mapName).setView(this.coordinates, 10);
    }
    return this.maplib;
  }
}
