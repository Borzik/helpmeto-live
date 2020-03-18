import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "map", "latInput", "lngInput", "addressInput"]
  createMap(pos, zoom) {
    this.map = new google.maps.Map(this.mapTarget, {
      center: pos,
      zoom: zoom,
      clickableIcons: false,
      streetViewControl: false,
      scaleControl: true,
    });
    this.map.addListener('click', (e) => {
      this.createMarker(e.latLng);
      this.map.panTo(e.latLng);
      this.latInputTarget.value = e.latLng.lat();
      this.lngInputTarget.value = e.latLng.lng();
    });
  }

  createMarker(pos) {
    if (this.marker) this.marker.setMap(null);
    this.marker = new google.maps.Marker({
      position: pos,
      map: this.map,
    });
  }

  find() {
    const address = this.addressInputTarget.value;
    const geocoder = new google.maps.Geocoder();
    geocoder.geocode( { 'address': address}, (results, status) => {
      if (status == 'OK') {
        this.createMarker(results[0].geometry.location);
        this.map.panTo(results[0].geometry.location);
      } else {
        alert('We could not find this address. Please find your place on a map and click it to put a red marker');
      }
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
