// ignore_for_file: sized_box_for_whitespace

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

Widget titlePage(BuildContext context, String title){
  return Center(
    child: Container( 
      color: Colors.black,
      height: 40 ,
      child: Center(
        child : Text(title, style: const TextStyle(color: Colors.orange, fontSize: 20, ),)
      ),
    ),
  );
}

Widget labelFormWhite(String t) => Text('  $t', style: const TextStyle(color: Colors.white),); 

Widget br(double height ){
  return Container(
    height: height,
  );
}

Widget spasi(double width){
  return Container(
    width: width,
  );
}

 snackAlert(String title, String message){
  Get.snackbar(
    title, 
    message,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    titleText:  Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
    messageText: Text(message, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
    backgroundColor: Colors.grey,
    icon: const Icon(Icons.info_outline, color: Colors.red, size: 40,)
  );
 }

 snackError(String title, String message){
  Get.snackbar(  
    title, 
    message,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    titleText:  Text(title, style: const TextStyle(fontSize: 17),),
    messageText: Text(message, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
    backgroundColor: Colors.yellow[50],
    icon: const Icon(Icons.info_outline, color: Colors.red, size: 40,),
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(20),
  );
 }

 defaultDialogErr(String msg){ 
          Get.defaultDialog(
            title: '',
            titlePadding: const EdgeInsets.all(0),
            contentPadding: const EdgeInsets.all(20),
            content: Column(children:   [
              const Icon(Icons.error, color: Colors.red, size: 40,),
              const Divider(color: Colors.amber,),
              Text(msg)
            ],),
            textCancel: 'Tutup',
            cancelTextColor: Colors.black,
            buttonColor: Colors.grey 
          );
 }

 defaultDialogSukses(String msg, Widget kelas){ 
          Get.defaultDialog(
            title: '',
            titlePadding: const EdgeInsets.all(0),
            contentPadding: const EdgeInsets.all(20),
            content: Column(children:   [
              const Icon(Icons.check_circle, color: Colors.green, size: 40,),
              const Divider(color: Colors.amber,),
              Text(msg)
            ],),   
            textConfirm: 'OK',
            confirmTextColor: Colors.black,
            onConfirm: () => Get.offAll(() => kelas) ,
            buttonColor: Colors.amber,
            barrierDismissible: false
          );
 }

 defaultDialogSuksesStaypage(String msg){ 
          Get.defaultDialog(
            title: '',
            titlePadding: const EdgeInsets.all(0),
            contentPadding: const EdgeInsets.all(20),
            content: Column(children:   [
              const Icon(Icons.check_circle, color: Colors.green, size: 40,),
              const Divider(color: Colors.amber,),
              Text(msg)
            ],),   
            textConfirm: 'OK',
            confirmTextColor: Colors.black,
            onConfirm: () => Get.back() ,
            buttonColor: Colors.amber,
            barrierDismissible: false
          );
 }
  
 defaultBottomSheet(Widget kelas){ 
    Get.bottomSheet(   
      Container( 
        height: null,
        padding: const EdgeInsets.all(20),   
        child: Column(children:   [
            const Text('Lengkapi data'), 
            TextButton(
              onPressed: () => Get.to(() => kelas), 
              child: const Text('Lengkapi data')
            )
         ]
        ),
      ) ,
      backgroundColor: Colors.white, 
      shape: const OutlineInputBorder(
                      borderSide: BorderSide(width: 0.1, strokeAlign: 0.5), 
                      // borderRadius: BorderRadius.all(Radius.circular(40))
                      borderRadius: BorderRadius.only(  topRight: Radius.circular(40), topLeft: Radius.circular(40) )
      )
    );
 }

 openImage(String path){ 
  Get.defaultDialog(
    title: 'KTP',
    titlePadding: const EdgeInsets.all(0),
    contentPadding: const EdgeInsets.all(10),
    content: Image.file( File(path), ),
    textCancel: 'Tutup',
    cancelTextColor: Colors.black 
  );
 }

 dialogIcon(){
  Get.dialog(
    // const Icon(Icons.check_circle, size: 50, color: Colors.green,),   
    Container(
      height: 500,
      child: Column(children: [ 
        const Icon(Icons.check_circle, size: 50, color: Colors.green,), 
        Container( 
          color : Colors.white,

          child: const Column( 
            children: [
              Text('Terima kasih telah menlengkapi data', style:TextStyle(fontSize: 18, color: Colors.black, fontStyle:FontStyle.normal  ),),
            ],
          ),
        )
      ]),
    )
  );
 }
