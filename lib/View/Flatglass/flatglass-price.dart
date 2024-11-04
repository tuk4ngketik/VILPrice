// ignore_for_file: annotate_overrides, library_private_types_in_public_api, avoid_print, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:vil_pricelist/Apis/a_flatglass.dart';
import 'package:vil_pricelist/Helper/myapp-attr.dart';
import 'package:vil_pricelist/Helper/wg.dart'; 
import 'package:vil_pricelist/View/Flatglass/flatflass-bagian.dart';
// import 'package:vil_pricelist/View/Flatglass/flatflass-jasapasang.dart';
import 'package:vil_pricelist/View/Flatglass/flatflass-total.dart';
import 'package:vil_pricelist/View/Flatglass/flatflass-ukuran.dart';
import 'package:vil_pricelist/View/Flatglass/merek.dart';

class FlatglassPrice extends StatefulWidget{

  _FlatglassPrice createState() => _FlatglassPrice();
}

class _FlatglassPrice extends State<FlatglassPrice> {

  MyappAttr myappAttr = MyappAttr();
  var headers;
  ApiPriceFlatglass apiPriceFlatglass = ApiPriceFlatglass();
  List<String> listMerek = [];
 
  void initState() { 
    super.initState();
     myappAttr.retHeader().then((value) { 
      headers  = value;  
      _getMerek();
     } );
  } 
  void dispose() { 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { 
    return  (listMerek.isEmpty) ? const Center(child: CircularProgressIndicator(),)
    : SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child:Column(children: [
 
        MerekFlatglass(listMerek:  listMerek ),

        const FlatglassBagian(),

        const FlatglassUkuran(),

        // const FlatglassJasapasang(),

        const FlatglassTotal(),
        
        Center( 
            child : TextButton.icon(
              onPressed:() { 
              },  
              icon:  const Icon(Icons.share, color: Colors.amber,   ),  
              label: const Text('Share', style: TextStyle(color: Colors.amber, fontSize: 16),)
            )   
        ), 
         
      ]) ,
    );
  }

  _getMerek(){

    apiPriceFlatglass.merek(headers).then((v){
      bool? status = v!.status;
      if(status == false){
          snackAlert('Error',  '${v.message}'); 
          return; 
      } 
      var data = v.data;  
      for (var element in data!) { setState(()  => listMerek.add('${element.brandKat}'));  }
      print('headers $headers');
      print('listMerek $listMerek');

    });

  } 
}