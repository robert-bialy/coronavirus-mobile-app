import 'package:coronavirus/bloc/app_state.dart';
import 'package:coronavirus/constants.dart';
import 'package:coronavirus/models/information_block.dart';
import 'package:coronavirus/widgets/information_block_card.dart';
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
                  child: InformationBlockCard(informationBlock: snapshot.data, title: "Worldwide"),
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
}
