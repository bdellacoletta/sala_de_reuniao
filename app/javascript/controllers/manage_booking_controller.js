import {Controller} from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [ 'bookingId' ]

  deleteBooking() {
    if (window.confirm("Tem certeza que deseja cancelar a sua reserva?")) {
      this.#delete()
      window.location.reload(true)
    }
  }

  #delete() {
    const csrfToken = document.head.querySelector("[name='csrf-token']").content;
    const id = this.bookingIdTarget.value

    fetch(`/bookings/${id}`, {
      method: 'DELETE',
      headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': csrfToken
      }
    })
    .then(response => response.json())
  }
}
