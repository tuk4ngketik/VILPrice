// ignore_for_file: library_private_types_in_public_api, avoid_print, sized_box_for_whitespace, prefer_final_fields, annotate_overrides
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vil_pricelist/View/solargard.dart';
import 'package:vil_pricelist/View/vkool.dart';

class Pricelist extends StatefulWidget{
  const Pricelist({super.key});
  @override
  _Pricelist createState() => _Pricelist();  
} 
 

class _Pricelist extends State<Pricelist>  with TickerProviderStateMixin{
  
  late TabController tabController;
  List<Widget> tabs = [
    Container(width: Get.width / 2, child: const Center(child: Text('VKool'))),
    Container(width: Get.width / 2,child: const Center(child: Text('Solar Gard'))),
  ];

 @override
  void initState() { 
    super.initState();  
    tabController = TabController(length: tabs.length, vsync: this);
  }
  void dispose(){
    super.dispose();
    tabController.dispose();
  }
    

  @override
  Widget build(BuildContext context){
    return Scaffold( 
      // backgroundColor: Colors.grey,
      appBar: AppBar(
        // backgroundColor: Colors.amber,
        backgroundColor: Colors.black87,   
        // toolbarHeight: 100,
        // shape: Css.roundBottomAppbar, 
        // centerTitle: true, 
        title: const Text('Price List', style: TextStyle(color: Colors.white)),
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
      // body: const Center( child: Text('Pricelist'), ), 
      body:  TabBarView(
        controller: tabController,
        children: _listWidget
      ),
    );
  }

  List<Widget> _listWidget = [
    const Vkool(), 
    const Solargard(), 
  ];

}