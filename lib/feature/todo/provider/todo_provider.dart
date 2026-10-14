import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/feature/todo/widget/widget.dart';

final todoProvider = NotifierProvider<TodoNotifier, List<Todomodel>>(TodoNotifier.new);

class TodoNotifier extends Notifier<List<Todomodel>>{
  @override
  List<Todomodel> build() {
    // TODO: implement build
    return [];
  }

  void addTodo (Todomodel model) {

    state = [... state, model];
    
  }

  void deleteTodo(int index){

    state.removeAt(index);
    state= [...state];

  }

  void editTodo(int index, Todomodel model){
     state.removeAt(index);
     state.insert(index, model);
     state = [...state];

  }

  void searchTodo(List providerList,  dynamic searchController){
    List listcopy = [...state];
    state.clear();
    for(var value in listcopy){
      if(value.title.toString().toLowerCase().contains(searchController.text.toLowerCase()) || value.subTitle.toString().toLowerCase().contains(searchController.text.toLowerCase()) ){
     providerList.add(value);

      }
    }
  }

}