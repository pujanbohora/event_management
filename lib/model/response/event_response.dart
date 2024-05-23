// To parse this JSON data, do
//
//     final eventResponse = eventResponseFromJson(jsonString);

import 'dart:convert';

EventResponse eventResponseFromJson(String str) => EventResponse.fromJson(json.decode(str));

String eventResponseToJson(EventResponse data) => json.encode(data.toJson());

class EventResponse {
  bool? success;
  String? message;
  List<Event>? events;

  EventResponse({
    this.success,
    this.message,
    this.events,
  });

  factory EventResponse.fromJson(Map<String, dynamic> json) => EventResponse(
    success: json["success"],
    message: json["message"],
    events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "events": List<dynamic>.from(events!.map((x) => x.toJson())),
  };
}

class Event {
  String? id;
  String? eventTitle;
  String? image;
  int? price;
  String? location;
  String? details;
  DateTime? eventDate;
  DateTime? createdAt;

  Event({
    this.id,
    this.eventTitle,
    this.image,
    this.price,
    this.location,
    this.details,
    this.eventDate,
    this.createdAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json["_id"],
    eventTitle: json["eventTitle"],
    image: json["image"],
    price: json["price"],
    location: json["location"],
    details: json["details"],
    eventDate: DateTime.parse(json["eventDate"]),
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "eventTitle": eventTitle,
    "image": image,
    "price": price,
    "location": location,
    "details": details,
    "eventDate": eventDate?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
  };
}
