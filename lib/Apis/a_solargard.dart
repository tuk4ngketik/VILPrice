// ignore_for_file: avoid_print, depend_on_referenced_packages
 
import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:http/http.dart' as http;
import 'package:vil_pricelist/Cfg/Svr.dart'; 
import 'package:vil_pricelist/Models/Pricevkool/m_merek.dart';
import 'package:vil_pricelist/Models/Pricevkool/m_type-by-brand.dart';
import 'package:vil_pricelist/Models/Solargard/m_hargakaca-solargard.dart';
import 'package:vil_pricelist/Models/donException.dart'; 

class ApiPriceSolargard{

  Svr svr = Svr();

  Future<MMerek?> merek(var headers ) async {  

    try{
        var res = await http.get( Uri.parse( svr.merekMobileSolargard() ), headers: headers );  
          // print('DON:: headers   $headers');   
        if(res.statusCode == 200){ 
          // print('DON:: res.statusCode ${ res.statusCode}  res.body ${ res.body}');   
           final mMerek = mMerekFromJson(res.body);
           return mMerek;
        }else{
           throw DonException('${res.statusCode}');  
        }
      }
      on Exception catch(e){   
         String? msg;
          if( e is SocketException ){ 
            msg = e.message;
            print("SocketException  exception: ${e.toString()}");
          }
          else if( e is TimeoutException ){   
            msg = e.message;
            print("TimeoutException  exception: ${e.toString()}");
          }
          else if( e is HttpException ){
            msg = e.message;
            print("HttpException  exception: ${e.toString()}");
          }
          else if( e is TlsException ){
            msg = e.message; 
            print("TlsException  exception: ${e.toString()}");
          }  
          else if( e is IsolateSpawnException ){
            msg = e.message; 
            print("IsolateSpawnException  exception: ${e.toString()}");
          }  
          else{
            print("else  exception: ${e.toString()}");
            msg = 'Unhandled exception';
          }   
          throw DonException(msg!); 
    }  
  } 

  Future<MTypeByBrand?> tipe(var headers, var body ) async {  
      try{
        var res = await http.post( Uri.parse( svr.tipeMobileSolargard() ), headers: headers, body : body );  
        if(res.statusCode == 200){  
          // print(' res.statusCode ${ res.statusCode}  res.body ${ res.body}');   
           final mTypeByBrand = mTypeByBrandFromJson(res.body);
           return mTypeByBrand;
        }else{
           throw DonException('${res.statusCode}');  
        }
      }
      on Exception catch(e){     
         String? msg;
          if( e is SocketException ){ 
            msg = e.message;
            print("SocketException  exception: ${e.toString()}");
          }
          else if( e is TimeoutException ){   
            msg = e.message;
            print("TimeoutException  exception: ${e.toString()}");
          }
          else if( e is HttpException ){
            msg = e.message;
            print("HttpException  exception: ${e.toString()}");
          }
          else if( e is TlsException ){
            msg = e.message; 
            print("TlsException  exception: ${e.toString()}");
          }  
          else if( e is IsolateSpawnException ){
            msg = e.message; 
            print("IsolateSpawnException  exception: ${e.toString()}");
          }  
          else{
            print("else  exception: ${e.toString()}");
            msg = 'Unhandled exception';
          }   
          throw DonException(msg!); 
    }  
  }
  
  Future<MHargaKacaSolargard?> hargaKacaSolargard(var headers, var body ) async {  
    // print('Solargard harga kaca $body');
      try{
        var res = await http.post( Uri.parse( svr.hargaKacaSolargard() ), headers: headers, body : body );  
        if(res.statusCode == 200){  
          // print(' res.statusCode ${ res.statusCode}  res.body ${ res.body}');    
          final mHargaKacaSolargard = mHargaKacaSolargardFromJson(res.body);
          return mHargaKacaSolargard; 
        }else{
           throw DonException('${res.statusCode}');  
        }
      }
      on Exception catch(e){  
         String? msg;
          if( e is SocketException ){ 
            msg = e.message;
            print("SocketException  exception: ${e.toString()}");
          }
          else if( e is TimeoutException ){   
            msg = e.message;
            print("TimeoutException  exception: ${e.toString()}");
          }
          else if( e is HttpException ){
            msg = e.message;
            print("HttpException  exception: ${e.toString()}");
          }
          else if( e is TlsException ){
            msg = e.message; 
            print("TlsException  exception: ${e.toString()}");
          }  
          else if( e is IsolateSpawnException ){
            msg = e.message; 
            print("IsolateSpawnException  exception: ${e.toString()}");
          }  
          else{
            print("else  exception: ${e.toString()}");
            msg = 'Unhandled exception';
          }   
          throw DonException(msg!); 
    }  
  }
  
}//end