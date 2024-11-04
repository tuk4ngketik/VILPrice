// ignore_for_file: annotate_overrides, library_private_types_in_public_api, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, prefer_is_empty, non_constant_identifier_names, avoid_print, prefer_final_fields, unused_field, no_leading_underscores_for_local_identifiers
 
import 'package:flutter/material.dart';  
import 'package:get/get.dart';
import 'package:vil_pricelist/Apis/a_share_pricelist.dart';
import 'package:vil_pricelist/Apis/a_solargard.dart';
import 'package:vil_pricelist/Cfg/css.dart';
import 'package:vil_pricelist/Cfg/sess.dart';
import 'package:vil_pricelist/Helper/get_key.dart';
import 'package:vil_pricelist/Helper/myapp-attr.dart';
import 'package:vil_pricelist/Helper/wg.dart';
import 'package:vil_pricelist/Models/G/PricesolargardController.dart'; 
import 'package:vil_pricelist/View/Solargard/kaca_belakang.dart';
import 'package:vil_pricelist/View/Solargard/kaca_depan.dart';
import 'package:vil_pricelist/View/Solargard/kaca_samping.dart';
import 'package:vil_pricelist/View/Solargard/kaca_sunroof.dart';
import 'package:vil_pricelist/View/Solargard/merek.dart';
import 'package:vil_pricelist/View/sendprice.dart'; 

class Solargardprice extends StatefulWidget{
  const Solargardprice({super.key});

  @override
  _Solargardprice createState() => _Solargardprice();

}

class _Solargardprice extends State<Solargardprice>{  

  Sess sess = Sess();
  PricesolargardController pricesolargardController = Get.put(PricesolargardController());
  MyappAttr myappAttr = MyappAttr();
  ApiPriceSolargard apiPriceSolargard = ApiPriceSolargard();
  final _diskon = TextEditingController();
  int _maxDiscount = 60;
  List<String> mereks = [];
  var headers;
  ApiSharePricelist apiSharePricelist = ApiSharePricelist();
  String? serial_user, namaLengkap,  wa_pengirim;
  String product_name = 'Solar Gard';


  initState(){
    super.initState(); 
    _clearSolargardProduk();
     myappAttr.retHeader().then((value) { 
      headers  = value; 
      _getMerek();
     } ); 
     sess.getSess('serial').then((value) => setState(() => serial_user = value) );
     sess.getSess('no_wa').then((value) => setState(() => wa_pengirim = value) );
     sess.getSess('namaLengkap').then((value) => setState(() => namaLengkap = value) );
  } 

  _getMerek(){
    apiPriceSolargard.merek(headers).then((v){
      bool? status = v!.status;
      if(status == false){
          snackAlert('Error',  '${v.message}'); 
          return; 
      }
       v.data!.forEach((element) { 
        if(!mounted) {return;}
        setState(()=>  mereks.add('${element.carBrand}') ); 
        // print('carBrand ${element.carBrand}');
      });
    })
    .catchError((e) => snackError('Error Load Merk Mobil', '${e.msg}'));
  }

