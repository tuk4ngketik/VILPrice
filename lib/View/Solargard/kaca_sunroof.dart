// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, unrelated_type_equality_checks
 
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vil_pricelist/Cfg/css.dart';
import 'package:vil_pricelist/Helper/get_key.dart';
import 'package:vil_pricelist/Models/G/PricesolargardController.dart'; 

class KacaSunroof extends StatefulWidget{
  const KacaSunroof({super.key}); 
  @override
  _KacaSunroof createState() => _KacaSunroof(); 
} 

class _KacaSunroof extends State<KacaSunroof>{ 

  PricesolargardController pricesolargardController = Get.put(PricesolargardController());

  List<String> listFilm = [];  
  List<String> listKacaSunroof = [];    

  var data;
  int hargaJual = 0;
  final _kacaSunroof = TextEditingController();  

  @override
  void initState() { 
    super.initState();
    setState(() { 
      data = pricesolargardController.kacaSunroof;
    });
    _getPriceList();
  }

  _getPriceList(){ 
    data.forEach((element) { 
      setState(() {
        listFilm.add('${element.productName}');
      });
    });  
  }


  @override
  Widget build(BuildContext context){ 
      return Row( 
        children: [
          Expanded(
            flex: 6,
            child: EasyAutocomplete(
              decoration:   InputDecoration(
                hintText: '-- Tipe Film --',
                contentPadding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
                border: const OutlineInputBorder( 
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gapPadding: 0,
                ), 
                suffixIcon: ( pricesolargardController.nilai_kacaSunroof!= 0 ) ? IconButton(
                  icon : const Icon(Icons.close),
                  onPressed: (){
                    setState(() =>  hargaJual = 0 );  
                    pricesolargardController.set_nilaiKacaSunroof(  hargaJual );
                    pricesolargardController.hitung_subTotal();  
                    pricesolargardController.set_filmKacaSunroof('-'); 
                    _total( pricesolargardController.diskon.toInt(),  pricesolargardController.subtotal.toInt() );
                    _kacaSunroof.clear();
                  },
                ) : null
              ),
              controller: _kacaSunroof,
              suggestions: listFilm,
              onChanged: (v){ 
                  setState(() =>  hargaJual = 0 );
                  pricesolargardController.set_nilaiKacaSunroof(  hargaJual );
                  pricesolargardController.hitung_subTotal();
                  _total( pricesolargardController.diskon.toInt(),  pricesolargardController.subtotal.toInt() );
                  print('onChanged $v');   
              },
              onSubmitted: (v){
                  int i = fromList(listFilm, v);
                  setState(() =>  hargaJual = int.parse( data[i].priceSunroof ) );
                  pricesolargardController.set_nilaiKacaSunroof(  hargaJual );
                  pricesolargardController.hitung_subTotal(); 
                  pricesolargardController.set_filmKacaSunroof(v); 
                  _total( pricesolargardController.diskon.toInt(),  pricesolargardController.subtotal.toInt() );
                  print('onSubmitted Harga Jaul $v : $hargaJual');   
              },
            ),
          ), 
          Container(width: 10,), 
          Flexible(
              flex: 3 , 
              child: Align(
                alignment: Alignment.centerRight, 
                child: Text( rupiah('', hargaJual , 0), style: Css.labelTarif,), 
              ),
            )
        ],
      ); 
  } 
 
  double total = 0;
  _total(int diskon, int subtotal){   // NEW
    double dec = diskon / 100;                          // diskon / 100 = 0,3
    double potongan = subtotal * dec;                   // 4.500.000 x 0,3 = 1.500.00
    total = subtotal - potongan;                        // 4.500.000 - 1.500.000 = 3.500.000    
    pricesolargardController.set_total(total.toInt());
  } 
  

}//End