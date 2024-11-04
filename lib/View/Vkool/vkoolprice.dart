// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, annotate_overrides, unused_import, prefer_typing_uninitialized_variables, unused_element, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, prefer_is_empty, unused_field, prefer_final_fields, avoid_print, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart'; 
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart'; 
import 'package:vil_pricelist/Apis/a_share_pricelist.dart';
import 'package:vil_pricelist/Apis/a_vkool.dart';
import 'package:vil_pricelist/Cfg/css.dart';
import 'package:vil_pricelist/Cfg/sess.dart';
import 'package:vil_pricelist/Helper/get_key.dart';
import 'package:vil_pricelist/Helper/myapp-attr.dart';
import 'package:vil_pricelist/Helper/wg.dart';
import 'package:vil_pricelist/Models/G/PricevkoolController.dart';
import 'package:vil_pricelist/View/Vkool/kaca_belakang.dart';
import 'package:vil_pricelist/View/Vkool/kaca_depan.dart';
import 'package:vil_pricelist/View/Vkool/kaca_samping.dart';
import 'package:vil_pricelist/View/Vkool/kaca_sunroof.dart';
import 'package:vil_pricelist/View/Vkool/merek.dart';
import 'package:vil_pricelist/View/sendprice.dart'; 

class VKoolPrice extends StatefulWidget{
  @override
  _VKoolPrice createState() => _VKoolPrice();

}

class _VKoolPrice extends State<VKoolPrice>{ 

  PricevkoolController pricevkoolController = Get.put(PricevkoolController());
  MyappAttr myappAttr = MyappAttr();
  ApiPricevkool apiPricevkool = ApiPricevkool();
  ApiSharePricelist apiSharePricelist = ApiSharePricelist();
  List<String> mereks = [];
  var headers;
  final _diskon = TextEditingController();
  int _maxDiscount = 60;
  Sess sess = Sess();
  String? serial_user, namaLengkap, wa_pengirim;
  String product_name = 'V-KOOL™';

  initState(){
    super.initState();
     _clearVkoolProduk();
     myappAttr.retHeader().then((value) { 
      headers  = value; 
      print('headers : $headers');
      _getMerek();
     } );
     sess.getSess('serial').then((value) => setState(() => serial_user = value) );
     sess.getSess('no_wa').then((value) => setState(() => wa_pengirim = value) );
     sess.getSess('namaLengkap').then((value) => setState(() => namaLengkap = value) ); 
  }
  
  @override
  void dispose() { 
    super.dispose();
    _diskon.dispose();
  } 

  _getMerek(){
    apiPricevkool.merek(headers).then((v){
      bool? status = v!.status;
      if(status == false){
          snackAlert('Error',  '${v.message}'); 
          return; 
      }
       v.data!.forEach((element) { 
        if(!mounted) {return;}
        setState(()=>  mereks.add('${element.carBrand}') ); 
      });
    })
    .catchError((e) => snackError('Error Load Merk Mobil', '${e.msg}'));
  }

