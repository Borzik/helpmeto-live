import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    const pos = { lat: parseFloat(this.element.dataset.lat), lng: parseFloat(this.element.dataset.lng) };
    this.map = new google.maps.Map(this.element, {
      center: pos,
      zoom: 14,
      clickableIcons: false,
      streetViewControl: false,
      scaleControl: true,
    });
    new google.maps.Marker({ position: pos, map: this.map });
  }
}
