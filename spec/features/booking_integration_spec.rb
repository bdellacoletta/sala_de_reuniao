require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

def wait_for_ajax
  Timeout.timeout(Capybara.default_max_wait_time) do
    loop until finished_all_stimulus_requests?
  end
end

def finished_all_stimulus_requests?
  page.evaluate_script('window.performance.getEntriesByType("resource").filter(entry => entry.initiatorType === "xmlhttprequest").length').zero?
end

RSpec.feature 'Booking Integration', type: :feature do
  let(:user) { create(:user) }

  before(:each) do
    login_as(user, scope: :user)
  end

  scenario 'User creates a booking', js: true do
    visit root_path
    puts "bookings before: #{user.bookings.count}"
    first("button[data-action='click->manage-booking#newBooking']", wait: 10).click
    sleep 2
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_current_path(root_path, wait: 10)
  end

  scenario 'User edits a booking', js: true do
    booking = Booking.create!(user: user, booking_datetime: "#{Date.today} #{Time.now.hour + 1}:00:00")

    visit root_path
    find("button[data-bs-target='#editBookingModal#{booking.id}']").click
    within('.modal') do
      sleep 2
      fill_in 'booking[booking_datetime]', with: '01-12-2023'
      sleep 2
      find('input[type="submit"]').click
    end
    sleep 2
    expect(page).to have_content('Reserva alterada.')
  end

  scenario 'Show a booking', js: true do
    booking = Booking.create!(user: user, booking_datetime: "#{Date.today} #{Time.now.hour + 1}:00:00")

    visit root_path
    find("button[data-bs-target='#showBookingModal#{booking.id}']").click
    within('.modal') do
      sleep 2
      expect(page).to have_content('Dados da reserva da Sala de Reunião')
    end
  end

  scenario 'User cancels a booking', js: true do
    booking = create(:booking, user: user, booking_datetime: "#{Date.today} #{Time.now.hour + 1}:00:00")

    visit root_path
    find("button[data-manage-booking-target='bookingId'][value='#{booking.id}']").click
    page.driver.browser.switch_to.alert.accept
    page.driver.browser.execute_script("fetch('/bookings/#{booking.id}', { method: 'DELETE' })")
    wait_for_ajax
    expect(page).to have_current_path(root_path, wait: 10)
  end
end
