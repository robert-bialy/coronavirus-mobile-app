import 'package:coronavirus/pages/content_page.dart';
import 'package:coronavirus/pages/statistic_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../bloc/app_state.dart';

final String _description = "2019 Novel Coronavirus (2019-nCoV) is a virus (more specifically, a coronavirus) identified as the cause of an outbreak of respiratory illness first detected in Wuhan, China. Early on, many of the patients in the outbreak in Wuhan, China reportedly had some link to a large seafood and animal market, suggesting animal-to-person spread. However, a growing number of patients reportedly have not had exposure to animal markets, indicating person-to-person spread is occurring. At this time, it’s unclear how easily or sustainably this virus is spreading between people.";
final String _about = "This application is in beta! \n\This application was created to spread awarnes about Coronavirus. All data is based on informations provided by https://systems.jhu.edu/research/public-health/ncov/ \n\n Upcoming features: \n - infections per country \n - infections per state \n Stay tuned!";
class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Statistic", Icons.poll),
    new DrawerItem("Background", Icons.details),
    new DrawerItem("About app", Icons.help_outline)
  ];

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;
  AppState _appState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_appState == null) _appState = Provider.of(context);
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0: return new StatisticPage();
      case 1: return new ContentPage(description: _description);
      case 2: return new ContentPage(description: _about);
      default: return new Text("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon,),
            title: new Text(d.title, style: TextStyle(fontSize: 14)),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }
    return new Scaffold(
      appBar: new AppBar(title: new Text(widget.drawerItems[_selectedDrawerIndex].title)),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text("Coronavirus 2019-nCoV", style: TextStyle(fontSize: 20)),
                accountEmail: Text("Time updated: " + DateFormat('dd.MM.yyyy kk:mm').format(_appState?.timeUpdated ?? DateTime.now())),
                currentAccountPicture: Icon(Icons.healing),
            ),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop();
  }
}