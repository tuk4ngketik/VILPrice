// To parse this JSON data, do
//
//     final mKacaflmFlatglass = mKacaflmFlatglassFromJson(jsonString);

import 'dart:convert';

MKacaflmFlatglass mKacaflmFlatglassFromJson(String str) => MKacaflmFlatglass.fromJson(json.decode(str));

String mKacaflmFlatglassToJson(MKacaflmFlatglass data) => json.encode(data.toJson());

class MKacaflmFlatglass {
    bool? status;
    String? message;
    List<Datum>? data;

    MKacaflmFlatglass({
        this.status,
        this.message,
        this.data,
    });

    factory MKacaflmFlatglass.fromJson(Map<String, dynamic> json) => MKacaflmFlatglass(
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
    String? serial;
    String? prodKode;
    String? prodName;

    Datum({
        this.serial,
        this.prodKode,
        this.prodName,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        serial: json["serial"],
        prodKode: json["prod_kode"],
        prodName: json["prod_name"],
    );

    Map<String, dynamic> toJson() => {
        "serial": serial,
        "prod_kode": prodKode,
        "prod_name": prodName,
    };
}
