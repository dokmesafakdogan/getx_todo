import 'package:get/get.dart';
import 'package:getx_todo/app/data/providers/task/provider.dart';
import 'package:getx_todo/app/data/services/storage/repository.dart';
import 'package:getx_todo/app/modules/home/contoller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRespository: TaskRespository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
