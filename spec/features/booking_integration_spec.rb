
require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

RSpec.feature 'Booking Integration', type: :feature do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
  end

  scenario 'User creates a booking', js: true do
    visit root_path
    first("button[data-action='click->manage-booking#newBooking']", wait: 10).click
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_current_path(root_path)
  end

  scenario 'User edits a booking', js: true do
    datetime = "#{Date.today+1} #{Time.now.hour-3}:00:00"
    booking = create(:booking, user_id: user.id, booking_datetime: datetime)

    visit root_path

    # find("button[data-bs-target='#editBookingModal#{booking.id}']").click
    # expect(page).to have_css('.modal.show', wait: 5)

    # within('.modal') do
    #   fill_in 'booking[booking_datetime]', with: '2023-12-01 10:00:00'
    #   find('input[type="submit"]').click
    # end

    # expect(page).to have_content('Reserva alterada.')
  end

  # scenario 'User cancels a booking', js: true do
  #   # Assuming there's a booking that the user has previously created
  #   booking = create(:booking, user: user, booking_datetime: "#{Date.today+1} #{Time.now.hour-2}:00:00")

  #   visit root_path

  #   # Find and click the button to delete the booking
  #   find("button[data-manage-booking-target='bookingId'][value='#{booking.id}']").click

  #   # Confirm the deletion in the alert dialog
  #   page.driver.browser.switch_to.alert.accept

  #   # Assert that the booking was canceled successfully
  #   expect(page).to have_content('Reserva cancelada.')
  # end
end
