import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_todo/app/core/values/colors.dart';
import 'package:getx_todo/app/data/models/task_model.dart';
import 'package:getx_todo/app/modules/home/add_card.dart';
import 'package:getx_todo/app/modules/home/contoller.dart';
import 'package:getx_todo/app/core/utils/extensions.dart';
import 'package:getx_todo/app/modules/home/widgets/add_dialog.dart';
import 'package:getx_todo/app/modules/home/widgets/task_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(4.0.wp),
            child: Text(
              'My List',
              style: TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Obx(
            () => GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...controller.tasks
                    .map((element) => LongPressDraggable(
                        data: element,
                        onDragStarted: controller.toggle,
                        // onDraggableCanceled: (_,__) => controller.changeDeleting(false),
                        onDragEnd: (_) => controller.toggle(),
                        feedback: Opacity(
                            opacity: 0.8, child: TaskCard(task: element)),
                        
                        child: TaskCard(task: element)))
                    // ignore: unnecessary_to_list_in_spreads
                    .toList(),
                AddCard(),
              ],
            ),
          ),
        ],
      )),
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
              backgroundColor: controller.deleting.value ? Colors.red : blue,
              shape: const CircleBorder(),
              onPressed: () {
                if (controller.tasks.isNotEmpty) {
                  Get.to(() => AddDialog(), transition: Transition.downToUp);
                }else{
                  EasyLoading.showInfo('Please create your task type');
                }
              },
              child: Icon(
                controller.deleting.value ? Icons.delete : Icons.add,
                color: Colors.white,
              ),
            ),
          );
        },
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Delete Sucses');
        },
      ),
    );
  }
}
