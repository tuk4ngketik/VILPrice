// ignore_for_file: library_private_types_in_public_api, avoid_print, sized_box_for_whitespace, prefer_final_fields, annotate_overrides, non_constant_identifier_names, use_function_type_syntax_for_parameters, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart'; 
import 'package:get/get.dart'; 
import 'package:vil_pricelist/View/Vkool/vkoolprice.dart'; 

class Vkool extends StatefulWidget{
  const Vkool({super.key});
  @override
  _Vkool createState() => _Vkool();  
} 
 
class _Vkool extends State<Vkool>  with TickerProviderStateMixin{
  
  double _scrollPosition = 0 ; 
  ScrollController _scrollController = ScrollController();
  _scrollListener()   {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
      // print('_scrollPosition $_scrollPosition');
    });
  } 

  late TabController tabController;
  double screen = Get.width;
  static double screen_w2 = Get.width / 2;

  List<Widget> tabs = [
    Container(width: screen_w2, child: const Center(child: Text('Harga', style: TextStyle(color: Colors.white),))),
    Container(width:screen_w2,child: const Center(child: Text('Katalog', style: TextStyle(color: Colors.white)))),
  ]; 

 @override
  void initState() { 
    super.initState();  
    tabController = TabController(length: tabs.length, vsync: this); 
    _scrollController.addListener(() =>  _scrollListener()  );   
  } 

  void dispose(){
    super.dispose();
    tabController.dispose();
    _scrollController.dispose();
  } 

  final double _h_bgTop =  Get.height / 4;
  @override
  Widget build(BuildContext context){ 
    return Scaffold(
       
      body: DefaultTabController(
        length: 1,
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder:(BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(  
                backgroundColor: Colors.black87,  
                // expandedHeight: 230.0,  
                expandedHeight:  _h_bgTop,
                pinned: true, 
                title: ( _scrollPosition < 80 ) ?  null
                :  const Text('V-KOOL', 
                      style: TextStyle(fontSize: 25, 
                            fontWeight: FontWeight.bold, 
                            color: Colors.white
                      )
                ), 
                flexibleSpace: FlexibleSpaceBar(  
                  background: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20,bottom: 0),
                    child: Image.asset('imgs/logo-vkool-01.png', color: Colors.white,)
                  ),
                ), 
                bottom: TabBar(
                    indicatorColor: Colors.orange,
                    indicatorWeight: 3,
                    padding: const EdgeInsets.all(0),
                    labelStyle: const TextStyle(fontSize: 17, ),
                    labelPadding: const EdgeInsets.all(10),
                    isScrollable: true,
                    tabs: tabs,
                    controller: tabController,
                ), 
              ),   
              
            ];
          }, 
          
          body:  TabBarView(
            controller: tabController,
            children: _listWidget
          ),
        ),
      ),
    );
  }

  List<Widget> _listWidget = [ 
    VKoolPrice(),
    const Center(child: Text('Belum ada data'))
  ];

}