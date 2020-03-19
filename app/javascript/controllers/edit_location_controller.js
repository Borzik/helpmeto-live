import { Controller } from "stimulus"
import MapboxLanguage from '@mapbox/mapbox-gl-language';

export default class extends Controller {
  static targets = [ "map", "latInput", "lngInput"]
  createMap(pos, zoom) {
    this.map = new mapboxgl.Map({
      container: this.mapTarget,
      style: 'mapbox://styles/mapbox/streets-v10',
      center: pos,
      zoom: zoom,
    });
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
    this.map.addControl(new mapboxgl.NavigationControl());
    this.map.addControl(new MapboxLanguage());
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
