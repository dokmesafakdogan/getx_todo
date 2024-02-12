 import 'package:getx_todo/app/data/models/task_model.dart';
import 'package:getx_todo/app/data/providers/task/provider.dart';

class TaskRespository{
  TaskProvider taskProvider;
  TaskRespository({required this.taskProvider});

  List<Task> readTasks() => taskProvider.readTasks()
;
void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}