// ignore_for_file: library_private_types_in_public_api, avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_unnecessary_containers 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vil_pricelist/Cfg/css.dart';
import 'package:vil_pricelist/Cfg/sess.dart';
import 'package:vil_pricelist/Helper/myapp-attr.dart';
import 'package:vil_pricelist/Helper/wg.dart';
import 'package:vil_pricelist/View/login.dart'; 

class Profil extends StatefulWidget{
  const Profil({super.key});
  @override
  _Profil createState() => _Profil();
  
} 

class _Profil extends State<Profil>{ 
  MyappAttr myappAttr = MyappAttr(); 
  Sess sess = Sess();
  String urlPhoto = 'https://www.sistemgaransi.com/storage/ikool/';
  String? serial, namaLengkap, username, gender, nickname, brand_active, branch_name, alamat, kota, appVersion; 
  bool isLoad = false;
  var appInfo;
  

  @override
  void initState() { 
    super.initState();
        sess.getSess('namaLengkap').then((value) => setState(() => namaLengkap = value )  ); 
        sess.getSess('username').then((value) => setState(() =>  username = value ) );
        sess.getSess('gender').then((value) => setState(() =>  gender = value ) );  
        
        sess.getSess('nickname').then((value) =>  setState(() =>  nickname = value )  );
        sess.getSess('brand_active').then((value) =>  setState(() =>  brand_active = value )  );
        sess.getSess('branch_name').then((value) =>  setState(() =>  branch_name = value ) );
        sess.getSess('alamat').then((value) =>  setState(() =>  alamat = value ) );
        sess.getSess('kota').then((value) =>  setState(() =>  kota = value ) );

        myappAttr.appinfo().then((value) => setState(() => appInfo = value )); 
  }

  final double _h_bgTop =  Get.height / 4; // hight bg top 
  double h_profil_img = 150;

