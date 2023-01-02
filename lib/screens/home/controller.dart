import 'package:flutter/material.dart';
import '../../database/models/trainning.dart';

class _HomeController {
  final ValueNotifier<List<Map<String, Object?>>> data = ValueNotifier([]);

  Future<void> refreshData() async {
    data.value = await trainningModel.data;
  }
}

final homeController = _HomeController();
