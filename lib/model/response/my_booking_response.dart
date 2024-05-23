// To parse this JSON data, do
//
//     final myBookingResponse = myBookingResponseFromJson(jsonString);

import 'dart:convert';

MyBookingResponse myBookingResponseFromJson(String str) => MyBookingResponse.fromJson(json.decode(str));

String myBookingResponseToJson(MyBookingResponse data) => json.encode(data.toJson());

class MyBookingResponse {
  bool? success;
  String? message;
  List<Booking>? bookings;

  MyBookingResponse({
    this.success,
    this.message,
    this.bookings,
  });

  factory MyBookingResponse.fromJson(Map<String, dynamic> json) => MyBookingResponse(
    success: json["success"],
    message: json["message"],
    bookings: List<Booking>.from(json["bookings"].map((x) => Booking.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "bookings": List<dynamic>.from(bookings!.map((x) => x.toJson())),
  };
}

class Booking {
  String? id;
  EventId? eventId;
  String? userId;
  String? email;
  String? contact;
  String? fullname;
  DateTime? bookedAt;
  int? ticketQuantity;
  bool? isPaid;
  DateTime? createdAt;

  Booking({
    this.id,
    this.eventId,
    this.userId,
    this.email,
    this.contact,
    this.fullname,
    this.bookedAt,
    this.ticketQuantity,
    this.isPaid,
    this.createdAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["_id"],
    eventId: EventId.fromJson(json["eventId"]),
    userId: json["userId"],
    email: json["email"],
    contact: json["contact"],
    fullname: json["fullname"],
    bookedAt: DateTime.parse(json["bookedAt"]),
    ticketQuantity: json["ticketQuantity"],
    isPaid: json["isPaid"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "eventId": eventId?.toJson(),
    "userId": userId,
    "email": email,
    "contact": contact,
    "fullname": fullname,
    "bookedAt": bookedAt?.toIso8601String(),
    "ticketQuantity": ticketQuantity,
    "isPaid": isPaid,
    "createdAt": createdAt?.toIso8601String(),
  };
}


class EventId {
  bool? isDeleted;
  String? id;
  String? eventTitle;
  String? image;
  int? price;
  String? location;
  String? details;
  DateTime? eventDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  EventId({
    this.isDeleted,
    this.id,
    this.eventTitle,
    this.image,
    this.price,
    this.location,
    this.details,
    this.eventDate,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory EventId.fromJson(Map<String, dynamic> json) => EventId(
    isDeleted: json["is_deleted"],
    id: json["_id"],
    eventTitle: json["eventTitle"],
    image: json["image"],
    price: json["price"],
    location: json["location"],
    details: json["details"],
    eventDate: DateTime.parse(json["eventDate"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "is_deleted": isDeleted,
    "_id": id,
    "eventTitle": eventTitle,
    "image": image,
    "price": price,
    "location": location,
    "details": details,
    "eventDate": eventDate?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
