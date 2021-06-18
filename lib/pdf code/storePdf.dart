//import 'dart:io';
//import 'dart:math';
//import 'package:file_picker/file_picker.dart';
//import 'package:firebase_database/firebase_database.dart';
//import 'package:firebase_storage/firebase_storage.dart';
//
////class FilePicking{
////  Future pickPdfFile()async{
////    FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'pdf', 'doc','docx'],);
////  }
////}
//final mainReference = FirebaseDatabase.instance.reference().child('Database');
//Future getPdfAndUpload()async{
//  var rng = new Random();
//  String randomName="";
//  for (var i = 0; i < 20; i++) {
//    print(rng.nextInt(100));
//    randomName += rng.nextInt(100).toString();
//  }
//  File file = await FilePicker.getFile(type: FileType.custom);
//  String fileName = '${randomName}.pdf';
//  print(fileName);
//  print('${file.readAsBytesSync()}');
//  savePdf(file.readAsBytesSync(), fileName);
//}
//
//Future savePdf(List<int> asset, String name) async {
//
//  StorageReference reference = FirebaseStorage.instance.ref().child(name);
//  StorageUploadTask uploadTask = reference.putData(asset);
//  String url = await (await uploadTask.onComplete).ref.getDownloadURL();
//  print(url);
//  documentFileUpload(url);
//  return  url;
//}
//void documentFileUpload(String str) {
//
//  var data = {
//    "PDF": str,
//  };
//  mainReference.child("Documents").child('pdf').set(data).then((v) {
//  });
//}