import 'package:flutter/material.dart';

class Css {

  // Title 
  static TextStyle titlePage  = const TextStyle(color: Colors.black, fontSize: 20);


  // Formc 
  static OutlineInputBorder roundInput20 = const OutlineInputBorder(
                      borderSide: BorderSide(width:0, strokeAlign: 0, color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(20)),  
                    ); 

  static OutlineInputBorder round20 = const OutlineInputBorder(
                      borderSide: BorderSide(width: 0.1, strokeAlign: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(20)),  
                    ); 

   

  static TextStyle labelLoginStyle = const TextStyle(color: Colors.white, fontSize: 13);

  static TextStyle labelStyle = const TextStyle(color: Colors.black, fontSize: 13);

  static TextStyle labelKelengkapan = const TextStyle(color: Colors.yellow, fontSize: 15,  );
  
  // Profil
  static TextStyle profilLabel = const TextStyle(color: Colors.grey, fontSize: 15);
  static TextStyle profilText = const TextStyle(color: Colors.black, fontSize: 17, );

  // Harga
  static TextStyle labelHarga = const TextStyle(color: Colors.black, fontSize: 17); 

  static TextStyle labelTarif= const  TextStyle( color: Colors.black,   fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 18,   );
  
  static TextStyle textTotal = const TextStyle(color: Colors.white, fontSize: 18); 

  // Bottom Bar
  static OutlineInputBorder roundBottomAppbar = const OutlineInputBorder(
                      borderSide: BorderSide(width: 0.1, strokeAlign: 0.5),
                      // borderRadius: BorderRadius.all(Radius.circular(20))
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      )
                    ); 

 // POints List
  static TextStyle pointsLead = const TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold); 
  static TextStyle pointsTitle = const TextStyle(color: Colors.black,   fontWeight: FontWeight.bold); 
  static TextStyle pointsSubTitle = const TextStyle(color: Colors.black, fontSize: 17); 

 // Poin Detail
 static TextStyle pointsDetail = const TextStyle(color: Colors.black, fontSize: 17); 
 static TextStyle pointsDetailExp = const TextStyle(color: Colors.red, fontSize: 17); 

  // Button
  // use : TextButton.styleFrom ( shape : )
  static StadiumBorder stadiumBorderBlack = const  StadiumBorder( side: BorderSide( width: 0.8, color: Colors.grey ) );

}