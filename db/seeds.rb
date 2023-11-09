user1 = User.create(name: "Maria", email: "maria@email.com", password: "maria123")
user2 = User.create(name: "João", email: "joao@email.com", password: "joao123")
user3 = User.create(name: "Carlos", email: "carlos@email.com", password: "carlos123")

Booking.create(user: user1, booking_datetime: "2023-11-14 09:00:00")
Booking.create(user: user1, booking_datetime: "2023-11-20 09:00:00")
Booking.create(user: user2, booking_datetime: "2023-11-17 14:00:00")
Booking.create(user: user3, booking_datetime: "2023-11-15 15:00:00")
