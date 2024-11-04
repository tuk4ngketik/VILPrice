// ignore_for_file: library_private_types_in_public_api, avoid_print, sized_box_for_whitespace, prefer_final_fields, annotate_overrides, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vil_pricelist/View/Flatglass/flatglass-price.dart'; 

class Flattglass extends StatefulWidget{
  const Flattglass({super.key});
  @override
  _Flattglass createState() => _Flattglass();  
} 
 
class _Flattglass extends State<Flattglass>  with TickerProviderStateMixin{
  
  double _scrollPosition = 0 ; 
  ScrollController _scrollController = ScrollController();
  _scrollListener()   {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
      // print('_scrollPosition $_scrollPosition');
    });
  } 

  late TabController tabController;
  List<Widget> tabs = [
    Container(width: Get.width / 2, child: const Center(child: Text('Harga'))),
    Container(width: Get.width / 2,child: const Center(child: Text('Katalog'))),
  ]; 

 @override
  void initState() { 
    super.initState();  
    tabController = TabController(length: tabs.length, vsync: this);
    _scrollController.addListener(() => _scrollListener() );
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
                expandedHeight: _h_bgTop,  
                pinned: true,
                title: ( _scrollPosition < 80 ) ? null
                  : const Text('Flat Glass', 
                      style: TextStyle(fontSize: 20, 
                            fontWeight: FontWeight.bold,
                            // color:  Colors.amber 
                      )
                ),  
                flexibleSpace: FlexibleSpaceBar( 
                  background: Container(
                    padding: const EdgeInsets.only(left: 40,right: 40,top: 20, bottom: 20),
                    child: Image.asset('imgs/logo-ique.png', color: Colors.white,)
                  ),
                  stretchModes: const [StretchMode.zoomBackground], 
                ), 
                bottom: TabBar(
                    indicatorColor: Colors.orange,
                    indicatorWeight: 3,
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
    FlatglassPrice(),
    const Center(child: Text('Belum ada data'))
  ];

}