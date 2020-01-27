import 'package:coronavirus/bloc/app_state.dart';
import 'package:coronavirus/models/information_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  AppState _appState;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_appState == null) _appState = Provider.of(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Coronavirus 2019-nCoV")),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: FutureBuilder<InformationBlock>(
          future: _appState.getData(),
          builder: (context, snapshot) {
            if(snapshot.data != null) {
              return RefreshIndicator(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: informationBlock(snapshot.data),
                ),
                onRefresh: () => _appState.getData(),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget informationBlock(InformationBlock informationBlock) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("Time updated: "),
            Text(DateFormat('dd.MM.yyyy kk:mm').format(_appState.timeUpdated), style: TextStyle(color: Colors.black)),
          ],
        ),
        createCard("Infected", informationBlock.confirmed.toString()),
        createCard("Deaths", informationBlock.deaths.toString()),
        createCard("Recovered", informationBlock.recovered.toString()),
      ],
    );
  }

  Widget createCard(String title, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Card(
          elevation: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(fontSize: 20)),
                Text(value, style: TextStyle(fontSize: 40, color: Colors.black)),
              ],
            ),
          )
      ),
    );
  }
}
