import 'dart:async';
import 'package:coronavirus/bloc/repository.dart';
import 'package:coronavirus/models/information_block.dart';
import 'package:coronavirus/models/response_wrapper.dart';
import 'package:rxdart/rxdart.dart';

class AppState {
  DateTime timeUpdated = DateTime.now();

  IRepository _repository;
  BehaviorSubject<List<InformationBlock>> _summarySubject;
  BehaviorSubject<List<InformationBlock>> _countriesSubject;
  Stream<List<InformationBlock>> get summaryStream => _summarySubject.stream;
  Stream<List<InformationBlock>> get countriesStream => _countriesSubject.stream;

  AppState(IRepository repository) {
    _repository = repository;
    _summarySubject = new BehaviorSubject<List<InformationBlock>>();
    _countriesSubject = new BehaviorSubject<List<InformationBlock>>();
  }

  getWorldSummaryData() async {
    timeUpdated = DateTime.now();
    ResponseWrapper<InformationBlock> response = await  _repository.getWorldSummary();
    if(response.isSuccess) {
      _summarySubject.add([response.message]);
    }
    else _summarySubject.addError(response.error);
  }

  getPerCountryInformation() async {
    timeUpdated = DateTime.now();
    ResponseWrapper<List<InformationBlock>> response = await _repository.getPerCountrySummary();
    if(response.isSuccess) {
      _countriesSubject.add(response.message);
    }
    else _countriesSubject.addError(response.error);
  }

  void dispose() {
    _summarySubject.close();
    _countriesSubject.close();
  }
}