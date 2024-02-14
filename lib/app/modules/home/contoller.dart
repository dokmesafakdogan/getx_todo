// ignore_for_file: unnecessary_overrides

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_todo/app/data/models/task_model.dart';
import 'package:getx_todo/app/data/services/storage/repository.dart';

class HomeController extends GetxController {
  TaskRespository taskRespository;
  HomeController({required this.taskRespository});

  final formKey = GlobalKey<FormState>();
  final tasks = <Task>[].obs;
  final editController = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final task = Rx<Task?>(null);
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;
  final tabIndex = 0.obs;

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

  void changeTabIndex(int index){
    tabIndex.value = index;
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  void changeTask(Task? select) {
    task.value = select;
  }

  void changeTodos(List<dynamic> select) {
    doingTodos.clear();
    doneTodos.clear();
    for (int i = 0; i < select.length; i++) {
      var todo = select[i];
      var status = todo['done'];
      if (status == true) {
        doneTodos.add(todo);
      } else {
        doingTodos.add(todo);
      }
    }
  }

  // void changeDeleting(bool value){
  //   deleting.value;
  // }

  void toggle() {
    deleting.value = !deleting.value;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containTodo(todos, title)) {
      return false;
    }
    var todo = {'title': title, 'done': false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIdx = tasks.indexOf(task);
    tasks[oldIdx] = newTask;
    tasks.refresh();
    return true;
  }

  bool containTodo(List todos, String title) {
    return todos.any((element) => element['title'] == title);
  }

  bool addTodo(String title) {
    var todo = {'title': title, 'done': false};
    if (doingTodos.any(
      (element) => mapEquals<String, dynamic>(todo, element))){
        return false;
      }
      var doneTodo = {'title' : title, 'done' : true};
      if(doneTodos.any((element) => mapEquals<String,dynamic>(doneTodo, element))){
        return false;
      }
      doingTodos.add(todo);
      return true;
  }

  void updateTodos(){
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([ 
      ...doingTodos,
      ...doneTodos,
    ]);
    var newTask = task.value!.copyWith(todos: newTodos);
    int oldIdx = tasks.indexOf(task.value);
    tasks[oldIdx] = newTask;
    tasks.refresh(); 
  }

  void doneTodo(String title) {
    var doingTodo = {'title' : title, 'done' : false};
    int index = doingTodos.indexWhere((element) => mapEquals<String, dynamic>(doingTodo,element));
    doingTodos.removeAt(index);
    var doneTodo = {'title' : title, 'done' : true};
    doneTodos.add(doneTodo);
    doingTodos.refresh();
    doneTodos.refresh();
  }

  void deleteDoneTodo(dynamic doneTodo) {
    int index = doneTodos.indexWhere((element) => 
    mapEquals<String,dynamic>(doneTodo, element));
    doneTodos.removeAt(index);
    doneTodos.refresh();
  }

  bool isTodosEmpty(Task task){
    return task.todos == null || task.todos!.isEmpty;
  }

  int getDonetodos(Task task){
    var res = 0;
    for(int i = 0; i< task.todos!.length; i ++){
      if(task.todos![i]['done'] == true ){
        res += 1;
      }
    }
    return res;
  }

  int getTotalTask (){
    var res = 0;
    for( int i = 0; i < tasks.length; i++){
      if(tasks[i].todos != null){
        res += tasks[i].todos!.length;
      }
    }
    return res;
  }

  int getTotalDoneTask(){
    var res = 0;
    for (int i = 0; i < tasks.length; i++){
      if(tasks[i].todos != null){
        for(int j = 0; j < tasks[i].todos!.length; j++){
          if(tasks[i].todos![j]['done'] == true){
            res += 1;
          }
        }
      }
    }
    return res; 
  }
} 
