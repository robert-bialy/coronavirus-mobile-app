class InformationBlock {
  int confirmed = 0;
  int deaths = 0;
  int recovered = 0;

  InformationBlock.fromCsv(List<List<dynamic>> csv) {
    for(int i = 0; i < csv[0].length; ++i) {
      if(csv[0][i] as String == "Confirmed") confirmed = getValueFromIndex(csv, i);
      if(csv[0][i] as String == "Deaths") deaths = getValueFromIndex(csv, i);
      if(csv[0][i] as String == "Recovered") recovered = getValueFromIndex(csv, i);
    }
  }

  int getValueFromIndex(List<List<dynamic>> values, int index) {
    int sum = 0;
    for(int counter = 1; counter < values.length; ++counter) {
      if(values[counter][index] == "") continue;
      sum += values[counter][index] as int;
    }
    return sum;
  }
}