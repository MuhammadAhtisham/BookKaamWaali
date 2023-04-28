import 'package:bookkaamwaali/home_screen/orders/OrderReceipt.dart';
import 'package:bookkaamwaali/home_screen/paymentPages/card_OTP.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';


class CreditCardPage extends StatefulWidget {
  String service, allServices, gender, frequency, price, year, month, day, hour, repeat, employeeKey;
  int additionalPrice;
  CreditCardPage({Key? key, required this.service, required this.allServices, required this.gender, required this.frequency,  required this.price, required this.additionalPrice, required this.year, required this.month, required this.day, required this.hour, required this.repeat, required this.employeeKey}) : super(key: key);

  @override
  _CreditCardPageState createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  String cardNumber = '';
  String expiryDate= '';
  String cardHolderName = '';
  String cvvCode= '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 30,bottom: 10,right:5,),
        height: 60.0,
        width: 60.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.blueAccent,
            hoverColor: Colors.blue,
            elevation: 20.0,
            onPressed: () {
              // if(formKey.currentState!.validate()){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Card_OTP(service: widget.service, allServices: widget.allServices, gender: widget.gender, frequency: widget.frequency, price: widget.price, additionalPrice: widget.additionalPrice, year: widget.year, month: widget.month, day: widget.day, hour: widget.hour , repeat: widget.repeat, employeeKey: widget.employeeKey.toString())),);
              // }
              // else{
              //   print('inValid');
              // }
            },
            child:Center(
              child: Icon(
                Icons.arrow_forward_ios_outlined,
              ),
            ),
          ),

        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 7),
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 7),
              child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.blueAccent,),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 24.0, right: 20.0, left: 20.0, bottom: 10),
              child: Text(
                'Enter Card Details',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true,
              cardBgColor : Colors.blueAccent,
            ),
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CreditCardForm(
                        cardNumber: cardNumber,
                        expiryDate: expiryDate,
                        cardHolderName: cardHolderName,
                        cvvCode: cvvCode,
                        onCreditCardModelChange: onCreditCardModelChange,
                        themeColor: Colors.blue,
                        formKey: formKey,
                        cardNumberDecoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Number',
                            hintText: 'xxxx xxxx xxxx xxxx'
                        ),
                        expiryDateDecoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Expired Date',
                            hintText: 'xx/xx'
                        ),
                        cvvCodeDecoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'CVV',
                            hintText: 'xxx'
                        ),
                        cardHolderDecoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Card Holder',
                        ),
                      ),
                      SizedBox(height:10),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel){
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}