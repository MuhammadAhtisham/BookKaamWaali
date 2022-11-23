import 'package:flutter/material.dart';

void main() {
  runApp(const Beauty());
}
class Beauty extends StatelessWidget {
  const Beauty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Center(
                child: Container(
                  child : Image.asset('asset/b1.png'),

                ),
              ),

              Center(
                child: Column(
                  children: [
                     Container(
                        child: Text('Let US Reward'),
                      ),
                     Row(
                        children: [
                          Container(
                            child: Text('You,'),
                          ),
                          Container(
                            child: Text(
                                'Naturally!!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),


        ),
      ),
    );
  }
}
