import 'package:coronavirus/models/response_wrapper.dart';
import 'package:http/http.dart';

abstract class IRepository {
  Future<ResponseWrapper<String>> getWorldSummary();
}

class Repository implements IRepository {
  String endpointAddress = 'https://coronavirusapi.herokuapp.com/';

  @override
  Future<ResponseWrapper<String>> getWorldSummary() async {
    try{
      Response response = await get(endpointAddress + 'world');
      return ResponseWrapper.withSuccess(response.body);
    } on Exception catch(exception) {
      return ResponseWrapper.withError(exception.toString());
    }
  }
}


