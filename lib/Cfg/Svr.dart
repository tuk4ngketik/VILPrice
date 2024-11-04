// ignore_for_file: file_names, non_constant_identifier_names

class Svr{

  // Key
  String targetPath() => 'c2lzdGVtZ2FyYW5zaS5jb20vc2l0ZS9hcGk=';
  String apikey () =>  'Vmtvb2wtUHJpY2VMaXN0';
  
  String host = 'https://sistemgaransi.com/site/api';   
  
  String login() => '$host/pricelist_login.php';
 
  // Tab Harga Solargard
    String merekMobileSolargard() => '$host/pricelist_solargard_all_merk.php';
    String tipeMobileSolargard() => '$host/pricelist_solargard_tipe.php';
    String hargaKacaSolargard() => '$host/pricelist_solargard_harga_kaca.php';
 
  // Tab Harga Vikool
    String merekMobileVikool() => '$host/pricelist_vkool_all_merk.php';
    String tipeMobileVikool() => '$host/pricelist_vkool_tipe.php';
    String hargaKaca() => '$host/pricelist_vkool_harga_kaca.php';

  // Flat Glass
    String merekFlatglass() => '$host/pricelist_fg_get_merk.php';
    String kacafilmFlatglass() => '$host/pricelist_fg_get_kacafilm.php';
    String hargapermeterFlatglass() => '$host/pricelist_fg_post_getharga_meter.php';
    

  String sharePrice() => '$host/pricelist_share_price.php'; 

  String getWa(String serial) => '$host/pricelist_get_wa.php?serial=$serial'; 


}