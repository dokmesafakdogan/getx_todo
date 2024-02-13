import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/app/core/utils/extensions.dart';
import 'package:getx_todo/app/data/models/task_model.dart';
import 'package:getx_todo/app/modules/detail/view.dart';
import 'package:getx_todo/app/modules/home/contoller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TaskCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final Task task;
  TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color);
    var squareWidth = Get.width - 12.0.wp;
    return GestureDetector(
      onTap: () {
        Get.to(() => DetailPage());
        homeCtrl.changeTask(task);
        homeCtrl.changeTodos(task.todos ?? []);
      },
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 7,
            offset: const Offset(0, 7),
          )
        ]),
        child:    Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TODO change after finish todo Crud
             StepProgressIndicator(
            totalSteps:100,
            currentStep: 80,
            size: 5,
            padding: 0,
            selectedGradientColor: LinearGradient(colors: [
              color.withOpacity(0.5),color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            
            ), 
            unselectedGradientColor:const  LinearGradient(colors: [
              Colors.white,Colors.white
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            ), 
            ),
            Padding(
              padding:  EdgeInsets.all(6.0.wp),
              child: Icon(IconData(task.icon,fontFamily: 'MaterialIcons'),
              color: color,
              ),
            ),
            Padding(
              padding:  EdgeInsets.all(6.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0.sp
                  ),
                  overflow: TextOverflow.ellipsis ,
                  ),
                   SizedBox(height: 2.0.wp,),
                  Text('${task.todos?.length ?? 0} Task',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                  ),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