  @override
  Widget build(BuildContext context) { 
    
    return  SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column( children:  [           
          MerekSolargard(listMerek: mereks),

          
          Card(
              shadowColor: Colors.amber, 
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(left: 0, right: 0),
                    title:  Text('Kaca Depan', style: Css.labelHarga,), 
                    subtitle: Obx(() => ( pricesolargardController.kacaDepan.isEmpty ) ? const Text(' -- Tidak Ada --') : const KacaDepan()),
                  ),
              ),
            ),
        
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 0, right: 0), 
                  title:  Text('Kaca Samping', style: Css.labelHarga,), 
                  subtitle: Obx(() => ( pricesolargardController.kacaSamping.isEmpty ) ? const Text(' -- Tidak Ada --') : const KacaSamping()),                
                ),
              ),
            ),   
          
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 0, right: 0), 
                title:  Text('Kaca Belakang', style: Css.labelHarga,), 
                subtitle: Obx(() => ( pricesolargardController.kacaBelakang.isEmpty ) ? const Text(' -- Tidak Ada --') : const KacaBelakang() ),
              ),
              ),
          ),  
      
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 0, right: 0),
                title:   Text('Sun Roof', style: Css.labelHarga,),
                subtitle: Obx(() => ( pricesolargardController.kacaSunroof.isEmpty ) ? const Text(' -- Tidak Ada --') : const KacaSunroof()),
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
                            child: Obx(() => Text( rupiah('Rp ', pricesolargardController.subtotal.toInt(), 0), style: Css.textTotal, textAlign: TextAlign.right,), ),
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
                const Flexible(flex: 7,
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
                    Flexible(
                      flex:8,
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
                          child: Obx(() => Text(rupiah('Rp ', pricesolargardController.total.toInt(), 0), style: Css.textTotal, textAlign: TextAlign.right,),) 
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
    pricesolargardController.set_total(total.toInt());
  } 
  _discountType(){ 
    
    // print(_diskon.text);
    String diskon = _diskon.text;
    if( pricesolargardController.subtotal.toInt() < 1){
      defaultDialogErr('Anda belum memilih produk');
      FocusScope.of(context).unfocus();
      _diskon.clear(); 
      _total( 0,  pricesolargardController.subtotal.toInt() );
      return; 
    }
    if ( diskon.length < 1 ){ 
      _diskon.clear();
      _total( 0,  pricesolargardController.subtotal.toInt() );
      return;
    }
    if ( diskon.length > 0 && GetUtils.isNum(diskon) == false ){
      defaultDialogErr('Diskon harus angka');
      FocusScope.of(context).unfocus();
      _diskon.clear();
      _total( 0,  pricesolargardController.subtotal.toInt() );
      return;
    }
    // if( int.parse(diskon) > 30){ 
    if( int.parse(diskon) > _maxDiscount){ 
      defaultDialogErr( 'Max diskon $_maxDiscount%');    
      FocusScope.of(context).unfocus();
      _diskon.clear();
      _total( 0,  pricesolargardController.subtotal.toInt() );
      return;
    }
    pricesolargardController.set_diskon( int.parse(diskon) );
     _total( int.parse(diskon),  pricesolargardController.subtotal.toInt() );
  }
  
  Future<void> _clearSolargardProduk() async { 
    await Future.delayed(const Duration(milliseconds: 300));
    pricesolargardController.set_kacaDepan([]);
    pricesolargardController.set_kacaBelakang([]);
    pricesolargardController.set_kacaSamping([]);
    pricesolargardController.set_kacaSunroof([]);
      pricesolargardController.set_nilaiKacaDepan(0);
      pricesolargardController.set_nilaiKacaSamping(0);
      pricesolargardController.set_nilaiKacaBelakang(0);
      pricesolargardController.set_nilaiKacaSunroof(0);
    pricesolargardController.clear_subTotal(); 
    pricesolargardController.clear_total(); 
  }
 
 _bottomSend(){ 
    if( pricesolargardController.subtotal.toInt() < 1){
      defaultDialogErr('Anda belum memilih produk');
      FocusScope.of(context).unfocus();
      _diskon.clear(); 
      _total( 0,  pricesolargardController.subtotal.toInt() );
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
      Sendprice(serial_user: serial_user!, namaLengkap: namaLengkap!,  wa_pengirim: wa_pengirim!,  produk: product_name, pesan_teks: textPriceWhatsapp(), )  
    );
 }

 String textPriceWhatsapp(){ 
  // rupiah('', hargaJual , 0)
  String harga_kacaDepan = ( pricesolargardController.nilai_kacaDepan.toInt()  != 0) ?  'Rp. ${rupiah('',  pricesolargardController.nilai_kacaDepan.toInt() , 0)}' : '--';
  String film_kacaDepan = '${pricesolargardController.film_kacaDepan}';
  String kacaSamping =  ( pricesolargardController.nilai_kacaSamping.toInt()  != 0) ? 'Rp. ${rupiah('',  pricesolargardController.nilai_kacaSamping.toInt() , 0)}' : '--';
  String film_kacaSamping = '${pricesolargardController.film_kacaSamping}';
  String kacaBelakang =  ( pricesolargardController.nilai_kacaBelakang.toInt()  != 0) ? 'Rp.  ${rupiah('',  pricesolargardController.nilai_kacaBelakang.toInt(), 0)}' : '--';
  String kacaSunroof =  ( pricesolargardController.nilai_kacaSunroof.toInt()  != 0) ? 'Rp.  ${rupiah('',  pricesolargardController.nilai_kacaSunroof.toInt(), 0)}' : '-';
  String diskon = '${pricesolargardController.diskon}%';
  String subtotal = rupiah('',  pricesolargardController.subtotal.toInt(), 0);
  String total = rupiah('',  pricesolargardController.total.toInt(), 0);
 
  String _itemKacaDepan =  ( pricesolargardController.nilai_kacaDepan.toInt()  != 0) ? """
*Kaca Depan* :  
 - Film : *$film_kacaDepan*
 - Harga : *$harga_kacaDepan*  """ : "";
  String _itemKacaSamping = ( pricesolargardController.nilai_kacaSamping.toInt()  != 0) ? """
*Kaca Samping* 
 - Film : *$film_kacaSamping*
 - Harga : *$kacaSamping* """ : "";
  String _itemKacaBelakang = ( pricesolargardController.nilai_kacaBelakang.toInt()  != 0) ? """
*Kaca Belakang*
 - Film : *${pricesolargardController.film_kacaBelakang}*
 - Harga : *$kacaBelakang*  """ : "";
  String _itemKacaSunroof = ( pricesolargardController.nilai_kacaSunroof.toInt()  != 0) ? """
*Sun Roof*
 - Film : *${pricesolargardController.film_kacaSunroof}* 
 - Harga : *$kacaSunroof*  """ : "";


  String  t = """
------------------------------------------ 
*Penawaran Harga $product_name* 
------------------------------------------
Merek Mobil : *${pricesolargardController.brand}* 
Tipe Mobil  : *${pricesolargardController.tipe}* 

$_itemKacaDepan
$_itemKacaSamping
$_itemKacaBelakang 
$_itemKacaSunroof
 
==========================
Sub Total : *Rp. $subtotal* 
Diskon : *$diskon* 
Total : *Rp. $total* 
------------------------------------------
*Terima Kasih*
------------------------------------------
""" ;
    return t;
 }

}