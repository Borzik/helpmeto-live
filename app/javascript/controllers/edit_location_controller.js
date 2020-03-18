import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "map", "latInput", "lngInput" ]
  createMap(pos, zoom) {
    this.map = new google.maps.Map(this.mapTarget, {
      center: pos,
      zoom: zoom,
      clickableIcons: false,
      streetViewControl: false,
      scaleControl: true,
    });
    this.map.addListener('click', (e) => {
      if (this.marker) this.marker.setMap(null);
      this.createMarker(e.latLng);
      this.map.panTo(e.latLng);
      this.latInputTarget.value = e.latLng.lat();
      this.lngInputTarget.value = e.latLng.lng();
    });
  }

  createMarker(pos) {
    this.marker = new google.maps.Marker({
      position: pos,
      map: this.map,
    });
  }

  connect() {
    const lcLat = parseFloat(this.data.get('lat'));
    const lcLng = parseFloat(this.data.get('lng'));
    if (lcLat && lcLng) {
      const pos = { lat: lcLat, lng: lcLng }
      this.createMap(pos, 14);
      this.createMarker(pos)
      return;
    }

    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition((position) => {
        this.createMap({ lat: position.coords.latitude, lng: position.coords.longitude }, 8);
      }, () => {
        alert('Cannot find your location. Please select it on the map.');
      });
    }

    if (!this.map) this.createMap({ lat: 43.273328, lng: 0 }, 2)
  }
}
