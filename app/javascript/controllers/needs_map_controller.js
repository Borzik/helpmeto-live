import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    this.map = new mapboxgl.Map({
      container: this.element,
      center: {
        lng: parseFloat(this.data.get('lng')),
        lat: parseFloat(this.data.get('lat')),
      },
      zoom: 12,
      style: 'mapbox://styles/mapbox/streets-v11',
    });

    this.map.addControl(new mapboxgl.NavigationControl());

    const needs = JSON.parse(this.data.get('list'));
    needs.forEach((need) => {
      const popupContent = `${need.description} <br><a href="/needs/${need.id}" class="text-blue-800" target="_blank">${I18n.learn_more}</a>`
      let popup = new mapboxgl.Popup({offset: 25}).setHTML(popupContent);
      new mapboxgl.Marker().setLngLat([need.lc_lng, need.lc_lat]).setPopup(popup).addTo(this.map);
    })
  }
}