  @override
  Widget build(BuildContext context) { 
    return  SingleChildScrollView(
      padding: const EdgeInsets.all(20), 
      child: Column( 
          children:   [ 
            MerekVkool(listMerek: mereks ),  
        
            Card(
              shadowColor: Colors.amber, 
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 0, right: 0),
                  title:  Text('Kaca Depan', style: Css.labelHarga,), 
                  subtitle: Obx(() => ( pricevkoolController.kacaDepan.isEmpty ) ? const Text(' -- Tidak Ada --') : const KacaDepan()),
                ),
              ),
            ),
      
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 0, right: 0),
                title:   Text('Samping', style: Css.labelHarga,), 
                subtitle: Obx(() => ( pricevkoolController.kacaSamping.isEmpty ) ? const Text(' -- Tidak Ada --') : const KacaSamping()),                
              ),
            ),
          ),   
          
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 0, right: 0),
                title:   Text('Belakang', style: Css.labelHarga,),
                subtitle: Obx(() => ( pricevkoolController.kacaBelakang.isEmpty ) ? const Text(' -- Tidak Ada --') : const KacaBelakang() ),
              ),
            ),
          ),  
      
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 0, right: 0),
                title:   Text('Sun Roof', style: Css.labelHarga,),
                subtitle: Obx(() => ( pricevkoolController.kacaSunroof.isEmpty ) ? const Text(' -- Tidak Ada --') : const KacaSunroof()),
              ),
            ),
          ), 
      
          const Divider(),  
          // Sub total
          Container(
            padding: const EdgeInsets.all(8), 
            child: Row(   
                  children: [
                    Text('Sub Total', style: Css.labelTarif,),  
                    Flexible(
                      flex:8,
                      child: Align(
                        alignment: Alignment.centerRight, 
                          // child:  Obx(() => Text( rupiah('Rp ', priceController.subtotal.toInt(), 2), style: Css.labelTarif,), ), 
                          child: Container( 
                            padding: const EdgeInsets.all(10),
                            width: 200,  
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all( 
                                width : 1,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(10))
                            ),
                            child: Obx(() => Text( rupiah('Rp ', pricevkoolController.subtotal.toInt(), 0), style: Css.textTotal, textAlign: TextAlign.right,), ),
                          ),
                      ),
                    ), 
                  ],
            ),
          ), 
      
         // Discount
          Container( 
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start, 
              children: [
                const Flexible(flex:7,
                  child: TextField(   
                    readOnly: true,  
                    decoration: InputDecoration(
                      hintText: 'Discount',
                      border: InputBorder.none,
                    ),
                  ),
                ), 
                // Flexible(child: Container(width: 10,), flex: 3,),
                Flexible(flex: 3,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextField(    
                      style: const TextStyle(color: Colors.black),
                      decoration:  const InputDecoration(                                      
                        hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), 
                        hintText: '0',
                        contentPadding: EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 0), 
                        suffixIcon: Icon(Icons.percent), 
                        // border:                       
                        focusedBorder:OutlineInputBorder(
                          gapPadding: 0,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ), 
                        border: OutlineInputBorder(
                          gapPadding: 0,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ) 
                      ),
                      textAlign: TextAlign.right, 
                      keyboardType: TextInputType.number,
                      controller: _diskon,
                      onChanged: (value) => _discountType(), 
                      ), 
                  ),
                ),
              ],
            ),
          ), 
      
          // Total
          Container(
            padding: const EdgeInsets.all(10),
            // color: Colors.black,
            child: Row( 
                  children: [
                    Center(child: Text('Total', style: Css.labelTarif,)),
                    Flexible( flex:8,
                      child: Align(
                        alignment: Alignment.centerRight, 
                        // child: Text( rupiah('Rp ', total.toInt(), 2), style: Css.labelTarif,), 
                        child: Container( 
                          padding: const EdgeInsets.all(10),
                          width: 200,  
                          decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all( 
                              width : 1,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(10))
                          ), 
                          child: Obx(() => Text(rupiah('Rp ', pricevkoolController.total.toInt(), 0), style: Css.textTotal, textAlign: TextAlign.right,),) 
                        ),
                      ),
                    ),  
                  ],
            ),
          ),
        
          br(10),       
          Center( 
            child : TextButton.icon(onPressed: () => _bottomSend(),  
              // icon:  FaIcon(FontAwesomeIcons.share, semanticLabel: 'Share',),  
              icon:  const Icon(Icons.share, color: Colors.amber,   ),  
              label: const Text('Share', style: TextStyle(color: Colors.amber, fontSize: 16),)
            )    
          ),  
        
        ],
      ),
    );
  } 

 double total = 0;
  _total(int diskon, int subtotal){   // NEW
    double dec = diskon / 100;                          // diskon / 100 = 0,3
    double potongan = subtotal * dec;                   // 4.500.000 x 0,3 = 1.500.00
    total = subtotal - potongan;                        // 4.500.000 - 1.500.000 = 3.500.000    
    pricevkoolController.set_total(total.toInt());
  }  
  
  _discountType(){
    // print(_diskon.text);
    String diskon = _diskon.text;
    if( pricevkoolController.subtotal.toInt() < 1){
      defaultDialogErr('Anda belum memilih produk');
      FocusScope.of(context).unfocus();
      _diskon.clear(); 
      _total( 0,  pricevkoolController.subtotal.toInt() );
      return; 
    }
    if ( diskon.length < 1 ){ 
      _diskon.clear();
      _total( 0,  pricevkoolController.subtotal.toInt() );
      return;
    }
    if ( diskon.length > 0 && GetUtils.isNum(diskon) == false ){
      defaultDialogErr('Diskon harus angka');
      FocusScope.of(context).unfocus();
      _diskon.clear();
      _total( 0,  pricevkoolController.subtotal.toInt() );
      return;
    }
    // if( int.parse(diskon) > 30){ 
    if( int.parse(diskon) > _maxDiscount){ 
      defaultDialogErr( 'Max diskon $_maxDiscount%');   
      FocusScope.of(context).unfocus();
      _diskon.clear();
      _total( 0,  pricevkoolController.subtotal.toInt() );
      return;
    }
    pricevkoolController.set_diskon( int.parse(diskon) );
     _total( int.parse(diskon),  pricevkoolController.subtotal.toInt() );
  }
  
  Future<void> _clearVkoolProduk() async { 
    await Future.delayed(const Duration(milliseconds: 300));
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
 
 _bottomSend(){ 

    if( pricevkoolController.subtotal.toInt() < 1){
      defaultDialogErr('Anda belum memilih produk');
      FocusScope.of(context).unfocus();
      _diskon.clear(); 
      _total( 0,  pricevkoolController.subtotal.toInt() );
      return; 
    }
 
    // if(wa_pengirim == 'null'){ // OK
    if(wa_pengirim == null || wa_pengirim == 'null'){
      print('if wa_pengirim == null : get APi');
      apiSharePricelist.getWa(headers, serial_user!).then((value){
        var data = value!.data; 
        setState(() => wa_pengirim =  (data['no_hpwa'] == null) ? '' : '${data['no_hpwa']}'  );
      });
    }

    Get.bottomSheet(
      Sendprice(serial_user: serial_user!, namaLengkap: namaLengkap!, wa_pengirim: wa_pengirim!,  produk: product_name, pesan_teks: textPriceWhatsapp(), )   
    ); 
 }

 String textPriceWhatsapp(){ 
  // rupiah('', hargaJual , 0)
  String harga_kacaDepan = ( pricevkoolController.nilai_kacaDepan.toInt()  != 0) ?  'Rp. ${rupiah('',  pricevkoolController.nilai_kacaDepan.toInt() , 0)}' : '--';
  String film_kacaDepan = '${pricevkoolController.film_kacaDepan}';
  String kacaSamping =  ( pricevkoolController.nilai_kacaSamping.toInt()  != 0) ? 'Rp. ${rupiah('',  pricevkoolController.nilai_kacaSamping.toInt() , 0)}' : '--';
  String film_kacaSamping = '${pricevkoolController.film_kacaSamping}';
  String kacaBelakang =  ( pricevkoolController.nilai_kacaBelakang.toInt()  != 0) ? 'Rp.  ${rupiah('',  pricevkoolController.nilai_kacaBelakang.toInt(), 0)}' : '--';
  String kacaSunroof =  ( pricevkoolController.nilai_kacaSunroof.toInt()  != 0) ? 'Rp.  ${rupiah('',  pricevkoolController.nilai_kacaSunroof.toInt(), 0)}' : '-';
  String diskon = '${pricevkoolController.diskon}%';
  String subtotal = rupiah('',  pricevkoolController.subtotal.toInt(), 0);
  String total = rupiah('',  pricevkoolController.total.toInt(), 0);

  String _itemKacaDepan =  ( pricevkoolController.nilai_kacaDepan.toInt()  != 0) ? """
*Kaca Depan* :  
 - Film : *$film_kacaDepan*
 - Harga : *$harga_kacaDepan*  """ : "";
  String _itemKacaSamping = ( pricevkoolController.nilai_kacaSamping.toInt()  != 0) ? """
*Kaca Samping* 
 - Film : *$film_kacaSamping*
 - Harga : *$kacaSamping* """ : "";
  String _itemKacaBelakang = ( pricevkoolController.nilai_kacaBelakang.toInt()  != 0) ? """
*Kaca Belakang*
 - Film : *${pricevkoolController.film_kacaBelakang}*
 - Harga : *$kacaBelakang*  """ : "";
  String _itemKacaSunroof = ( pricevkoolController.nilai_kacaSunroof.toInt()  != 0) ? """
*Sun Roof*
 - Film : *${pricevkoolController.film_kacaSunroof}* 
 - Harga : *$kacaSunroof*  """ : "";
 
  String  t = """
--------------------------------------------
*Penawaran Harga $product_name* 
--------------------------------------------
Merek Mobil : *${pricevkoolController.brand}* 
Tipe Mobil  : *${pricevkoolController.tipe}* 

$_itemKacaDepan
$_itemKacaSamping
$_itemKacaBelakang 
$_itemKacaSunroof
 
==========================
Sub Total : *Rp. $subtotal* 
Diskon : *$diskon* 
Total : *Rp. $total* 
--------------------------------------------
*Terima Kasih*
--------------------------------------------
""" ;
    return t;
 }
}