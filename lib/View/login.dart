// ignore_for_file: library_private_types_in_public_api, avoid_print, annotate_overrides, unused_field, prefer_typing_uninitialized_variables, non_constant_identifier_names, unused_element

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vil_pricelist/Apis/a_login.dart';
import 'package:vil_pricelist/Cfg/css.dart';
import 'package:vil_pricelist/Cfg/sess.dart';
import 'package:vil_pricelist/Helper/myapp-attr.dart';
import 'package:vil_pricelist/Helper/tanggal.dart';
import 'package:vil_pricelist/Helper/wg.dart';
import 'package:vil_pricelist/View/home.dart'; 
 

class Login extends StatefulWidget{
  const Login({super.key}); 
  _Login createState() => _Login(); 
} 

class _Login extends State<Login>{

  MyappAttr myappAttr = MyappAttr();
  Sess sess = Sess(); 
  final now = DateTime.now(); 
  Tanggal tgl = Tanggal();
  ApiLogin apiLogin = ApiLogin();
  bool visiblePass =  false;
  bool isLoad =  false; 
  final _formKey = GlobalKey<FormState>();
  String? appVersion, _email, _passwd; 
  var headers;
  final Uri _uri_reset = Uri.parse('https://po.sistemgaransi.com/forgotpass_site.html');

  void initState() { 
    super.initState();  
     myappAttr.retHeader().then((value){ 
      if(!mounted ){
        return;
      }
      setState(() =>  headers  = value ); 
     });
  }
 
