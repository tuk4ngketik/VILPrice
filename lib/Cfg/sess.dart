import 'package:shared_preferences/shared_preferences.dart';

class Sess{
 
    setSess(String key, String value ) async {
      final prefs =  await SharedPreferences.getInstance(); 
      prefs.setString(key, value); 
    }

    Future<String?> getSess(String key) async {
      final prefs =  await SharedPreferences.getInstance(); 
      return prefs.getString(key);
    }

    remove(String key) async {
      final prefs =  await SharedPreferences.getInstance(); 
      prefs.remove(key); 
    }

    destroy() async {
      final prefs =  await SharedPreferences.getInstance(); 
      prefs.clear();
    } 
        
    // sess.setSess('status_app', 'Register or Login');
    // sess.setSess('nama', '${data.nama}');
    // sess.setSess('email', '${data.email}');
    // sess.setSess('phone', '${data.phone}');
    // sess.setSess('prov', '${data.prov}'); 
    // sess.setSess('address', '${data.address}');

}