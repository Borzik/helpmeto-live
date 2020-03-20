import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    const pos = { lat: parseFloat(this.element.dataset.lat), lng: parseFloat(this.element.dataset.lng) };
    this.map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/mapbox/streets-v11',
      center: pos,
      zoom: 14,
    });
    this.map.addControl(new mapboxgl.NavigationControl());
    new mapboxgl.Marker({
      color: '#fc3903'
    }).setLngLat([pos.lng, pos.lat]).addTo(this.map);
  }
}
