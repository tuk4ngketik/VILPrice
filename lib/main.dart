// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:vil_pricelist/Cfg/sess.dart';
import 'package:vil_pricelist/View/home.dart';
import 'package:vil_pricelist/View/login.dart';
// import 'package:vil_pricelist/dondrawer.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(  const MyApp());
  // runApp( const GetMaterialApp(home: MyApp(),));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key}); 
  @override
  _MyApp createState()=> _MyApp();
}
  
class _MyApp extends State<MyApp> {

  Sess sess = Sess();
  String? status_app, brand_active;

  @override
  void initState() { 
    super.initState();
    initSplash();
    sess.getSess('status_app').then((value) => setState(() => status_app = value )  ); 
    sess.getSess('brand_active').then((value) =>  setState(() =>  brand_active = value )  );
  }

  void initSplash() async {  
    await Future.delayed(const Duration(seconds: 1)); 
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) { 
    return  GetMaterialApp( 
      debugShowCheckedModeBanner: false,
      title: 'Price List ',
      home: ( status_app == null ) ?   const Login() :     Home(brand_active:  brand_active!,)
    );
    // return ( status_app == null ) ?   const Login() :     Home(brand_active:  brand_active!,);
  } 

}