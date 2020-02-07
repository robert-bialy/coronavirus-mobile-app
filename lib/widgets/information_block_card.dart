import 'package:coronavirus/models/information_block.dart';
import 'package:flutter/material.dart';

class InformationBlockCard extends StatefulWidget {
  final InformationBlock informationBlock;
  final String title;
  final String subtitle;
  const InformationBlockCard({Key key, this.informationBlock, this.title, this.subtitle}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InformationBlockCardState();
}

class _InformationBlockCardState extends State<InformationBlockCard> {
  @override
  Widget build(BuildContext context) => informationBlock(widget.informationBlock);

  Widget informationBlock(InformationBlock informationBlock) {
    return Card(
        color: Colors.white,
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(widget.title, style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.w500))
              ),
              widget.subtitle != null ?
              Container(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(widget.subtitle, style: TextStyle(fontSize: 14, color: Colors.black))
              ) : Container(),
              createCard("Total Infected", informationBlock.confirmed.toString()),
              Divider(color: Colors.black),
              createCard("Total Deaths", informationBlock.deaths.toString()),
              Divider(color: Colors.black),
              createCard("Total Recovered", informationBlock.recovered.toString()),
              Divider(color: Colors.black),
            ],
          ),
        )
    );
  }

  Widget createCard(String title, String value) {
    return Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          child: Row(
            children: <Widget>[
              Text(title, style: TextStyle(fontSize: 16, color: Colors.black)),
              Spacer(),
              Text(value, style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500)),
            ],
          ),
        );
  }
}