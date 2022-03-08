import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_flutter_app/custom_stepper_class.dart' as CustomStepper;

class SampleStepperPage extends StatefulWidget {
  @override
  SampleStepperPageState createState() => SampleStepperPageState();
}

class SampleStepperPageState extends State<SampleStepperPage> {


  bool isLoading = true ;

  TextEditingController mailController = TextEditingController();
  TextEditingController passController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KindaCode.com'),
      ),
      body: Column(
        children: [

          Expanded(
            child: Theme(
              data: ThemeData(
                  accentColor: Colors.orange,
                  primarySwatch: Colors.orange,
                  colorScheme: ColorScheme.light(
                      primary: Colors.orange
                  )
              ),
              child: CustomStepper.CustomStepper(
                type: CustomStepper.StepperType.horizontal,
                physics: ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue:  continued,
                onStepCancel: cancel,
               steps: <CustomStepper.Step>[
                 CustomStepper.Step(
                  //  title: Container(),
                    content: Column(
                      children: <Widget>[
                        TextField(
                          controller : mailController,
                          decoration: InputDecoration(labelText: 'Mail ID'),
                        ),
                        TextField(
                          controller: passController,
                          decoration: InputDecoration(labelText: 'Password'),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0 ?
                    CustomStepper.StepState.complete : StepState.disabled,
                  ),

                  // Step(
                  //   title: new Text('OTHER DETAILS'),
                  //   content: Column(
                  //     children: <Widget>[
                  //       TextFormField(
                  //         decoration: InputDecoration(labelText: 'Home Address'),
                  //       ),
                  //       TextFormField(
                  //         decoration: InputDecoration(labelText: 'Postcode'),
                  //       ),
                  //     ],
                  //   ),
                  //   isActive: _currentStep >= 0,
                  //   state: _currentStep >= 1 ?
                  //   StepState.complete : StepState.disabled,
                  // ),
                ],

                controlsBuilder: (BuildContext context ,
                    {VoidCallback onStepContinue, VoidCallback onStepCancel}){

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: [
                      GestureDetector(
                        onTap: continued ,
                        child: Container(
                          width : MediaQuery.of(context).size.width,
                            height: 40,
                            child: Center(child: Text('SAVE')),
                          color: Colors.pink,
                        ),
                      ),

                      SizedBox(height:25),
                      GestureDetector(
                        onTap: cancel,
                        child: Container(
                          width : MediaQuery.of(context).size.width,
                          height: 40,
                          child: Center(child: Text('CANCEL')),
                          color: Colors.green,
                        ),
                      ),
                    ]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  tapped(int step){
    print("sttt ${step}");
    setState(() => _currentStep = step);
  }

  continued(){
    print("_currentStep ${_currentStep}");
    if(_currentStep == 0){
      if(mailController.text == ''|| mailController.text == null || mailController.text == 'null'){
        print('mail error');
      }
      else   if(passController.text == ''|| passController.text == null || passController.text == 'null'){
        print('password error');
      }
      else{
        _currentStep < 1 ?
        setState(() => _currentStep += 1): null;
      }
    }

  }
  cancel(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }

}
