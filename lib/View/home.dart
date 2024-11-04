// ignore_for_file: library_private_types_in_public_api, avoid_print, annotate_overrides, unused_field, non_constant_identifier_names, must_be_immutable
  
import 'package:flutter/material.dart'; 
import 'package:vil_pricelist/View/solargard.dart'; 
import 'package:vil_pricelist/View/profil.dart';
import 'package:vil_pricelist/View/vkool.dart';
import 'package:vil_pricelist/View/vpro.dart';

class Home extends StatefulWidget{ 
  String  brand_active;
   Home({super.key, required this.brand_active }); 
  _Home createState() => _Home(); 
} 

class _Home extends State<Home>{  

  
  List<Widget> contentWidget = [] ;
  List<BottomNavigationBarItem> _bottomNavigationBarItem = [];
  String? brand_active;

  void initState() { 
    super.initState();   
    _setContentWidget();
  }
 
  void dispose() {
    super.dispose();  
  }

  int _selectedIndex = 0;

  void changeTab(int index) { 
    setState(() => _selectedIndex = index );
    print ('_selectedIndex $_selectedIndex'); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold (  
      body: (contentWidget.isEmpty ) ? const Center(child: CircularProgressIndicator(),):  contentWidget[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(   
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blueGrey, 
            backgroundColor: Colors.black87,  
        items: _bottomNavigationBarItem,
        currentIndex: _selectedIndex,
        showUnselectedLabels: true , 
        onTap: changeTab,
      ),  
    
    );
  }
 
  

  _setContentWidget(){
 

    // -- WHERE brand_active = 'VK###SG###VP' 	-- Y
    if(widget.brand_active == 'VK###SG###VP'){
      setState(() { 
        contentWidget = [  
          const Vkool(),
          const Solargard(),
          const Vpro(),
          // const Flattglass(),
          const Profil()
        ];
        _bottomNavigationBarItem =  [  
          const BottomNavigationBarItem(
            icon: Icon(Icons.picture_in_picture_rounded, ),
            label: 'VKOOL', 
            backgroundColor: Colors.black87
          ), 
          const BottomNavigationBarItem( 
            icon: Icon(Icons.currency_exchange_outlined, ),
            label: 'SOLAR GARD',
            backgroundColor: Colors.black87
          ), 
          const BottomNavigationBarItem( 
            icon: Icon(Icons.layers_clear ),
            label: 'VPRO',
            backgroundColor: Colors.black87
          ),
          // const BottomNavigationBarItem( 
          //   icon: Icon(Icons.flip_to_back_sharp ),
          //   label: 'Flat Glass',
          //   backgroundColor: Colors.black87
          // ), 
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_box_sharp, ),
            label: 'Profil',
            backgroundColor: Colors.black87
          ), 
        ];

      });
      return;
    }    

    // -- WHERE brand_active = 'VK###SG' 		-- Y 
    if(widget.brand_active == 'VK###SG'){
      
      setState(() {
          
        contentWidget = [  
          const Vkool(),
          const Solargard(), 
          const Profil()
        ];
        
        _bottomNavigationBarItem = [  
          const BottomNavigationBarItem(
            icon: Icon(Icons.picture_in_picture_rounded, ),
            label: 'VKOOL',
            backgroundColor: Colors.black87
          ), 
          const BottomNavigationBarItem( 
            icon: Icon(Icons.currency_exchange_outlined, ),
            label: 'Solar Gard',
            backgroundColor: Colors.black87
          ),  
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_box_sharp, ),
            label: 'Profil',
            backgroundColor: Colors.black87
          ), 
        ];
      });
      return;
    }
    
    // -- WHERE brand_active = 'VK###VP' 		-- Y 
    if(widget.brand_active == 'VK###VP'){
      
      setState(() {
          
        contentWidget = [  
          const Vkool(),
          const Vpro(), 
          const Profil()
        ];
        _bottomNavigationBarItem = [  
          const BottomNavigationBarItem(
            icon: Icon(Icons.picture_in_picture_rounded, ),
            label: 'VKOOL',
            backgroundColor: Colors.black87
          ),  
          const BottomNavigationBarItem( 
            icon: Icon(Icons.layers_clear ),
            label: 'VPRO',
            backgroundColor: Colors.black87
          ), 
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_box_sharp, ),
            label: 'Profil',
            backgroundColor: Colors.black87
          ), 
        ];
      });
      return;
    }
    
    // -- WHERE brand_active = 'SG###VP' 		-- Y
    if(widget.brand_active == 'SG###VP'){
      
      setState(() {
          
        contentWidget = [  
          const Solargard(),
          const Vpro(), 
          const Profil()
        ];
        
        _bottomNavigationBarItem = [   
          const BottomNavigationBarItem( 
            icon: Icon(Icons.currency_exchange_outlined, ),
            label: 'Solar Gard',
            backgroundColor: Colors.black87
          ), 
          const BottomNavigationBarItem( 
            icon: Icon(Icons.layers_clear ),
            label: 'VPRO',
            backgroundColor: Colors.black87
          ), 
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_box_sharp, ),
            label: 'Profil',
            backgroundColor: Colors.black87
          ), 
        ];
      });
      return;
    } 

    // -- WHERE brand_active = 'VK' 		-- Y
    if(widget.brand_active == 'VK'){
      
      setState(() {
          
        contentWidget = [  
          const Vkool(), 
          const Profil()
        ];
        _bottomNavigationBarItem = [  
          const BottomNavigationBarItem(
            icon: Icon(Icons.picture_in_picture_rounded, ),
            label: 'VKOOL',
            backgroundColor: Colors.black87
          ),  
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_box_sharp, ),
            label: 'Profil',
            backgroundColor: Colors.black87
          ), 
        ];
      });
      return;
    } 

    // -- WHERE brand_active = 'SG' 		-- Y
    if(widget.brand_active == 'SG'){
      
      setState(() {
          
        contentWidget = [  
          const Solargard(), 
          const Profil()
        ];
        _bottomNavigationBarItem = [   
          const BottomNavigationBarItem( 
            icon: Icon(Icons.currency_exchange_outlined, ),
            label: 'Solar Gard',
            backgroundColor: Colors.black87
          ),  
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_box_sharp, ),
            label: 'Profil',
            backgroundColor: Colors.black87
          ), 
        ];
      });
      return;
    }  
     
  }
      
  
}