import 'package:connectivity/connectivity.dart';
import 'package:coronavirus/constants.dart';
import 'package:coronavirus/models/information_block.dart';
import 'package:coronavirus/widgets/information_block_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StatisticPage extends StatefulWidget {
  final VoidCallback getStreamInfo;
  final Stream<List<InformationBlock>> informationBlockStream;
  final String title;

  const StatisticPage({Key key, this.getStreamInfo, this.informationBlockStream, this.title}) : super(key: key);
  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  @override
  void initState() {
    super.initState();
    widget.getStreamInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: StreamBuilder<List<InformationBlock>>(
          stream: widget.informationBlockStream,
          builder: (context, snapshot) {
            if(snapshot.hasError) return Text(snapshot.error.toString());
            if(snapshot.data != null) {
              return RefreshIndicator(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) => _buildCountryCard(context, snapshot.data[index])
                  ),
                ),
                onRefresh: () {
                  Connectivity().checkConnectivity().then((value) {
                    if(value != ConnectivityResult.none) widget.getStreamInfo();
                    else callConnectivityToast();
                  });
                  return;
                },
                color: Constants.violet,
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
    );
  }

  Widget _buildCountryCard(BuildContext context, InformationBlock informationBlock) {
    return InformationBlockCard(
        informationBlock: informationBlock,
        title: widget.title ?? informationBlock.country ?? '',
        subtitle: informationBlock.state);
  }

  void callConnectivityToast() {
    Fluttertoast.showToast(
        msg: "Check connectivity!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        fontSize: 16.0
    );
  }
}
