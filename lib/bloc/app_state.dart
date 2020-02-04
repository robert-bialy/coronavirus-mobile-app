import 'dart:convert';
import 'package:coronavirus/bloc/repository.dart';
import 'package:coronavirus/models/information_block.dart';
import 'package:coronavirus/models/response_wrapper.dart';
import 'package:rxdart/rxdart.dart';

class AppState {
  IRepository _repository;
  BehaviorSubject<InformationBlock> _information;
  Stream<InformationBlock> get summary => _information.stream;

  DateTime timeUpdated = DateTime.now();


  AppState(IRepository repository) {
    _repository = repository;
    _information = new BehaviorSubject<InformationBlock>();
  }

  getWorldSummaryData() async {
    timeUpdated = DateTime.now();
    ResponseWrapper<String> response = await _repository.getWorldSummary();
    if(response.isSuccess) {
      InformationBlock informationBlock = InformationBlock.fromJson(jsonDecode(response.message));
      _information.add(informationBlock);
    }
    else _information.addError(response.error);
  }

  void dispose() {
    _information.close();
  }
}