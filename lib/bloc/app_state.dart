import 'package:coronavirus/bloc/repository.dart';
import 'package:coronavirus/models/information_block.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  DateTime timeUpdated = DateTime.now();
  IRepository _repository;

  AppState(IRepository repository) {
    _repository = repository;
  }

  Future<InformationBlock> getData() async {
    timeUpdated = DateTime.now();
    String data = await _repository.getMostRecentData();
    var informationBlock = InformationBlock.fromCsv(CsvToListConverter().convert(data));
    notifyListeners();
    return informationBlock;
  }
}