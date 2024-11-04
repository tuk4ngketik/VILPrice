// To parse this JSON data, do
//
//     final mLogin = mLoginFromJson(jsonString);

import 'dart:convert';

MLogin mLoginFromJson(String str) => MLogin.fromJson(json.decode(str));

String mLoginToJson(MLogin data) => json.encode(data.toJson());

class MLogin {
    bool? status;
    String? message;
    Data? data;

    MLogin({
        this.status,
        this.message,
        this.data,
    });

    factory MLogin.fromJson(Map<String, dynamic> json) => MLogin(
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
    String? serial;
    String? username;
    String? firstName;
    String? nickname;
    String? lastName;
    String? gender;
    String? brandActive;
    String? branchName;
    dynamic noHpwa;
    String? cBranchName;
    String? alamat;
    String? kota;

    Data({
        this.serial,
        this.username,
        this.firstName,
        this.nickname,
        this.lastName,
        this.gender,
        this.brandActive,
        this.branchName,
        this.noHpwa,
        this.cBranchName,
        this.alamat,
        this.kota,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        serial: json["serial"],
        username: json["username"],
        firstName: json["first_name"],
        nickname: json["nickname"],
        lastName: json["last_name"],
        gender: json["gender"],
        brandActive: json["brand_active"],
        branchName: json["branch_name"],
        noHpwa: json["no_hpwa"],
        cBranchName: json["c_branch_name"],
        alamat: json["alamat"],
        kota: json["kota"],
    );

    Map<String, dynamic> toJson() => {
        "serial": serial,
        "username": username,
        "first_name": firstName,
        "nickname": nickname,
        "last_name": lastName,
        "gender": gender,
        "brand_active": brandActive,
        "branch_name": branchName,
        "no_hpwa": noHpwa,
        "c_branch_name": cBranchName,
        "alamat": alamat,
        "kota": kota,
    };
}
