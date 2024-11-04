// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_returning_null_for_void

import 'dart:convert';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vil_pricelist/Apis/a_solargard.dart';  
import 'package:vil_pricelist/Cfg/css.dart';
import 'package:vil_pricelist/Helper/myapp-attr.dart'; 
import 'package:vil_pricelist/Helper/wg.dart';
import 'package:vil_pricelist/Models/G/PricesolargardController.dart';
import 'package:vil_pricelist/View/Solargard/tipe.dart'; 

class MerekSolargard extends StatefulWidget{  
  final List<String> listMerek; 
  const MerekSolargard({super.key,  required this.listMerek});
  @override
  _MerekSolargard createState() => _MerekSolargard();  
} 

class _MerekSolargard extends State<MerekSolargard>{  

  MyappAttr myappAttr = MyappAttr();
  ApiPriceSolargard apiPriceSolargard = ApiPriceSolargard();
  PricesolargardController pricesolargardController = Get.put( PricesolargardController());
   
  var headers, body;
  String? car_brand;
  List<String> carTypes = [];  
   
  @override
  void initState() { 
    super.initState();  
     myappAttr.retHeader().then((value) =>  setState(() =>  headers  = value ) );
  }
 
  _getTipe(String car_brand){  
    body = {
      'car_brand' : car_brand
    };
    apiPriceSolargard.tipe(headers, jsonEncode(body) ).then((value){
       
      if(value!.status == false){
        snackAlert('Error',  '${value.message}'); 
        return;
      }
      var data = value.data; 
      data!.forEach((element) {
        // print('element ${element.carBrand} : ${element.carType}');
        setState(() {
          carTypes.add('${element.carType}');
        });
      }); 
    })
    .catchError((e) => snackError('Error Load Merk Mobil', '${e.msg}'));
  }

  final _merek = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _merek.dispose(); 
  }

  @override
  Widget build(BuildContext context){ 
    
    return Column(
      children: [

        Card(  
          // shadowColor: Color.fromARGB(255, 235, 194, 70), 
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 0, right: 0),
              title: Text('Merk', style: Css.labelHarga,),
              subtitle: EasyAutocomplete(  
                controller: _merek,
                decoration:   InputDecoration(   
                  suffixIcon:  ( _merek.text.isNotEmpty )  ? IconButton(
                    onPressed: (){ 
                      print('Merek clear');  
                      _merek.text = '';
                      _clearKaca();
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
                suggestions:  widget.listMerek,
                onChanged: (value)  {  
                  print('onchange');
                  _clearKaca();
                },  
                onSubmitted: (v){     
                    print('onSubmiit $v'); 
                    pricesolargardController.setBrand(v);
                    _getTipe(v);
                  }, 
              ),
            ),
          ),
        ),
         
        Card( 
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 0, right: 0),
              title: Text('Tipe', style: Css.labelHarga,), 
              subtitle: (carTypes.isEmpty) ? const Text(' -- Pilih Tipe --  ')  : TipeSolargard(listTipe: carTypes), 
            ),
          ),
        ),
 

      ],
    );

  } 

  void _clearKaca(){
    setState(() =>  carTypes = [] );
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