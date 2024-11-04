// To parse this JSON data, do
//
//     final mMerekFlatglass = mMerekFlatglassFromJson(jsonString);

import 'dart:convert';

MMerekFlatglass mMerekFlatglassFromJson(String str) => MMerekFlatglass.fromJson(json.decode(str));

String mMerekFlatglassToJson(MMerekFlatglass data) => json.encode(data.toJson());

class MMerekFlatglass {
    bool? status;
    String? message;
    List<Datum>? data;

    MMerekFlatglass({
        this.status,
        this.message,
        this.data,
    });

    factory MMerekFlatglass.fromJson(Map<String, dynamic> json) => MMerekFlatglass(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? brandKat;

    Datum({
        this.brandKat,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        brandKat: json["brand_kat"],
    );

    Map<String, dynamic> toJson() => {
        "brand_kat": brandKat,
    };
}
