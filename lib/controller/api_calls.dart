import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_api/model/to_do_model/to_do_model.dart';

import '../model/to_do_model/item.dart';

ValueNotifier<List<Item>> itemsNotifier = ValueNotifier([]);

Future<void> getAllNotes() async {
  try {
    String url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final response = await http.get(Uri.parse(url));
    print(
        '------------------------------------------------------------------------------------');
    print(response.body);

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final data = ToDoModel.fromJson(json);
    print(data.items);
    itemsNotifier.value.clear();
    if (data.items != null) {
      for (var item in data.items!) {
        print(item.description);
        itemsNotifier.value.add(item);
      }
    } else {
      print('nothing in itesms');
    }
    itemsNotifier.notifyListeners();
    print(
        '------------------------------------------------------------------------------------');
  } catch (e) {
    print(e.toString());
  }
}


Future<bool>deleteNote(String id)async{
  try{
    print(id);
        String url = 'https://api.nstack.in/v1/todos/$id';
    final response = await http.delete(Uri.parse(url));
    await getAllNotes();
  }catch(e){
    print(e.toString());
    return false;
  }
  return true;
}