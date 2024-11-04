// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_returning_null_for_void

import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vil_pricelist/Apis/a_flatglass.dart'; 
import 'package:vil_pricelist/Cfg/css.dart';
import 'package:vil_pricelist/Helper/myapp-attr.dart';
import 'package:vil_pricelist/Helper/wg.dart';  
import 'package:vil_pricelist/Models/G/PriceflatglassController.dart';
import 'package:vil_pricelist/View/Flatglass/flatglass-film.dart';

class MerekFlatglass extends StatefulWidget{  
  final List<String> listMerek; 
  const MerekFlatglass({super.key,  required this.listMerek});
  @override
  _MerekFlatglass createState() => _MerekFlatglass();  
} 

class _MerekFlatglass extends State<MerekFlatglass>{  

  final priceflatglassController = Get.put(PriceflatglassController());

  MyappAttr myappAttr = MyappAttr();  
  var headers, body; 
  ApiPriceFlatglass apiPriceFlatglass = ApiPriceFlatglass();
  List<String> listKacafilm = [];  
  List<String> listSerialKacafilm = [];  
   
  final _merek = TextEditingController();

  @override
  void initState() { 
    super.initState();  
     myappAttr.retHeader().then((value) =>  setState(() =>  headers  = value ) );
  }
  
  _getFilm(String merek){   
    
    apiPriceFlatglass.kacafilm( merek, headers).then((v) {
      
      bool? status = v!.status;
      if(status == false){
          snackAlert('Error',  '${v.message}'); 
          return; 
      } 
      var data = v.data;
      data?.forEach((element) { 
        setState(() { 
          listKacafilm.add('${element.prodName}');
          listSerialKacafilm.add('${element.serial}');
        });
      });

    });
  } 

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
                      _clearMerk();
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
                onChanged: (v)  {  
                  _merek.text = v;
                  _getFilm(v);
                  print('onchange $v  $listKacafilm'); 
                },  
                // onSubmitted: (v){     
                //       _merek.text = v;
                //       _getFilm(v);
                //       print('onSubmiit $v $listKacafilm');    
                //   }, 
              ),
            ),
          ),
        ),


        //Film
        Card(  
          // shadowColor: Color.fromARGB(255, 235, 194, 70), 
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 0, right: 0),
              title: Text('Kaca Film', style: Css.labelHarga,),
              subtitle: (listKacafilm.isEmpty) 
                        ? const Text(' -- Pilih Kaca Film --  ')  
                        :  FlatglassFilm(listFilm: listKacafilm, headers: headers),
            ),
          ),
        ), 

      ],
    );

  } 
 
  void _clearMerk(){ 
    _merek.clear();
    setState(() {
      listKacafilm = [];
      listSerialKacafilm = [];
    }); 
    priceflatglassController.setMerek('');        // Hapus Merek
    priceflatglassController.setFilm('');         // Hapus Film
    priceflatglassController.setBagian('');       // Hapus Bagian
    priceflatglassController.setHrgPermeter(0);   // Harga perMeter 
    priceflatglassController.setJasapasangr(0);   // Jasa Pasang
  }

}//End