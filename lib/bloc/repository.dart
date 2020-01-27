import 'package:http/http.dart';

abstract class IRepository {
  Future<String> getMostRecentData();
}

class Repository implements IRepository {
  String url = 'https://docs.google.com/spreadsheet/ccc?key=1yZv9w9zRKwrGTaR-YzmAqMefw4wMlaXocejdxZaTs6w&output=csv';

  @override
  Future<String> getMostRecentData() async {
    try{
      Response response = await get(url);
      return response.body;
    } catch (ex) {
      print(ex);
    }
    return null;
  }
}


