// ignore_for_file: prefer_final_fields, slash_for_doc_comments, prefer_typing_uninitialized_variables, file_names

import 'dart:convert';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:vil_pricelist/Cfg/Svr.dart';
import 'package:vil_pricelist/Helper/tanggal.dart'; 
/**  
 *    CARA PENGGUNAAN 
 *    myappAttr.retHeader().then((value) => print ('myappAttr.retHeader $value') );
 *    myappAttr.appinfo().then((value) => print ('myappAttr.appinfo $value') );
 * 
 */

class MyappAttr  {

  Svr svr = Svr();
  final now = DateTime.now(); 
  Tanggal tgl = Tanggal();    
  var myinfo, headers;

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );
  
    String pckDate () => base64.encode(utf8.encode( tgl.dmy() )); 
    String pckName () => base64.encode(utf8.encode( _packageInfo.packageName));    
    String version () => base64.encode(utf8.encode( _packageInfo.version));    
    String buildNumber () => base64.encode(utf8.encode( _packageInfo.buildNumber));    

    String realApppName () =>  _packageInfo.appName;
    String realPckName () =>   _packageInfo.packageName;
    String realVersion () =>   _packageInfo.version;
    String realBuildNumber () =>   _packageInfo.buildNumber;
    
   // return headers
   Future< dynamic > retHeader() async {
     
    final info = await PackageInfo.fromPlatform();
    _packageInfo = info; 
 
    headers  =   {
              'pckname':  pckName(),
              'pckdate': pckDate(),
              'appversion':  _packageInfo.version, 
              'buildnumber' : _packageInfo.buildNumber,
              'targetpath': svr.targetPath(),
              'apikey': svr.apikey(),  
              'Content-Type': 'application/json'
            }; 
    return headers;  
  }

 
  Future<dynamic> appinfo()   async {
      final info = await PackageInfo.fromPlatform();
      _packageInfo = info;  
      myinfo  = { 
        'appName' : _packageInfo.appName,
        'appVer' : _packageInfo.version,
        'pckName' : _packageInfo.packageName,
        'buildNumber': _packageInfo.buildNumber,
      };
      return myinfo;
  }


}