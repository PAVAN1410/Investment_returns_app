import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Intrest calculation",
      home: SIForm(),
      theme: ThemeData(
          primaryColor: Colors.yellow,
          accentColor: Colors.deepOrange,
          brightness: Brightness.dark
          //scaffoldBackgroundColor: Colors.black
          ),
    ),
  );
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SIFormState();
  }
}

class SIFormState extends State<SIForm> {
  var formKey = GlobalKey<FormState>();
  final min_padding = 5.0;
  final min_margin = 5.0;

  var currencies = ["Rupees", "Dollors", "Pounds", "Others"];
  var currentItemSelected = '';

  @override
  void initState() {
    super.initState();
    currentItemSelected = currencies[0];
  }

  String display = '';
  TextEditingController principalController = TextEditingController();
  TextEditingController roicontroller = TextEditingController();
  TextEditingController termcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'Simple interst calculation',
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
            padding: EdgeInsets.all(min_padding * 2),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                    padding: EdgeInsets.all(min_padding * 2),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter principal amount';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Principal',
                          hintText: 'Enter Principal e.g. 15000',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                              fontSize: 15.0, color: Colors.yellowAccent),
                          //hintStyle: Theme.of(context).textTheme.display1,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      controller: principalController,
                    )),
                Padding(
                    padding: EdgeInsets.all(min_padding * 2),
                    child: TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter ROI ';
                        }
                      },
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      decoration: InputDecoration(
                          labelText: 'Rate of intrest ',
                          hintText: 'In percentage',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                              fontSize: 15.0, color: Colors.yellowAccent),
                          // hintStyle: Theme.of(context).textTheme.display1,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      controller: roicontroller,
                    )),
                Padding(
                    padding: EdgeInsets.all(min_padding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter term ';
                            }
                          },
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          controller: termcontroller,
                          decoration: InputDecoration(
                              labelText: 'Term',
                              hintText: 'Time in intrest',
                              labelStyle: textStyle,
                              errorStyle: TextStyle(
                                  fontSize: 13.0, color: Colors.yellowAccent),
                              //hintStyle: Theme.of(context).textTheme.display1,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                        Container(width: 25.0),
                        Expanded(
                          child: DropdownButton<String>(
                              items: currencies.map((String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              value: currentItemSelected,
                              onChanged: (String newValue) {
                                onDropDownItemSelected(newValue);
                              }),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(top: min_padding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: RaisedButton(
                                color: Theme.of(context).accentColor,
                                textColor: Theme.of(context).primaryColorDark,
                                child: Text("Calculate", textScaleFactor: 1.5
                                    //style: Theme.of(context).textTheme.title,
                                    ),
                                onPressed: () {
                                  setState(() {
                                    if (formKey.currentState.validate()) {
                                      display = calculateTotalReturns();
                                    }
                                  });
                                })),
                        Expanded(
                            child: RaisedButton(
                                color: Theme.of(context).primaryColorDark,
                                textColor: Theme.of(context).primaryColorLight,
                                child: Text(
                                  "Reset", textScaleFactor: 1.5,
                                  //style: Theme.of(context).textTheme.title,
                                ),
                                onPressed: () {
                                  setState(() {
                                    reset_values();
                                  });
                                }))
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(top: min_padding),
                  child: Text(
                    display,
                    style: textStyle,
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/SIC.jpg');
    Image image = Image(image: assetImage, width: 125.0, height: 125.0);
    return Container(
      child: image,
      margin: EdgeInsets.only(top: 15.0),
    );
  }

  void onDropDownItemSelected(String newValue) {
    setState(() {
      currentItemSelected = newValue;
    });
  }

  String calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roicontroller.text);
    double term = double.parse(termcontroller.text);
    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result =
        'After $term years, your investment will worth $totalAmountPayable in $currentItemSelected';
    return result;
  }

  void reset_values() {
    principalController.text = '';
    roicontroller.text = '';
    termcontroller.text = '';
    currentItemSelected = currencies[0];
    display = '';
  }
}
