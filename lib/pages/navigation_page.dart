import 'package:coronavirus/pages/content_page.dart';
import 'package:coronavirus/pages/statistic_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../bloc/app_state.dart';

final String _description = "2019 Novel Coronavirus (2019-nCoV) is a virus (more specifically, a coronavirus) identified as the cause of an outbreak of respiratory illness first detected in Wuhan, China. Early on, many of the patients in the outbreak in Wuhan, China reportedly had some link to a large seafood and animal market, suggesting animal-to-person spread. However, a growing number of patients reportedly have not had exposure to animal markets, indicating person-to-person spread is occurring. At this time, it’s unclear how easily or sustainably this virus is spreading between people.";
final String _about = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eu volutpat purus. Vestibulum vehicula efficitur faucibus. Phasellus vulputate metus neque, eu pulvinar nisl imperdiet a. Pellentesque ut ultricies libero. Donec ut gravida leo. Aenean sit amet neque elementum, ultrices nunc ac, dignissim metus. In eget diam laoreet, luctus lorem vitae, pretium risus. Maecenas ligula diam, ullamcorper at dignissim eu, viverra sit amet risus. Praesent faucibus porta ultricies. Vivamus a odio sit amet est blandit facilisis. Phasellus tristique convallis nisl, quis vestibulum metus ullamcorper a. Donec non lorem enim. Donec fermentum in odio non varius. Cras vitae nulla vel urna consequat ullamcorper. Quisque sed fermentum magna. Donec auctor dui ut turpis venenatis, a sodales dui posuere.";

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
                currentAccountPicture: Icon(Icons.help_outline),
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