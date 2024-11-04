// ignore_for_file: avoid_print, depend_on_referenced_packages 

import 'dart:async';
import 'dart:io';
import 'dart:isolate';
 
import 'package:http/http.dart' as http;
import 'package:vil_pricelist/Cfg/Svr.dart';
import 'package:vil_pricelist/Models/Flatglass/m_hargapermeter_flatglass.dart';
import 'package:vil_pricelist/Models/Flatglass/m_kacafilm_flatglass.dart';
import 'package:vil_pricelist/Models/Flatglass/m_merek_flatglass.dart'; 
import 'package:vil_pricelist/Models/donException.dart';

class ApiPriceFlatglass{

  Svr svr = Svr();

  Future<MMerekFlatglass?> merek(var headers ) async {  

      try{
        var res = await http.get( Uri.parse( svr.merekFlatglass() ), headers: headers );   
        if(res.statusCode == 200){ 
          // print('DON:: res.statusCode ${ res.statusCode}  res.body ${ res.body}');    
           final mMerekFlatglass = mMerekFlatglassFromJson(res.body); 
           return mMerekFlatglass;
        }else{
          // print('DON:: res.statusCode ${res.statusCode}');
           throw DonException('${res.statusCode}');  
        }
      }
      on Exception catch (e){   
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
          else {    
            print("Unhandled exception: ${e.toString()}");
            msg = 'Tunggu sementara';
          }   
          throw DonException(msg!); 
    }  
  }
  
  Future<MKacaflmFlatglass?> kacafilm(String merek, var headers ) async {  

      try{
        var res = await http.get( Uri.parse( "${svr.kacafilmFlatglass()}?mrk=$merek" ), headers: headers );   
        if(res.statusCode == 200){ 
            // print("${svr.kacafilmFlatglass()}?mrk=$merek ${res.body}");
            final mKacaflmFlatglass = mKacaflmFlatglassFromJson(res.body);
           return mKacaflmFlatglass;
        }else{ 
           throw DonException('${res.statusCode}');  
        }
      }
      on Exception catch (e){   
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
          else {    
            print("Unhandled exception: ${e.toString()}");
            msg = 'Tunggu sementara';
          }   
          throw DonException(msg!); 
    }  
  }
 
  Future<MHargaPermeter?> hargaPermeter(var headers, var body  ) async {  

      try{
        var res = await http.post( Uri.parse( svr.hargapermeterFlatglass() ), headers: headers, body : body   );  
        if(res.statusCode == 200){ 
          // print('hargapermeterFlatglass res.statusCode ${ res.statusCode}  res.body ${ res.body}');   
            final mHargaPermeter = mHargaPermeterFromJson(res.body);
           return mHargaPermeter;
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