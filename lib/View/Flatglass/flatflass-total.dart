// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_returning_null_for_void, annotate_overrides, file_names, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vil_pricelist/Cfg/css.dart';
// import 'package:vil_pricelist/Helper/get_key.dart';
// import 'package:vil_pricelist/Helper/wg.dart';
import 'package:vil_pricelist/Models/G/PriceflatglassController.dart';  

class FlatglassTotal extends StatefulWidget{
  const FlatglassTotal({super.key}); 
  _FlatglassTotal createState() => _FlatglassTotal();  
} 

class _FlatglassTotal extends State<FlatglassTotal>{   
    
  final priceflatglassController = Get.put(PriceflatglassController());
  final _permeter = TextEditingController();
  final _subtotal = TextEditingController();
  final _total = TextEditingController();
  final _diskon = TextEditingController();
  // final _jasapasang = TextEditingController();

  void initState() { 
    super.initState();   
  }   
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
              title: Text('Biaya', style: Css.labelHarga,),
              subtitle: Column(
                children: [
                  // br(5),
                  // permeter(),
                  // br(5),
                  // jasapasang(),
                  // br(5),
                  // subtotal(),
                  Row(
                    children: [  
                      const Flexible(child:  Text('Harga permeter '), fit: FlexFit.tight, flex: 5, ), 
                      Flexible(  child: permeter(), fit: FlexFit.tight, flex: 5,), 
                    ],
                  ),
                  // br(5),
                  Row(
                    children: [  
                      const Flexible(child:  Text('Jasa Pasang'), fit: FlexFit.tight, flex: 5, ), 
                      Flexible(  child: jasapasang(), fit: FlexFit.tight, flex: 5,), 
                    ],
                  ),
                  // br(5),
                  Row(
                    children: [  
                      const Flexible(child:  Text('Sub Total '), fit: FlexFit.tight, flex: 5, ), 
                      Flexible(  child: subtotal(), fit: FlexFit.tight, flex: 5,), 
                    ],
                  ), 
                  Row(
                    children: [  
                      const Flexible(child:  Text('Diskon % '), fit: FlexFit.tight, flex: 5, ), 
                      Flexible(  child: diskon(), fit: FlexFit.tight, flex: 5,), 
                    ],
                  ),
                  Row(
                    children: [  
                      const Flexible(child:  Text('Total '), fit: FlexFit.tight, flex: 5, ), 
                      Flexible(  child: total(), fit: FlexFit.tight, flex: 5,), 
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
   
  Widget permeter(){ 
    return  Obx(() =>  TextFormField(   
              // controller: _permeter, 
              decoration:   InputDecoration(
                // labelText: 'Harga permeter',
                hintText:  '${priceflatglassController.hrgPermeter}',
                suffixText:' /m', 
              ), 
              onChanged: ((v) {
                _permeter.text = v;
                print('onChanged ${_permeter.text}');
                priceflatglassController.setHrgPermeter( int.parse(v) );
              }),
            )
    ); 
  }
  Widget jasapasang(){
    return Obx(() =>  
     TextFormField(   
            // controller: _jasapasang, 
            decoration:   InputDecoration(
              // labelText: 'Jasa Pasang',
              hintText:  '${priceflatglassController.jasaPasang}',
            ), 
              onChanged: ((v) { 
                priceflatglassController.setJasapasangr( int.parse(v) );
              }),
          )
    ); 
  }
  Widget subtotal(){
    return  
    TextFormField(   
            controller: _subtotal, 
            decoration: const InputDecoration(
              // labelText: 'Sub Total',
            ), 
    );

    // TextFormField(   
    //   controller: _subtotal,
    //   keyboardType: TextInputType.number,
    //   decoration:   const InputDecoration(    
    //     prefix: Text('Rp. '),   
    //     contentPadding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
    //     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
    //     enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
    //     border: OutlineInputBorder( 
    //       borderRadius: BorderRadius.all(Radius.circular(10)),
    //       gapPadding: 0,
    //     ), 
    //   ),  
    // );
  }
  Widget diskon(){
    return TextFormField(  
      controller: _diskon,
      keyboardType: TextInputType.number,
      decoration:   const InputDecoration( 
      ) 
    );
    // TextFormField(  
    //   controller: _diskon,
    //   keyboardType: TextInputType.number,
    //   decoration:   const InputDecoration(    
    //     // labelText: 'Quantity', 
    //       prefix: Text('Dis.(%):   '),  
    //     contentPadding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
    //     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
    //     enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
    //     border: OutlineInputBorder( 
    //       borderRadius: BorderRadius.all(Radius.circular(10)),
    //       gapPadding: 0,
    //     ), 
    //   ),  
    // );
  }
  Widget total(){
    return TextFormField(  
      controller: _total,
      keyboardType: TextInputType.number,
      decoration:   const InputDecoration( 
      ) 
    );
      // TextFormField(   
      //         controller: _total,
      //         readOnly: true,
      //         // initialValue: '0',
      //         decoration:   const InputDecoration(    
      //           hintText: '--',
      //           prefix: Text('Rp. '),  
      //           contentPadding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
      //           focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
      //           enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
      //           border: OutlineInputBorder( 
      //             borderRadius: BorderRadius.all(Radius.circular(10)),
      //             gapPadding: 0,
      //           ), 
      //         ),  
      //       );
  }
   

}//End