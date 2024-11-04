// ignore_for_file: file_names, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_string_interpolations


import 'package:get/get.dart';

class PriceflatglassController extends GetxController{ 

  var merek = ''.obs;
  setMerek(String v) => merek.value = v;
  
  var film = ''.obs;
  setFilm(String v) => film.value = v;

  var hrgPermeter =  0.obs;
  setHrgPermeter(int v) => hrgPermeter.value = v;

  var bagian = ''.obs;
  setBagian(String v) => bagian.value = v; 

  var jasaPasang =  0.obs;
  setJasapasangr(int v) => jasaPasang.value = v;

  double panjang = 0;
  setPanjang(double v) => panjang = v;

  double lebar = 0;
  setLebar(double v) => lebar = v;

  double luas = 0;
  setLuas(double v) => luas = v;

  var qty = 0.obs;
  setQty(int v) => qty.value = v;


  // // Discount,  Sub Total n Total
  var diskon = 0.obs;
  set_diskon( v) => diskon.value = v; 

  var subtotal = 0.obs;
  hitung_subTotal(){ 
    subtotal.value = jasaPasang.value ;  // OK
    // subtotal.value = nilai_kacaDepan.toInt()  + nilai_kacaSamping.toInt() + nilai_kacaBelakang.toInt() + nilai_kacaSunroof.toInt(); // OK juga 
  }
  clear_subTotal(){ 
    subtotal.value = 0;
  }
 
 
}