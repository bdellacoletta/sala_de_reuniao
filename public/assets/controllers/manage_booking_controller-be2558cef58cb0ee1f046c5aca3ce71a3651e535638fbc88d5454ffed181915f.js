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

  newBooking(event) {
    const element = event.currentTarget;
    const date = element.dataset.date;
    const hour = element.dataset.hour;
    if (window.confirm(`Tem certeza que deseja fazer a sua reserva para o dia ${date} às ${hour}:00h?`)) {
      this.#create(date, hour)
      window.location.reload(true)
    }
  }

  #create(date, hour) {
    const csrfToken = document.head.querySelector("[name='csrf-token']").content;
    const bookingDatetime = `${date} ${hour}:00:00`

    fetch('/bookings', {
      method: 'POST',
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({ booking_datetime: bookingDatetime })
    })
    .then(response => response.json())
  }
};
