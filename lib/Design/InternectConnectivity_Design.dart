import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
class ConnectivityStatus extends StatefulWidget {
  const ConnectivityStatus({Key? key}) : super(key: key);

  @override
  State<ConnectivityStatus> createState() => _ConnectivityStatusState();
}

class _ConnectivityStatusState extends State<ConnectivityStatus> {
  late String status = "waiting..";
  Connectivity _connectivity = Connectivity();

  @override
  void initState()
  {
    super.initState();
    checkRealTimeConnection();
  }
  void checkRealTimeConnection() async{
    var connectionResult = await _connectivity.checkConnectivity();
    _connectivity.onConnectivityChanged.listen((event){
      if(event == ConnectivityResult.wifi)
       { status = "wifi";}
      else
        {
          status = "Not Connected";
        }
        setState((){});
    });
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Text(status,
        style: TextStyle(
          fontSize: 40,
        )),
      ),
    );
  }
}
