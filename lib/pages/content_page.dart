import 'package:flutter/material.dart';
class ContentPage extends StatefulWidget {
  final String description;
  const ContentPage({Key key, this.description}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContentPageState();

}
class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: Text(
        widget.description,
            style: TextStyle(
                fontFamily: "Roboto",
                color: Colors.black,
                fontSize: 16,
                height: 1.5,
                letterSpacing: 0.5
            )
        )
    );
  }
}