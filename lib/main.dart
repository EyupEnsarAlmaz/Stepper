import 'package:flutter/material.dart';
import 'package:textfield2/newpage.dart';

// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names, non_constant_identifier_names, prefer_const_literals_to_create_immutables, unnecessary_new, sized_box_for_whitespace
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StepperOrnek(),
      ),
    );
  }
}

class StepperOrnek extends StatefulWidget {
  const StepperOrnek({Key? key}) : super(key: key);

  @override
  State<StepperOrnek> createState() => _StepperOrnekState();
}

class _StepperOrnekState extends State<StepperOrnek> {
  int aktifStep = 0;
  String isim = "";
  String mail = "";
  String sifre = "";
  List<Step>? tumstepler;
  var key0 = GlobalKey<FormFieldState>();
  var key1 = GlobalKey<FormFieldState>();
  var key2 = GlobalKey<FormFieldState>();
  bool hata = false;
  bool iscompleted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumstepler = _tumStepler();
  }

  @override
  Widget build(BuildContext context) {
    tumstepler = _tumStepler();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Stepper"),
        ),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        steps: tumstepler!,
        currentStep: aktifStep,
        onStepContinue: () {
          setState(() {
            _ileributonukontrolu();
          });
        },
        onStepCancel: () {
          if (aktifStep > 0) {
            setState(() {
              aktifStep--;
            });
          } else {
            aktifStep = 0;
          }
        },
      ),
    );
  }

  _tumStepler() {
    List<Step> stepler = [
      Step(
        title: Text("Username"),
        state: _stateleriayarla(0),
        isActive: true,
        content: TextFormField(
          key: key0,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              labelText: "Username",
              hintText: "Username",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)))),
          validator: (girilendeger) {
            if (girilendeger!.length < 6) {
              return "En az 6 karakter giriniz";
            }
          },
          onSaved: (girilendeger) {
            isim = girilendeger!;
          },
        ),
      ),
      Step(
        title: Text("Mail"),
        state: _stateleriayarla(1),
        isActive: true,
        content: TextFormField(
          key: key1,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.mail),
              labelText: "Mail",
              hintText: "Mail",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)))),
          validator: (girilendeger) {
            if (girilendeger!.length < 6 || !girilendeger.contains("@")) {
              return "Geçerli bir mail adresi giriniz";
            }
          },
          onSaved: (girilendeger) {
            mail = girilendeger!;
          },
        ),
      ),
      Step(
        title: Text("Password"),
        state: _stateleriayarla(2),
        isActive: true,
        content: TextFormField(
          obscureText: true,
          key: key2,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.vpn_key),
              labelText: "Password",
              hintText: "Password",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)))),
          validator: (girilendeger) {
            if (girilendeger!.length < 6) {
              return "Şifre En az 6 karakter olmalıdır";
            }
          },
          onSaved: (girilendeger) {
            sifre = girilendeger!;
          },
        ),
      ),
    ];
    return stepler;
  }

  StepState _stateleriayarla(int oankistep) {
    if (aktifStep == oankistep) {
      if (hata) {
        return StepState.error;
      } else {
        return StepState.editing;
      }
    } else
      return StepState.complete;
  }

  void _ileributonukontrolu() {
    switch (aktifStep) {
      case 0:
        if (key0.currentState!.validate()) {
          key0.currentState!.save();
          hata = false;
          aktifStep = 1;
        } else {
          hata = true;
        }
        break;
      case 1:
        if (key1.currentState!.validate()) {
          key1.currentState!.save();
          hata = false;
          aktifStep = 2;
        } else {
          hata = true;
        }
        break;
      case 2:
        if (key2.currentState!.validate()) {
          key2.currentState!.save();
          hata = false;
          aktifStep = 2;
          iscompleted = true;
          if (iscompleted == true) {
            aktifStep = 0;
            key0.currentState!.reset();
            key1.currentState!.reset();
            key2.currentState!.reset();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Bilgiler(
                      name: isim,
                      email: mail,
                      sifre: sifre,
                      aktifolanstep: aktifStep,
                    )));
          }
          break;
        } else {
          hata = true;
        }
        break;
    }
  }
}
