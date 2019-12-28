// To parse this JSON data, do
//
//     final sendEmail = sendEmailFromJson(jsonString);

import 'dart:convert';

SendEmail sendEmailFromJson(String str) => SendEmail.fromJson(json.decode(str));

String sendEmailToJson(SendEmail data) => json.encode(data.toJson());

class SendEmail {
  List<Personalization> personalizations;
  From from;
  String subject;
  List<Content> content;

  SendEmail({
    this.personalizations,
    this.from,
    this.subject,
    this.content,
  });

  factory SendEmail.fromJson(Map<String, dynamic> json) => new SendEmail(
        personalizations: new List<Personalization>.from(
            json["personalizations"].map((x) => Personalization.fromJson(x))),
        from: From.fromJson(json["from"]),
        subject: json["subject"],
        content: new List<Content>.from(
            json["content"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "personalizations":
            new List<dynamic>.from(personalizations.map((x) => x.toJson())),
        "from": from.toJson(),
        "subject": subject,
        "content": new List<dynamic>.from(content.map((x) => x.toJson())),
      };
}

class Content {
  String type;
  String value;

  Content({
    this.type,
    this.value,
  });

  factory Content.fromJson(Map<String, dynamic> json) => new Content(
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
      };
}

class From {
  String email;

  From({
    this.email,
  });

  factory From.fromJson(Map<String, dynamic> json) => new From(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}

class Personalization {
  List<From> to;

  Personalization({
    this.to,
  });

  factory Personalization.fromJson(Map<String, dynamic> json) =>
      new Personalization(
        to: new List<From>.from(json["to"].map((x) => From.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "to": new List<dynamic>.from(to.map((x) => x.toJson())),
      };
}
