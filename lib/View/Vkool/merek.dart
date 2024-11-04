// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_returning_null_for_void

import 'dart:convert';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:vil_pricelist/Apis/a_vkool.dart';
import 'package:vil_pricelist/Cfg/css.dart';
import 'package:vil_pricelist/Helper/myapp-attr.dart';
import 'package:vil_pricelist/Helper/tanggal.dart';
import 'package:vil_pricelist/Helper/wg.dart';
import 'package:vil_pricelist/Models/G/PricevkoolController.dart'; 
import 'package:vil_pricelist/View/Vkool/tipe.dart';

class MerekVkool extends StatefulWidget{  
  final List<String> listMerek; 
  const MerekVkool({super.key,  required this.listMerek});
  @override
  _MerekVkool createState() => _MerekVkool();  
} 

class _MerekVkool extends State<MerekVkool>{ 

  PricevkoolController pricevkoolController = Get.put(PricevkoolController());

  ApiPricevkool apiPricevkool = ApiPricevkool();
  MyappAttr myappAttr = MyappAttr();
 
  Tanggal tgl = Tanggal();  
  var headers, body;
  String? car_brand;
  List<String> carTypes = [];
   
  @override
  void initState() { 
    super.initState();  
     myappAttr.retHeader().then((value) =>  setState(() =>  headers  = value ) );
  }

  _getTipe(String car_brand){  
    body ={
      'car_brand' : car_brand
    };
    apiPricevkool.tipe(headers, jsonEncode(body) ).then((value){
       
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
    .catchError((e) => snackError('Error Load Tipe Mobil', '${e.msg}') );
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
                      _clearKaca();
                      _merek.clear();   
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
                  _clearKaca() ;
                },  
                onSubmitted: (v){    
                    _clearKaca();
                    pricevkoolController.setBrand(v); 
                    _getTipe(v);
                    // print('Merek :  $v');   
                    _merek.text = v;
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
              subtitle: (carTypes.isEmpty) ? const Text(' -- Pilih Tipe --  ')  : TipeVkool(listTipe: carTypes) ,
            ),
          ),
        ),
 

      ],
    );

  } 

  void _clearKaca(){
    setState(() =>  carTypes = [] );
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