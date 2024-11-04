// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, annotate_overrides
 
import 'dart:convert';

import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vil_pricelist/Apis/a_solargard.dart';  
import 'package:vil_pricelist/Helper/myapp-attr.dart';
import 'package:vil_pricelist/Helper/tanggal.dart';
import 'package:vil_pricelist/Helper/wg.dart';
import 'package:vil_pricelist/Models/G/PricesolargardController.dart'; 

class TipeSolargard extends StatefulWidget{  
  final List<String> listTipe;

  const TipeSolargard({super.key, required this.listTipe});  
  @override
  _TipeSolargard createState() => _TipeSolargard();
  
} 

class _TipeSolargard extends State<TipeSolargard>{ 
  
  PricesolargardController pricesolargardController = Get.put(PricesolargardController());
  ApiPriceSolargard apiPriceSolargard = ApiPriceSolargard();
  MyappAttr myappAttr = MyappAttr();

  Tanggal tgl = Tanggal();  
  var headers, body;      
  final _type = TextEditingController();
  
  void initState() { 
    super.initState();  
     myappAttr.retHeader().then((value) =>  setState(() =>  headers  = value ) );
  }

  void dispose(){
    super.dispose();
    _type.dispose();
  }
  

  List<String> kacaDepan = [];
  List<String> kacaBelakang = [];
  List<String> kacaSamping = [];
  List<String> kacaSunRoof = [];
  bool typeSelected = false;

  @override
  Widget build(BuildContext context){ 
    
      return EasyAutocomplete(  
            controller: _type,
            decoration:   InputDecoration(   
              // suffixIcon:  ( _type.text.isNotEmpty)  ? IconButton(
              suffixIcon:  (typeSelected == true)  ? IconButton( 
                onPressed: (){   
                  _type.clear();   
                  _clearKaca();
                  setState(() => typeSelected = false );
                },
                icon: const Icon(Icons.close),
              ) : null,   
              contentPadding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
              enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
              border: const OutlineInputBorder( 
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gapPadding: 0,
              ), 
            ),
            suggestions:  widget.listTipe,
            onChanged: (value)  {
              setState(() => typeSelected = true );
              // _clearKaca() ; 
            },  
            onSubmitted: (v){    
                _clearKaca();
                // Set tipe
                pricesolargardController.setTipe(v);
                // print('Brand : ${pricevkoolController.brand} :: Tipe :  $v');   

                // Set List Harga
                _hargaByPosisi( 'price_front' );
                _hargaByPosisi( 'price_rear' );
                _hargaByPosisi( 'price_side' ); 
                _hargaByPosisi( 'price_sunroof' );
                _type.text = v;
            }, 
          );

  }  

  _hargaByPosisi(String posisi ){
    var body = {  
        "car_brand" : "${pricesolargardController.brand}",
        "car_type" : "${pricesolargardController.tipe}",
        "price" : posisi 
    }; 
    apiPriceSolargard.hargaKacaSolargard(headers, jsonEncode(body) ).then((v){

      bool? status = v!.status; 
      if(status == false){
        snackAlert('Error',  '${v.message}'); 
        return; 
      }
      if(v.data!.isEmpty){
        return;
      }
      var data = v.data; 
      
      if(posisi == 'price_front') {
        pricesolargardController.set_kacaDepan( data ); 
      }
      if(posisi == 'price_side') {
        pricesolargardController.set_kacaSamping( data ); 
      }
      if( posisi ==  'price_rear'){ 
        pricesolargardController.set_kacaBelakang( data ); 
      }
      if( posisi ==  'price_sunroof'){ 
        pricesolargardController.set_kacaSunroof( data ); 
      }
    }) 
    .catchError((e) => snackError('Error Load Harga Mobil', '${e.msg}'));
  }
  
  void _clearKaca(){  
    pricesolargardController.set_kacaDepan([]);
    pricesolargardController.set_kacaBelakang([]);
    pricesolargardController.set_kacaSamping([]);
    pricesolargardController.set_kacaSunroof([]);
      pricesolargardController.set_nilaiKacaDepan(0);
      pricesolargardController.set_nilaiKacaSamping(0);
      pricesolargardController.set_nilaiKacaBelakang(0);
      pricesolargardController.set_nilaiKacaSunroof(0);
    pricesolargardController.clear_subTotal(); 
    pricesolargardController.clear_total(); 
  }

}//End