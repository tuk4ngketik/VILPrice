// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, unrelated_type_equality_checks
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vil_pricelist/Cfg/css.dart';
import 'package:vil_pricelist/Helper/get_key.dart';
import 'package:vil_pricelist/Models/G/PricesolargardController.dart'; 

class KacaBelakang extends StatefulWidget{
  const KacaBelakang({super.key}); 
  @override
  _KacaBelakang createState() => _KacaBelakang(); 
} 

class _KacaBelakang extends State<KacaBelakang>{ 

  PricesolargardController pricesolargardController = Get.put(PricesolargardController());

  List<String> listFilm = [];  
  List<String> listKacaBelakang = []; 
  final _kacaBelakang = TextEditingController(); 

  var data;
  int hargaJual = 0;
  
  @override
  void initState() { 
    super.initState();
    setState(() { 
      data = pricesolargardController.kacaBelakang;
    });
    _getPriceList();
  }
  @override
  dispose(){
    super.dispose();
    _kacaBelakang.dispose(); 
  }

  _getPriceList(){ 
    data.forEach((element) {
      // print('${element.filmType}');
      setState(() {
        listFilm.add('${element.productName}');
      });
    });  
  }

  @override
  Widget build(BuildContext context){ 
      return Row( 
        mainAxisAlignment: MainAxisAlignment.end,
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
                suffixIcon: ( pricesolargardController.nilai_kacaBelakang != 0 ) ? IconButton(
                  icon : const Icon(Icons.close),
                  onPressed: (){
                    setState(() =>  hargaJual = 0 );  
                    pricesolargardController.set_nilaiKacaBelakang(  hargaJual );
                    pricesolargardController.hitung_subTotal(); 
                    pricesolargardController.film_kacaBelakang('-');
                    _kacaBelakang.clear();
                    _total( pricesolargardController.diskon.toInt(),  pricesolargardController.subtotal.toInt() );
                  },
                ) : null
              ),
              suggestions: listFilm, 
              controller: _kacaBelakang,
              onChanged: (String? v) { 
                    print('onChanged $v'); 
                    setState(() =>  hargaJual = 0);  
                    pricesolargardController.set_nilaiKacaBelakang(  hargaJual );
                    pricesolargardController.hitung_subTotal();  
                    _total( pricesolargardController.diskon.toInt(),  pricesolargardController.subtotal.toInt() );
              },  
             onSubmitted: (String v)  {
                    print('onsubmited $v');
                    int i = fromList(listFilm, v); 
                    setState(() =>  hargaJual = int.parse( data[i].priceRear ) );  
                    pricesolargardController.set_nilaiKacaBelakang(  hargaJual );
                    pricesolargardController.hitung_subTotal(); 
                    pricesolargardController.film_kacaBelakang(v);
                    _total( pricesolargardController.diskon.toInt(),  pricesolargardController.subtotal.toInt() );
                    print('onsubmited index ke- $i Harga Jaul $hargaJual ${_kacaBelakang.text}');
              },
            )
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
  _total(int diskon, int subtotal){                     // NEW
    double dec = diskon / 100;                          // diskon / 100 = 0,3
    double potongan = subtotal * dec;                   // 4.500.000 x 0,3 = 1.500.00
    total = subtotal - potongan;                        // 4.500.000 - 1.500.000 = 3.500.000    
    pricesolargardController.set_total(total.toInt());      // 
  } 
  

}//End