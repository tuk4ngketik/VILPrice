// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_returning_null_for_void, annotate_overrides, file_names

import 'package:flutter/material.dart'; 
import 'package:vil_pricelist/Cfg/css.dart';
import 'package:vil_pricelist/Helper/wg.dart';  

class FlatglassQty extends StatefulWidget{
  const FlatglassQty({super.key}); 
  _FlatglassQty createState() => _FlatglassQty();  
} 

class _FlatglassQty extends State<FlatglassQty>{   
   
  @override
  void initState() { 
    super.initState();   
  }  

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
              title: Text('Ukuran ( Meter )', style: Css.labelHarga,),
              subtitle: Column(
                children: [
                  br(100),
                  Row(
                    children: [ 
                      Expanded(  child: panjang(),  ),
                      spasi(10), 
                      Expanded(   child: lebar(), ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
          
 

      ],
    );

  }  

  final _panjang = TextEditingController();
  final _lebar = TextEditingController();
  Widget panjang(){
    return TextFormField(  
                      controller: _panjang,
                      decoration:   const InputDecoration(    
                        labelText: 'Panjang',
                        contentPadding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
                        border: OutlineInputBorder( 
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gapPadding: 0,
                        ), 
                      ),  
                    );
  }
  Widget lebar(){
    return TextFormField(  
                      controller: _lebar,
                      decoration:   const InputDecoration(    
                        labelText: 'Lebar', 
                        contentPadding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
                        border: OutlineInputBorder( 
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gapPadding: 0,
                        ), 
                      ),  
                    );
  }

}//End