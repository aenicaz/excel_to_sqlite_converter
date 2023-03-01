import 'dart:async';
import 'dart:io';

import 'package:converter/model/record.dart';
import 'package:excel/excel.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void  main() async { 
  final String databasePath = "D:/Projects/converter/converter/lib/assets/database/sqfile.db";

  var file = "lib/assets/raw_excel_files/raw_excel_computers_file.xlsx";
  var bytes = File(file).readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);
  var tmp = excel.tables['Computers']?.rows.asMap(); //Сама таблица Map (int, List<Data>)
  var tmpList ;
  List<Record> recordList = [];
   
  for (var i = 2; i < excel.tables['Computers']!.maxRows; i++) {
    Record tmpRecord = Record();
    var lng = tmp![i]!.length;
    // for (var j = 0; j < lng; j++) {
    // print(tmp[i]?[j]?.value);
    // }
    tmpRecord.id = tmp[i]?[0]?.value ?? "Missing data";
    tmpRecord.model = tmp[i]?[1]?.value.toString() ?? "Missing data";
    tmpRecord.buhName = tmp[i]?[2]?.value.toString() ?? "Missing data";
    tmpRecord.serialNumber = tmp[i]?[3]?.value.toString() ?? "Missing data";
    tmpRecord.productNumber = tmp[i]?[4]?.value.toString() ?? "Missing data";
    tmpRecord.buhNumber = tmp[i]?[5]?.value.toString() ?? "Missing data";
    tmpRecord.invNumber = tmp[i]?[6]?.value.toString() ?? "Missing data";
    tmpRecord.userName = tmp[i]?[7]?.value.toString() ?? "Missing data";
    tmpRecord.storage = tmp[i]?[8]?.value.toString() ?? "Missing data";
    tmpRecord.sealNumber = tmp[i]?[10]?.value.toString() ?? "Missing data";
    tmpRecord.cleanDate = tmp[i]?[11]?.value.toString() ?? "Missing data";
    tmpRecord.comment = tmp[i]?[12]?.value.toString() ?? "Missing data";

    //print(tmpRecord.p1rint()); 
    recordList.add(tmpRecord);
  }
  
  //recordList.forEach((element) { element.p1rint(); });
  /* for (var i = 2; i < excel.tables['Computers']!.maxRows; i++) {
    print('++++++++++++++++++++++++++++++++++++++++++');
    tmpList = tmp![i];
    print(tmpList[3].value);
    tmpList?.forEach((element) {
    print(element?.value ?? "Missing data");
   
    });
  } */

   sqfliteFfiInit();
   var databaseFactory = databaseFactoryFfi;
   var db = await databaseFactory.openDatabase(databasePath);

  //  await db.execute('''
  //     create table "Computers"(
  //       "id" INTEGER PRIMARY KEY,
  //       "model" TEXT,
  //       "buhName" TEXT,
  //       "serialNumber" TEXT,
  //       "productNumber" TEXT,
  //       "buhNumber" TEXT,
  //       "invNumber" TEXT,
  //       "userName" TEXT,
  //       "storage" TEXT,
  //       "sealNumber" TEXT,
  //       "cleanDate" TEXT,
  //       "comment" TEXT
  //   )''');
  
  for (var i = 0; i < recordList.length; i++) {
    db.insert("Computers", {'model' : '${recordList[i].model}', 'buhName' : '${recordList[i].buhName}', 'serialNumber' : '${recordList[i].serialNumber}', 'productNumber' : '${recordList[i].productNumber}', 'buhNumber' : '${recordList[i].buhNumber}', 'invNumber' : '${recordList[i].invNumber}', 'userName' : '${recordList[i].userName}', 'storage' : '${recordList[i].storage}', 'sealNumber' : '${recordList[i].sealNumber}', 'cleanDate' : '${recordList[i].cleanDate}', 'comment' : '${recordList[i].comment}'});
  }

  
  
}