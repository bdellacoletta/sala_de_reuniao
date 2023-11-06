user1 = User.create(name: "Maria", email: "maria@teste.com", password: "maria123")
user2 = User.create(name: "João", email: "joao@teste.com", password: "joao123")

Booking.create(user: user1, booking_datetime: "2023-11-27 09:00:00")
Booking.create(user: user1, booking_datetime: "2023-11-28 09:00:00")
Booking.create(user: user2, booking_datetime: "2023-11-27 14:00:00")
