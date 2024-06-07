import 'package:flutter/material.dart';
import 'package:thoughtpad/models/thought_model.dart';
import 'package:thoughtpad/services/database_helper.dart';

class ThoughtProvider with ChangeNotifier {
  List<Thought> thoughts = [];

  ThoughtProvider() {
    getThoughts();
  }

  getThoughts() async {
    thoughts = (await DatabaseHelper.getAllThoughts());
    notifyListeners();
  }

  insert({required Thought thought}) async {
    await DatabaseHelper.addThought(thought: thought);
    getThoughts();
    return true;
  }

  update({required Thought thought}) async {
    await DatabaseHelper.updateThought(thought: thought);
    getThoughts();
  }

  Future<bool> delete({required Thought thought}) async {
    await DatabaseHelper.deleteThought(thought: thought);
    getThoughts();
    return true;
  }
}
