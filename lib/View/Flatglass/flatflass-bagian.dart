// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_returning_null_for_void, annotate_overrides, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:vil_pricelist/Cfg/css.dart';
import 'package:vil_pricelist/Models/G/PriceflatglassController.dart';  

class FlatglassBagian extends StatefulWidget{
  const FlatglassBagian({super.key}); 
  _FlatglassBagian createState() => _FlatglassBagian();  
} 

class _FlatglassBagian extends State<FlatglassBagian>{   
   
   
  final priceflatglassController = Get.put(PriceflatglassController());
  
  @override
  void initState() { 
    super.initState();   
  } 

  final _bagian = TextEditingController();

  @override
  void dispose() {
    super.dispose(); 
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
              title: Text('Bagian', style: Css.labelHarga,),
              subtitle: bagian(),
            ),
          ),
        ),
          
 

      ],
    );

  }  

  Widget bagian(){
    return 
      Obx(() => 
        TextFormField(  
                controller: _bagian,     
                decoration:    InputDecoration(   
                  hintText: ('${priceflatglassController.bagian}' == '') ? 'contoh: Kaca samping' : '${priceflatglassController.bagian}',
                  suffixIcon:  ('${priceflatglassController.bagian}' != '')  ? IconButton( 
                      onPressed: (){ 
                        print('Film clear');   
                        _clearBagian();
                      },
                      icon: const Icon(Icons.close),
                    ) : null,
                  contentPadding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
                  focusedBorder: const OutlineInputBorder(borderSide:   BorderSide(color: Colors.black) ), 
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
                  border: const OutlineInputBorder( 
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gapPadding: 0,
                  ), 
                ), 
                onChanged: (v)  {  
                  setState(() => _bagian.text = v ); 
                  priceflatglassController.setBagian(_bagian.text);
                  print('onchange _bagian: ${_bagian.text}'); 
                },   
              )
      );
  }

  _clearBagian(){
      setState(() => _bagian.clear() ); 
      priceflatglassController.setBagian(''); 
  }

}//End