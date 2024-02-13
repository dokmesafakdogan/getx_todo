// ignore_for_file: unnecessary_overrides

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_todo/app/data/models/task_model.dart';
import 'package:getx_todo/app/data/services/storage/repository.dart';

class HomeController extends GetxController{
  TaskRespository taskRespository;
  HomeController({required this.taskRespository});

  final formKey = GlobalKey<FormState>();
  final tasks = <Task>[].obs;
  final editController = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final task = Rx<Task?>(null);


  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRespository.readTasks());
    ever(tasks, (_) => taskRespository.writeTasks(tasks));
  }

  
  @override
  void onClose() {
    editController.dispose();
    super.onClose();
  }

  void changeChipIndex(int value){
    chipIndex.value = value;
  }

  void changeTask (Task? select){
    task.value = select;
  }

  // void changeDeleting(bool value){
  //   deleting.value;
  // }

  void toggle() {
    deleting.value = !deleting.value;
  }

  bool addTask(Task task){
    if(tasks.contains(task)){
      return false;
    }
    tasks.add(task);
    return true;
  }

  void deleteTask(Task task){
    tasks.remove(task);
  } 

  updateTask(Task task,String title){
    var todos = task.todos ?? [];
    if(containTodo(todos,title)){ 
      return false;
    }
    var todo = { 'title' : title, 'done' : false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIdx = tasks.indexOf(task);
    tasks[oldIdx] = newTask;
    tasks.refresh();
    return true;

  }

    bool containTodo(List todos,String title){
      return todos.any((element) => element['title'] == title);
    }

  
}