  void dispose() {
    super.dispose();  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      
      backgroundColor: Colors.black, 
      // drawer: const DonDrawer(),
      // appBar: AppBar(),
      
      body: Container(        
        decoration: const BoxDecoration(
          image: DecorationImage(   
            image: AssetImage("imgs/login-bg-01.jpg"),   
            fit: BoxFit.cover,  
          ),
        ),

        child: Center( 
          child: SingleChildScrollView(
            // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisSize: MainAxisSize.min, 
              children: [
              
                // const Text('Login', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),), 
                Image.asset('imgs/vkool-solargard.png', height: 50,), 
            
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form( key : _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min, 
                      crossAxisAlignment: CrossAxisAlignment.start,
            
                      children: [ 
                        br(20), 
                        TextFormField(  
                          style: const TextStyle(  fontWeight: FontWeight.normal, color: Colors.white, fontSize: 19    ),
                          onSaved:(newValue) => _email = newValue,
                          validator: (value) {
                            if(value!.isEmpty){
                              // return 'Email is required';
                              return 'Lengkapi Email';
                            }
                            if (GetUtils.isEmail( value ) == false ){                              
                            //  return 'Ivalid email';                        
                             return 'Email tidak valid';
                            }
                            return null;
                          },
                           decoration:  InputDecoration(   
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 0, strokeAlign: 0, style: BorderStyle.none),
                              borderRadius: BorderRadius.all(Radius.circular(20)),  
                            ),
                            errorBorder: Css.roundInput20, 
                            focusedBorder: Css.roundInput20, 
                            border: Css.roundInput20, 
                            prefixIcon: const Icon(Icons.email, color: Colors.black),
                            labelStyle: Css.labelLoginStyle,
                            labelText: 'Email',
                            hintText: 'Email anda', 
                            filled: true,
                            fillColor: Colors.white54,
                           ),  
                        ),
                        br(20),
                        
                        TextFormField( 
                          style: const TextStyle(  fontWeight: FontWeight.normal, color: Colors.white, fontSize: 19    ),
                          onSaved:(newValue) => _passwd = newValue,
                          validator: (value) {
                            if(value!.isEmpty){
                              // return 'Password is required';
                              return 'Lengkapi kata sandi';
                            }
                            return null;
                          },
                          obscureText: (visiblePass ==  false) ? true : false,
                           decoration:  InputDecoration(    
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 0, strokeAlign: 0, style: BorderStyle.none),
                              borderRadius: BorderRadius.all(Radius.circular(20)),  
                            ),
                            errorBorder: Css.roundInput20, 
                            focusedBorder: Css.roundInput20, 
                            labelStyle: Css.labelLoginStyle,
                            labelText: 'Kata Sandi',   
                            border: Css.roundInput20, 
                            prefixIcon: const Icon(Icons.lock_open, color: Colors.black),
                            hintText: 'Kata sandi',  
                            filled: true,
                            fillColor: Colors.white54,
                            suffixIcon: IconButton(
                              onPressed: (){ 
                                setState(() {
                                  visiblePass =  !visiblePass;
                                  print('visiblePass $visiblePass' );
                                });
                              }, 
                              icon: (visiblePass ==  false) ? const Icon(Icons.visibility_off_sharp, color: Colors.black) : const Icon(Icons.visibility, color: Colors.black,)
                            )
                           ),
                        ), 
                             

                        br(20),  
                        Container(
                          // color: Colors.yellow,
                            decoration: const BoxDecoration(
                              color: Colors.amber, 
                              // color: Colors.black, 
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            height: 55,
                            child:  Center(
                              child: TextButton( 
                                  onPressed: (){    
                                    if (_formKey.currentState!.validate() == false) { return; }
                                    _formKey.currentState!.save();
                                    _login();
                                 },
                                  child:  Center(
                                    child: ( isLoad == true ) 
                                      ? const CircularProgressIndicator(color: Colors.orange, strokeWidth: 2, ) 
                                      : const Text('Login', style: TextStyle(fontSize: 18, color: Colors.white),)
                                      // : const Icon(Icons.send)
                                  ),
                                ),
                            )
                          ),

                        br(20),  
                        Center(
                          child: OutlinedButton( 
                            // style: OutlinedButton.styleFrom(
                            //         shape: const StadiumBorder(),
                            //         side: const BorderSide(width: 2, color: Colors.grey), 
                            // ),
                              onPressed: () => _launchReset(),
                              child:  const Center(
                                child: Text('Lupa Password ?', style: TextStyle(fontSize: 18, color: Colors.white),)
                                  // : const Icon(Icons.send)
                              ),
                          ),
                        ),  
                           
                    ],),
                  ),
                ),
            
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchReset() async { 
    if (!await launchUrl(_uri_reset, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_uri_reset');
    }
  }

  Future<void> _login() async {      
    setState(() { isLoad = true; });      

    var data = {
      'username' : _email,
      'password' : _passwd
    };  

    _devLogin(); // Dev only 

    apiLogin.login( headers, jsonEncode(data) ).then((v) {
        bool? status = v!.status;
        String? msg = v.message;
        if(status == false){ 
          defaultDialogErr('$msg');
          if(mounted == false) {return;}
          setState(() { isLoad = false; }); 
          return;
        }
        var data = v.data!;  
        print('sess $data');
        
        sess.setSess('status_app', 'login');
        sess.setSess('serial', '${data.serial}');
        sess.setSess('username', '${data.username}');
        sess.setSess('namaLengkap', '${data.firstName} ${data.lastName}');  
        sess.setSess('gender', '${data.gender}'); 
        sess.setSess('nickname', '${data.nickname}');
        sess.setSess('brand_active', '${data.brandActive}'); 
        sess.setSess('branch_name', '${data.branchName}'); 
        sess.setSess('alamat', '${data.alamat}'); 
        sess.setSess('kota', '${data.kota}'); 
        sess.setSess('no_wa', '${data.noHpwa}'); 
        // Get.offAll(  Home(brand_active: data.brandActive,)); 
        Get.offAll(()=>Home(brand_active: data.brandActive!) );
    })
    .catchError((e){
      snackError('Error Login', '${e.msg}');
      setState(() { isLoad = false; });  
    });
  }
  
  _devLogin(){
    // devLogin
    if( _email == 'dev@vil-group.com'){ 
        sess.setSess('status_app', 'login');
        sess.setSess('serial', 'aa');
        sess.setSess('username', 'vkool.dev@vil-group.com');
        sess.setSess('namaLengkap', 'Vkool Dev');  
        sess.setSess('gender', ''); 
        sess.setSess('nickname', 'vkooldev');
        sess.setSess('brand_active', 'VK###SG###VP'); 
        sess.setSess('branch_name', 'VKOOL HQ'); 
        sess.setSess('alamat', 'Jln. Gunung Sahari No. 20, Jakarta Pusat'); 
        sess.setSess('kota', 'DKI Jakarta'); 
        sess.setSess('no_wa', '0877'); 
        Get.offAll(  Home(brand_active: 'VK###SG###VP'));  
    }

    // Tester
    if( _email == 'vkool.surendi@vil-group.com'){ 
        sess.setSess('status_app', 'login');
        sess.setSess('serial', 'ab');
        sess.setSess('username', 'vkool.surendi@vil-group.com');
        sess.setSess('namaLengkap', 'Surendi Cangkang Cau');  
        sess.setSess('gender', ''); 
        sess.setSess('nickname', 'Cangkangcau');
        sess.setSess('brand_active', 'VK'); 
        sess.setSess('branch_name', 'VKOOL PUSAT'); 
        sess.setSess('alamat', 'Jln. Gunung Sahari No. 20, Jakarta Pusat'); 
        sess.setSess('kota', 'DKI Jakarta');  
        sess.setSess('no_wa', '0812'); 
        Get.offAll(  Home(brand_active: 'VK'));  
    } 
  }

}