// To parse this JSON data, do
//
//     final mHargaPermeter = mHargaPermeterFromJson(jsonString);

import 'dart:convert';

MHargaPermeter mHargaPermeterFromJson(String str) => MHargaPermeter.fromJson(json.decode(str));

String mHargaPermeterToJson(MHargaPermeter data) => json.encode(data.toJson());

class MHargaPermeter {
    bool? status;
    String? message;
    Data? data;

    MHargaPermeter({
        this.status,
        this.message,
        this.data,
    });

    factory MHargaPermeter.fromJson(Map<String, dynamic> json) => MHargaPermeter(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    String? prodName;
    String? hargaM;
    String? hargaJasa;

    Data({
        this.prodName,
        this.hargaM,
        this.hargaJasa,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        prodName: json["prod_name"],
        hargaM: json["harga_m"],
        hargaJasa: json["harga_jasa"],
    );

    Map<String, dynamic> toJson() => {
        "prod_name": prodName,
        "harga_m": hargaM,
        "harga_jasa": hargaJasa,
    };
}
