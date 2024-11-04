// ignore_for_file: avoid_print

import 'package:http/http.dart' as http; 
import 'package:vil_pricelist/Cfg/Svr.dart';
import 'package:vil_pricelist/Models/m_all.dart'; 


class ApiSharePricelist{

  Svr svr = Svr();
  
  Future<MAll?> sharePrice(var headers, var data) async {  

      try{
        var res = await http.post( Uri.parse( svr.sharePrice() ), headers: headers, body: data );  
        if(res.statusCode == 200){ 
          // print('DON:: res.statusCode ${ res.statusCode}  res.body ${ res.body}');  
          final mAll = mAllFromJson(  res.body ); 
          return mAll;
        }else{
          return null;
        }
      }
      catch (e){
        print('e =>  $e');
      } 
      return null;
  }

  Future<MAll?> getWa(var headers, String serial ) async {  

      try{
        var res = await http.post( Uri.parse( svr.getWa(serial) ), headers: headers);  
        if(res.statusCode == 200){ 
          // print('DON:: res.statusCode ${ res.statusCode}  res.body ${ res.body}');  
          final mAll = mAllFromJson(  res.body ); 
          return mAll;
        }else{
          return null;
        }
      }
      catch (e){
        print('e =>  $e');
      } 
      return null;
  }
  
}