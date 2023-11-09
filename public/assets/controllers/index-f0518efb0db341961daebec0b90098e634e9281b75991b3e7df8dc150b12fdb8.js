import { application } from "controllers/application"


import ManageBookingController from "./manage_booking_controller"
application.register("manage-booking", ManageBookingController);