  @override 
  Widget build(BuildContext context) { 
    return Scaffold(  
      appBar: AppBar(
        // toolbarHeight: _h_bgTop,
        backgroundColor: Colors.black,
        title: const Text('Profil', style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),), 
      ), 
      body:  (namaLengkap == null) ? const Center(child: CircularProgressIndicator()) : ListView(
              padding: const EdgeInsets.all (20),
              children : [

                Container( 
                  child: Center(
                    child:imgProfile(),
                  ),
                ),                  

                Card(
                  child: ListTile( 
                    title:   Text('Nama Lengkap', style: Css.profilLabel,),
                    subtitle:  Text('$namaLengkap', style: Css.profilText,), 
                  ),
                ), 
                
                Card(
                  child: ListTile(
                    title:   Text('Email', style: Css.profilLabel,),
                    subtitle:  Text('$username', style: Css.profilText,),
                   ),
                ), 
               
                Card(
                  child: ListTile(
                    title:  Text('Brand Active', style: Css.profilLabel,),
                    subtitle:  Text( '$brand_active' , style: Css.profilText,),
                                ),
                ),

                Card(
                  child: ListTile(
                    title:   Text('Dealer / Cabang', style: Css.profilLabel,),
                    subtitle:  Text('$branch_name', style: Css.profilText,),
                   ),
                ), 
                Card(
                  child: ListTile(
                    title:   Text('Alamat', style: Css.profilLabel,),
                    subtitle:  Text('$alamat', style: Css.profilText,),
                   ),
                ), 
                Card(
                  child: ListTile(
                    title:   Text('Kota', style: Css.profilLabel,),
                    subtitle:  Text('$kota', style: Css.profilText,),
                   ),
                ), 

                br(20),
                Container(
                  // color: Colors.yellow,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      // border: Border.all(width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    height: 45,
                    child:  Center(
                      child: TextButton(  
                      onPressed: () async {
                        setState(() =>  isLoad = true );
                        sess.destroy(); 
                        await Future.delayed(const Duration( milliseconds: 500));
                        Get.offAll(const Login());
                      },
                        child:  Center(
                            child: (isLoad == true) ? const CircularProgressIndicator( strokeWidth: 2, ) : const Text('Logout', style: TextStyle(fontSize: 17, color: Colors.black),) 
                          ),
                      ),
                    )
                ), 
                
                br (10), 
                (appInfo == '') ? const Text(''): Center(child: Text( 'Version. ${appInfo['appVer']}' )),
              ],
            ), 
       
      // Stack(
      //   children: [          
      //     bgTop(),          
      //     Container(  
      //       margin: EdgeInsets.only(top: _h_bgTop / 1.6  ),
      //       height: h_profil_img + 2,
      //       width: Get.width, 
      //       child: imgProfile(),
      //     ),          
      //     Container(
      //         // margin: EdgeInsets.only(top: _h_bgTop * 1.3 ),
      //         child:  (namaLengkap == null) ? const Center(child: CircularProgressIndicator()) : ListView(
      //         padding: const EdgeInsets.all (20),
      //         children : [
      //           Card(
      //             child: ListTile( 
      //               title:   Text('Nama Lengkap', style: Css.profilLabel,),
      //               subtitle:  Text('$namaLengkap', style: Css.profilText,), 
      //             ),
      //           ), 
                
      //           Card(
      //             child: ListTile(
      //               title:   Text('Email', style: Css.profilLabel,),
      //               subtitle:  Text('$username', style: Css.profilText,),
      //              ),
      //           ), 
               
      //           Card(
      //             child: ListTile(
      //               title:  Text('Brand Active', style: Css.profilLabel,),
      //               subtitle:  Text( '$brand_active' , style: Css.profilText,),
      //                           ),
      //           ),

      //           Card(
      //             child: ListTile(
      //               title:   Text('Dealer / Cabang', style: Css.profilLabel,),
      //               subtitle:  Text('$branch_name', style: Css.profilText,),
      //              ),
      //           ), 
      //           Card(
      //             child: ListTile(
      //               title:   Text('Alamat', style: Css.profilLabel,),
      //               subtitle:  Text('$alamat', style: Css.profilText,),
      //              ),
      //           ), 
      //           Card(
      //             child: ListTile(
      //               title:   Text('Kota', style: Css.profilLabel,),
      //               subtitle:  Text('$kota', style: Css.profilText,),
      //              ),
      //           ), 

      //           br(20),
      //           Container(
      //             // color: Colors.yellow,
      //               decoration: const BoxDecoration(
      //                 color: Colors.amber,
      //                 // border: Border.all(width: 1),
      //                 borderRadius: BorderRadius.all(Radius.circular(20))
      //               ),
      //               height: 45,
      //               child:  Center(
      //                 child: TextButton(  
      //                 onPressed: () async {
      //                   setState(() =>  isLoad = true );
      //                   sess.destroy(); 
      //                   await Future.delayed(const Duration( milliseconds: 500));
      //                   Get.offAll(const Login());
      //                 },
      //                   child:  Center(
      //                       child: (isLoad == true) ? const CircularProgressIndicator( strokeWidth: 2, ) : const Text('Logout', style: TextStyle(fontSize: 17, color: Colors.black),) 
      //                     ),
      //                 ),
      //               )
      //           ), 
                
      //           br (10), 
      //           (appInfo == '') ? const Text(''): Center(child: Text( 'Version. ${appInfo['appVer']}' )),
      //         ],
      //       ),
      //     )
          
      //   ],
      // )
    );
  }
  
  Widget bgTop(){ 
        return  Container(   
            height: _h_bgTop, 
              // padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )
            ),
            child: const Center(child: Text('Profil', style: TextStyle(color: Colors.white, fontSize: 25),),),
          );
  }

  Widget imgProfile(){
      return const CircleAvatar(
        backgroundColor: Colors.black87,
              radius:70, 
              child: ClipRRect(
                // borderRadius: BorderRadius.circular(100),  
                child:  Icon(Icons.person, size:100 ,color: Colors.white,  )  
              ),
      );
  }

}