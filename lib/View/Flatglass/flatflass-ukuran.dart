// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_returning_null_for_void, annotate_overrides, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:vil_pricelist/Cfg/css.dart';
import 'package:vil_pricelist/Helper/wg.dart';
import 'package:vil_pricelist/Models/G/PriceflatglassController.dart';  

class FlatglassUkuran extends StatefulWidget{
  const FlatglassUkuran({super.key}); 
  _FlatglassUkuran createState() => _FlatglassUkuran();  
} 

class _FlatglassUkuran extends State<FlatglassUkuran>{   
   
  final priceflatglassController = Get.put(PriceflatglassController());
  
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
                  br(5),
                  Row(
                    children: [ 
                      Expanded(  child: panjang(),  ),
                      spasi(10), 
                      Expanded(   child: lebar(), ),
                    ],
                  ),
                  br(10),
                  Row(
                    children: [ 
                      Expanded(  child: qty(),  ),
                      spasi(15), 
                      Expanded(   child: luas(), ),
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
  final _qty = TextEditingController();
  final _luas =  TextEditingController();

  Widget panjang(){
    return TextFormField(  
                      controller: _panjang,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      decoration:   const InputDecoration(     
                        // hintText: 'panjang',
                        prefix: Text('Pjg:   '), 
                          suffix: Text('   m'),  
                        isCollapsed: false,
                        contentPadding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
                        border: OutlineInputBorder( 
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gapPadding: 0,
                        ), 
                      ),  
                      onChanged: (v){
                        _panjang.text = v;
                        if(v.isEmpty) { _countLuas(); return; }
                        print('_panjang ${_panjang.text}');
                        priceflatglassController.setPanjang(double.parse(v));
                        _countLuas();
                      },
                    );
  }
  Widget lebar(){
    return TextFormField(  
                      controller: _lebar,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      decoration:   const InputDecoration(      
                        // hintText: 'Lebar',
                        prefix: Text('Lbr:   '), 
                        suffix: Text('   m'),  
                        contentPadding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
                        border: OutlineInputBorder( 
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gapPadding: 0,
                        ), 
                      ),  
                      onChanged: (String v){
                         _lebar.text = v;
                         print('_lebar ${_lebar.text}');
                         if(v.isEmpty) { _countLuas(); return; }
                         priceflatglassController.setLebar( double.parse(v) );
                         _countLuas();
                      },
                    );
  }
  Widget qty(){
    return TextFormField(  
                      controller: _qty,  
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      decoration:   const InputDecoration(    
                        // labelText: 'Quantity',   
                          hintText: '0',
                          prefix: Text('Qty: '),  
                        contentPadding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
                        border: OutlineInputBorder( 
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gapPadding: 0,
                        ), 
                      ),  
                      onChanged: (String v){
                         _qty.text = v;
                         print('_qty ${_qty.text}');
                         if(v.isEmpty) { _countLuas(); return; }
                         priceflatglassController.setQty(int.parse(v));
                         _countLuas();
                      },
                    );
  }
  Widget luas(){
    return TextFormField(   
              readOnly: true,
              controller: _luas, 
              textAlign: TextAlign.right,
              decoration:   const InputDecoration(  
                hintText: '0', 
                prefix: Text('Total: '),  
                suffix: Text('   m²'),  
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

  _countLuas(){  
    if(_panjang.text.isEmpty || _lebar.text.isEmpty || _qty.text.isEmpty) { 
      priceflatglassController.setLuas(0);
      _luas.clear() ;
      return;
    } 
    double pjg = double.parse(_panjang.text);
    double lbr = double.parse(_lebar.text);
    double qty = double.parse(_qty.text);
    double luas =( pjg * lbr) * qty;
    _luas.text = '$luas';
    print('_luas ${_luas.text}');
 
    double permeter = double.parse('${priceflatglassController.hrgPermeter}');
    double subtotal = permeter * luas;
    priceflatglassController.setLuas(subtotal);
  }

}//End