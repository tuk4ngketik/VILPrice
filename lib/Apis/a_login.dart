// ignore_for_file: avoid_print

import 'package:http/http.dart' as http; 
import 'package:vil_pricelist/Cfg/Svr.dart';
import 'package:vil_pricelist/Models/m_login.dart';


class ApiLogin{

  Svr svr = Svr();
  
  // Login
  Future<MLogin?> login(var headers, var data) async {  

      try{
        var res = await http.post( Uri.parse( svr.login() ), headers: headers, body: data );  
        if(res.statusCode == 200){ 
          print(' res.statusCode ${ res.statusCode}  res.body ${ res.body}');  
          final mLogin = mLoginFromJson(  res.body ); 
          return mLogin;
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