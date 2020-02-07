import 'dart:convert';
import 'package:coronavirus/models/information_block.dart';
import 'package:coronavirus/models/response_wrapper.dart';
import 'package:http/http.dart';

abstract class IRepository {
  Future<ResponseWrapper<InformationBlock>> getWorldSummary();
  Future<ResponseWrapper<List<InformationBlock>>> getPerCountrySummary();
}

class Repository implements IRepository {
  String endpointAddress = 'https://coronavirusapi.herokuapp.com/';

  @override
  Future<ResponseWrapper<InformationBlock>> getWorldSummary() async {
    ResponseWrapper<String> response = await _requestDataFromUrl(endpointAddress + 'world');
    if(!response.isSuccess) return ResponseWrapper.withError(response.error);
    try {
      Map<String, dynamic> summary = jsonDecode(response.message)['worldStats'];
      return ResponseWrapper.withSuccess(InformationBlock.fromSummaryJson(summary));
    } on Exception catch(exception) {
      return ResponseWrapper.withError(exception.toString());
    }
  }

  @override
  Future<ResponseWrapper<List<InformationBlock>>> getPerCountrySummary() async {
    ResponseWrapper<String> response = await _requestDataFromUrl(endpointAddress + 'places');
    if(!response.isSuccess) return ResponseWrapper.withError(response.error);
    try {
      List<dynamic> places = jsonDecode(response.message)['places'];
      List<InformationBlock> informationBlocks = places.map((block) => InformationBlock.fromCountriesJson(block)).toList();
      return ResponseWrapper<List<InformationBlock>>.withSuccess(informationBlocks);
    } on Exception catch(exception) {
      return ResponseWrapper.withError(exception.toString());
    }
  }

  Future<ResponseWrapper<String>> _requestDataFromUrl(String url) async {
    try{
      Response response = await get(url);
      if(response.statusCode != 200) return ResponseWrapper.withError('Internal Service Error!');
      return ResponseWrapper.withSuccess(response.body);
    } on Exception catch(exception) {
      return ResponseWrapper.withError(exception.toString());
    }
  }
}


