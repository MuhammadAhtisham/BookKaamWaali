import 'package:bookkaamwaali/home_screen/servicesPages/feedBackPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TimeLine extends StatefulWidget {
  String order, services, totalPayment, startingTime, status, employeeKey ;

  TimeLine({Key? key,required this.order, required this.services, required this.totalPayment, required this.startingTime, required this.status, required this.employeeKey}) : super(key: key);

  @override
  State<TimeLine> createState() => _TimeLineState();
}


class _TimeLineState extends State<TimeLine> {


  int currentStep = 0;
  continueStep() {
    if (currentStep < 4) {
      setState(() {
        currentStep = currentStep + 1;//currentStep+=1;
      });
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1; //currentStep-=1;
      });
    }
  }

  onStepTapped(int value) {
    setState(() {
      currentStep = value;
    });
    c1 : Colors.pink;
  }
  Widget controlBuilders(context, details) {
    if(currentStep==4){
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            ElevatedButton(
              onPressed: (){
                var time = DateTime.now();
                DatabaseReference dbref1 = FirebaseDatabase.instance.ref();
                dbref1.child("Orders").child(widget.order).update({
                  "endingTime": (time.hour).toString() + ":"+ (time.minute).toString(),
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) => Feedback_Screen(employeeKey: widget.employeeKey, order: widget.order)),);
              },
              child: Text('Yes'),
            ),
            SizedBox(width: 10),
            // OutlinedButton(
            //   onPressed: details.onStepCancel,
            //   child: Text('Back'),
            // ),
          ],
        ),
      );
    }
   else{
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            ElevatedButton(
              onPressed: details.onStepContinue,
              child: Text('Yes'),
            ),
            SizedBox(width: 10),
            // OutlinedButton(
            //   onPressed: details.onStepCancel,
            //   child: Text('Back'),
            // ),
          ],
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 7),
            child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.blueAccent,),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.0, right: 15.0, left: 15.0),
              child: Text(
                'Where is your \nService provider?',
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, right: 15.0, left: 15.0,),
              child: Text(
                'Tap on stepper in order to proceed.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
              child: Stepper(
                controlsBuilder: controlBuilders,
                type: StepperType.vertical,
                physics:ScrollPhysics(),
                onStepTapped: onStepTapped,
                onStepContinue: continueStep,
                onStepCancel: cancelStep,
                currentStep: currentStep,
                steps: [
                  Step(
                    title: currentStep==1  ||  currentStep==2 || currentStep==3 || currentStep==4?Text(
                      'Selected service',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ): Text(
                      'Selected service',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: ListTile(
                      leading: Icon(Icons.room_service_outlined, color: Colors.blueAccent,),
                      title: Text(widget.services.toString(), style: TextStyle(fontWeight: FontWeight.w400,),),
                      subtitle: Text(widget.totalPayment, style: TextStyle(fontWeight: FontWeight.w500,),),
                      trailing: Icon(Icons.home_work_sharp, color: Colors.lightGreen),
                    ),
                    state: currentStep >= 1 ? StepState.complete : StepState.indexed,
                    isActive: currentStep >= 1,
                  ),

                  Step(
                    title: currentStep==2 || currentStep==3 || currentStep==4? Text(
                      'Recieved Call?',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ): Text(
                      'Recieved Call?',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: ListTile(
                      leading: Icon(Icons.phone_android, color: Colors.blueAccent,),
                      title: Text('Confirmation Call', style: TextStyle(fontWeight: FontWeight.w400,),),
                      subtitle: Text('We will contact you within 15 min', style: TextStyle(fontWeight: FontWeight.w500,),),
                      trailing: Icon(Icons.phone, color: Colors.lightGreen),
                    ),
                    isActive: currentStep >= 2,
                    state: currentStep >= 2 ? StepState.complete : StepState.indexed,
                  ),
                  Step(
                    title: currentStep==3 || currentStep==4? Text(
                      'Is Arrived?',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ): Text(
                      'Is Arrived?',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: ListTile(
                      leading: Icon(Icons.map, color: Colors.blueAccent,),
                      title: Text('Arriving Soon', style: TextStyle(fontWeight: FontWeight.w400,)),
                      subtitle: Text('Service provider is arriving in 30 min', style: TextStyle(fontWeight: FontWeight.w500,),),
                      trailing: Icon(Icons.watch_later_rounded, color: Colors.lightGreen),
                    ),
                    isActive: currentStep >= 3,
                    state: currentStep >= 3 ? StepState.complete : StepState.indexed,
                  ),
                  Step(
                    title: currentStep==4? Text(
                      'Is Service Started?',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ):  Text(
                      'Is Service Started?',
                      style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: ListTile(
                      leading: Icon(Icons.phone_android, color: Colors.blueAccent,),
                      title: Text('Has Started?', style: TextStyle(fontWeight: FontWeight.w400,),),
                      subtitle: Text('If started, Click on yes', style: TextStyle(fontWeight: FontWeight.w500,),),
                      trailing: Icon(Icons.not_started, color: Colors.green),
                    ),
                    isActive: currentStep >= 4,
                    state: currentStep >= 4 ? StepState.complete : StepState.disabled,
                  ) ,
                  Step(
                    title: currentStep>4? Text(
                      'Make Payment',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ):  Text(
                      'Make Payment?',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: ListTile(
                      leading: Icon(Icons.phone_android, color: Colors.blueAccent,),
                      title: Text('Have you Paid?', style: TextStyle(fontWeight: FontWeight.w400,),),
                      subtitle: Text('If yes, Click on Done', style: TextStyle(fontWeight: FontWeight.w500,),),
                      trailing: Icon(Icons.money, color: Colors.green),
                    ),
                    isActive: currentStep >= 5,
                    state: currentStep >= 5 ? StepState.complete : StepState.disabled,
                  ) ,

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}