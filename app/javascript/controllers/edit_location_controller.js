import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "map", "latInput", "lngInput"]
  createMap(pos, zoom) {
    this.map = new mapboxgl.Map({
      container: this.mapTarget,
      style: 'mapbox://styles/mapbox/streets-v11',
      center: pos,
      zoom: zoom,
    });
    this.map.addControl(new mapboxgl.NavigationControl());
    this.map.on('click', (e) => {
      this.createMarker(e.lngLat);
      this.map.panTo(e.lngLat);
      this.latInputTarget.value = e.lngLat.lat;
      this.lngInputTarget.value = e.lngLat.lng;
    });
    const geocoder = new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl,
      marker: false,
    })
    geocoder.on('result', ({ result }) => {
      this.createMarker(result.center);
    })
    this.map.addControl(geocoder);
  }

  createMarker(pos) {
    if (this.marker) this.marker.remove();
    this.marker = new mapboxgl.Marker().setLngLat(pos).addTo(this.map);
  }

  connect() {
    const lcLat = parseFloat(this.data.get('lat'));
    const lcLng = parseFloat(this.data.get('lng'));
    if (lcLat && lcLng) {
      const pos = [lcLng, lcLat];
      this.createMap(pos, 14);
      this.createMarker(pos)
    } else {
      this.createMap([0, 43.273328], 2)
    }
  }
}
