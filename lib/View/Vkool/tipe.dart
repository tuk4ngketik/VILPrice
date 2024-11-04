// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, annotate_overrides
 
import 'dart:convert';

import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:vil_pricelist/Apis/a_vkool.dart';
import 'package:vil_pricelist/Helper/myapp-attr.dart';
import 'package:vil_pricelist/Helper/tanggal.dart';
import 'package:vil_pricelist/Helper/wg.dart';
import 'package:vil_pricelist/Models/G/PricevkoolController.dart'; 

class TipeVkool extends StatefulWidget{  
  final List<String> listTipe;

  const TipeVkool({super.key, required this.listTipe});  
  @override
  _TipeVkool createState() => _TipeVkool();
  
} 

class _TipeVkool extends State<TipeVkool>{ 
 
  PricevkoolController pricevkoolController = Get.put(PricevkoolController());
  ApiPricevkool apiPricevkool = ApiPricevkool();
  MyappAttr myappAttr = MyappAttr();

  Tanggal tgl = Tanggal();  
  var headers, body;  
    
  
  void initState() { 
    super.initState();  
     myappAttr.retHeader().then((value) =>  setState(() =>  headers  = value ) );
  }

  void dispose(){
    super.dispose();
    _type.dispose();
  }
  
  final _type = TextEditingController();

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
                  _clearKaca();
                  _type.clear();   
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
              _clearKaca() ; 
            },  
            onSubmitted: (v){    
                _clearKaca();
                // Set tipe
                pricevkoolController.setTipe(v);
                print('Brand : ${pricevkoolController.brand} :: Tipe :  $v');   

                // Set List Harga
                _hargaByPosisi( 'Depan' );
                _hargaByPosisi( 'Belakang' );
                _hargaByPosisi( 'Samping' ); 
                _hargaByPosisi( 'Sun Roof' );
                _type.text = v;
            }, 
          );

  }  

  _hargaByPosisi(String posisi ){ 
    var body = {  
        "car_brand" : "${pricevkoolController.brand}",
        "car_type" : "${pricevkoolController.tipe}",
        "posisi" : posisi 
    }; 
    apiPricevkool.harga(headers, jsonEncode(body) ).then((v){

      bool? status = v!.status; 
      if(status == false){
        snackAlert('Error',  '${v.message}'); 
        return; 
      }
      if(v.data!.isEmpty){
        return;
      }
      var data = v.data; 
      
      if(posisi == 'Depan') {
        pricevkoolController.set_kacaDepan( data ); 
      }
      if(posisi == 'Samping') {
        pricevkoolController.set_kacaSamping( data ); 
      }
      if( posisi ==  'Belakang'){ 
        pricevkoolController.set_kacaBelakang( data ); 
      }
      if( posisi ==  'Sun Roof'){ 
        pricevkoolController.set_kacaSunroof( data ); 
      }
    }) 
    .catchError((e) => snackError('Error Load Harga Mobil', '${e.msg}'));
  }
  
  void _clearKaca(){  
    pricevkoolController.set_kacaDepan([]);
    pricevkoolController.set_kacaBelakang([]);
    pricevkoolController.set_kacaSamping([]);
    pricevkoolController.set_kacaSunroof([]);
      pricevkoolController.set_nilaiKacaDepan(0);
      pricevkoolController.set_nilaiKacaSamping(0);
      pricevkoolController.set_nilaiKacaBelakang(0);
      pricevkoolController.set_nilaiKacaSunroof(0);
    pricevkoolController.clear_subTotal(); 
    pricevkoolController.clear_total(); 
  }

}//End