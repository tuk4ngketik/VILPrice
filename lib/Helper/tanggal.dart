// import 'package:flutter/material.dart';

// ignore_for_file: non_constant_identifier_names

class Tanggal{ 
  // date 2023-03-07 10:00:02.617882
  DateTime  sekarang = DateTime.now();
  
  String ymdDetik (){
    final ymd =   DateTime.utc( sekarang.year, sekarang.month, sekarang.day);
    return ymd.toString();
  }

  // thn-bln-tgl 
  String ymdDash(){
    String tgl = ymdDetik();
    final splitted = tgl.split(' ');
    return splitted[0]; 
  }
  String ymd(){ 
    String tgl = ymdDetik();
    final a = tgl.split(' ');
    final s = a[0].split('-');
    return '${s[0]}${s[1]}${s[2]}'; 
  }

  // tgl-bln-thn
  String dmyDash(){
    String tgl = ymdDetik();
    final dmy = tgl.split(' '); 
    final s = dmy[0].split('-');
    return '${s[2]}-${s[1]}-${s[0]}'; 
  }

  String dmy(){
    String tgl = ymdDetik();
    final dmy = tgl.split(' '); 
    final s = dmy[0].split('-');
    return '${s[2]}${s[1]}${s[0]}'; 
  }

  // Convert Y-m-d H:i:s ket tgl-bln-thn
  String convertTanggal(String date_time){ 
    final dmy = date_time.split(' '); 
    final s = dmy[0].split('-');
    return '${s[2]}-${s[1]}-${s[0]}'; 
  }
  // Convert Y-m-d H:i:s ket jam:menit:detik
  String convertJam(String date_time){ 
    final dmy = date_time.split(' '); 
    return dmy[1]; 
  }

}