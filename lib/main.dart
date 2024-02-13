import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_todo/app/data/services/storage/services.dart';
import 'package:getx_todo/app/modules/home/binding.dart';
import 'package:getx_todo/app/modules/home/view.dart';


void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init(),);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO List ',
      home: const HomePage(),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    );
  }

  
}
