import 'package:coronavirus/bloc/app_state.dart';
import 'package:coronavirus/constants.dart';
import 'package:coronavirus/models/information_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class StatisticPage extends StatefulWidget {
  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  AppState _appState;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_appState == null) _appState = Provider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Colors.white,
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
                color: Constants.violet,
              );
            }
            return Center(child: CircularProgressIndicator(backgroundColor: Constants.violet));
          },
        ),
    );
  }

  Widget informationBlock(InformationBlock informationBlock) {
    return Card(
      color: Colors.white, elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          createCard("Infected", informationBlock.confirmed.toString()),
          Divider(),
          createCard("Deaths", informationBlock.deaths.toString()),
          Divider(),
          createCard("Recovered", informationBlock.recovered.toString()),
        ],
      )
    );
  }

  Widget createCard(String title, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(fontSize: 20, color: Colors.black54)),
                Text(value, style: TextStyle(fontSize: 40, color: Colors.black54)),
              ],
            ),
          )
    );
  }
}
