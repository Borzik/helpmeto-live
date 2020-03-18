import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    this.map = new google.maps.Map(this.element, {
      center: {
        lng: parseFloat(this.data.get('lng')),
        lat: parseFloat(this.data.get('lat')),
      },
      zoom: 12,
      clickableIcons: false,
      streetViewControl: false,
      scaleControl: true,
    });

    const needs = JSON.parse(this.data.get('list'));
    needs.forEach((need) => {
      var marker = new google.maps.Marker({
        position: {
          lng: need.lc_lng,
          lat: need.lc_lat,
        },
        map: this.map,
      });
      marker.addListener('click', function() {
        var win = window.open(`/needs/${need.id}`);
        win.focus();
      });
    })
  }
}
