// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_returning_null_for_void, annotate_overrides, file_names


import 'dart:convert';

import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vil_pricelist/Apis/a_flatglass.dart'; 
import 'package:vil_pricelist/Models/G/PriceflatglassController.dart'; 

class FlatglassFilm extends StatefulWidget{  
  final List<String> listFilm; 
  final headers;
  const FlatglassFilm({super.key,  required this.listFilm, required this.headers, });
  @override
  _FlatglassFilm createState() => _FlatglassFilm();  
} 

class _FlatglassFilm extends State<FlatglassFilm>{  
 
  
  final apiPriceFlatglass = ApiPriceFlatglass();
  final priceflatglassController = Get.put(PriceflatglassController());
  final _film = TextEditingController();
  // String? _film;
   
  void initState() { 
    super.initState();   
  } 
  
  void dispose() {
    super.dispose();
    // _film.dispose(); 
  }

  @override
  Widget build(BuildContext context){ 
    
    return 
      EasyAutocomplete(  
        controller: _film,
        decoration:   InputDecoration(   
          suffixIcon:  ( _film.text.isNotEmpty )  ? IconButton( 
              onPressed: (){ 
                print('Film clear');    
                _clearFilm();
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
        suggestions:  widget.listFilm,
        onChanged: (v)  {   
          setState(()  => _film.text = v ); 
          priceflatglassController.setFilm(v);
          print('onchange $v _film.tex $_film'); 
          _gethargaPermeter(v);
        },  
      );

  } 

  _gethargaPermeter(String prod_name){
    var data ={ "prod_name" : prod_name  };
    apiPriceFlatglass.hargaPermeter(widget.headers, jsonEncode(data)).then((v){
      bool? status = v!.status; 
      if(status == false){ 
          priceflatglassController.setHrgPermeter(0);
          return; 
      } 
      var data = v.data; 
      priceflatglassController.setJasapasangr( int.parse('${data!.hargaJasa}') );
      priceflatglassController.setHrgPermeter( int.parse('${data.hargaM}') );
      print('data.hargaM ${data.hargaM} data.hargaJasa: ${data.hargaJasa}'); 

    });
  }

  _clearFilm(){
    setState(()  => _film.clear()  );
    priceflatglassController.setFilm('');         // Hapus Film
    priceflatglassController.setBagian('');       // Hapus Bagian
    priceflatglassController.setHrgPermeter(0);   // Harga perMeter 
    priceflatglassController.setJasapasangr(0);   // Jasa Pasang
  }
 
}//End