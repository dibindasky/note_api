import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_api/model/to_do_model/to_do_model.dart';

import '../../model/to_do_model/item.dart';

class ApiCalls {
  Future<List<Item>> getAllNotes() async {
    List<Item> temp = [];
    try {
      String url = 'https://api.nstack.in/v1/todos';
      final response = await http.get(Uri.parse(url));
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final data = ToDoModel.fromJson(json);
      if (data.items != null) {
        for (var item in data.items!) {
          temp.add(item);
        }
      }
    } catch (e) {
      return <Item>[];
    }
    return temp;
  }

  Future<bool> deleteNote(String id) async {
    try {
      String url = 'https://api.nstack.in/v1/todos/$id';
      final response = await http.delete(Uri.parse(url));
      print(response.statusCode);
      if (response.statusCode == 200) {
        await getAllNotes();

        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> addNote({required Item note}) async {
    Map<String, dynamic> data = {
      'title': note.title,
      'description': note.description,
      'is_completed': 'false'
    };
    try {
      String url = 'https://api.nstack.in/v1/todos';
      final response = await http.post(
        Uri.parse(url),
        body: data,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<bool> updateNote({required Item note}) async {
    print('in update note id is ----------${note.id}');
    Map<String, dynamic> data = {
      'id': note.id,
      'title': note.title,
      'description': note.description,
      'is_completed': 'false'
    };
    Map<String, String> head = {'Content-Type': 'application/json'};
    String url = 'https://api.nstack.in/v1/todos/${note.id}';
    try {
      final response =
          await http.put(Uri.parse(url), body: jsonEncode(data), headers: head);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return true;
  }
}
