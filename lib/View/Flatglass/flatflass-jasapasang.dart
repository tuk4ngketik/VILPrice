// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_returning_null_for_void, annotate_overrides, file_names

import 'package:flutter/material.dart'; 
import 'package:vil_pricelist/Cfg/css.dart'; 

class FlatglassJasapasang extends StatefulWidget{
  const FlatglassJasapasang({super.key}); 
  _FlatglassJasapasang createState() => _FlatglassJasapasang();  
} 

class _FlatglassJasapasang extends State<FlatglassJasapasang>{   
   
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
              title: Text('Jasa Pasang', style: Css.labelHarga,),
              subtitle: jasapasang()
            ),
          ),
        ),
          
 

      ],
    );

  }  
 
  Widget jasapasang(){
    return TextFormField(   
                      keyboardType: TextInputType.number,
                      decoration:   const InputDecoration(     
                        prefix: Text('Rp/m²: '),  
                        isCollapsed: false,
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