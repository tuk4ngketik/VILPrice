// To parse this JSON data, do
//
//     final mHargaKacaSolargard = mHargaKacaSolargardFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

MHargaKacaSolargard mHargaKacaSolargardFromJson(String str) => MHargaKacaSolargard.fromJson(json.decode(str));

String mHargaKacaSolargardToJson(MHargaKacaSolargard data) => json.encode(data.toJson());

class MHargaKacaSolargard {
    bool? status;
    String? message;
    List<Datum>? data;

    MHargaKacaSolargard({
        this.status,
        this.message,
        this.data,
    });

    factory MHargaKacaSolargard.fromJson(Map<String, dynamic> json) => MHargaKacaSolargard(
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
    String? carBrand;
    String? carType;
    String? productName;
    String? priceFront;
    String? priceSide;
    String? priceRear;
    String? priceSunroof;

    Datum({
        this.carBrand,
        this.carType,
        this.productName,
        this.priceFront,
        this.priceSide,
        this.priceRear,
        this.priceSunroof,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        carBrand: json["car_brand"],
        carType: json["car_type"],
        productName: json["product_name"],
        priceFront: json["price_front"],
        priceSide: json["price_side"],
        priceRear: json["price_rear"],
        priceSunroof: json["price_sunroof"],
    );

    Map<String, dynamic> toJson() => {
        "car_brand": carBrand,
        "car_type": carType,
        "product_name": productName,
        "price_front": priceFront,
        "price_side": priceSide,
        "price_rear": priceRear,
        "price_sunroof": priceSunroof,
    };
}
