import 'package:coronavirus/bloc/repository.dart';
import 'package:coronavirus/models/information_block.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  DateTime timeUpdated;
  IRepository _repository;

  AppState(IRepository repository) {
    _repository = repository;
  }

  Future<InformationBlock> getData() async {
    timeUpdated = DateTime.now();
    String data = await _repository.getMostRecentData();
    return InformationBlock.fromCsv(CsvToListConverter().convert(data));
  }
}