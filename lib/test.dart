import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final inputController = TextEditingController();
  var button_text_list = [
    "", "C", "<-", "%",
    "7", "8", "9", "X",
    "4", "5", "6", "-",
    "1", "2", "3", "+",
    "", "0", ".", "=",
  ];
  var operator = "";
  var input_1 = "";
  // LinearGradient(
  // colors: [color1, color2],
  // // colors: [Color(0xFF3fd89f), Color(0xFF3eb9b4)],
  // begin: FractionalOffset(0.0, 0.0),
  // end: FractionalOffset(1.0, 1.0),
  // stops: [0.3, 1.0],
  // tileMode: TileMode.clamp)
  void button_clicked(button_text) {
    if (["+", "-", "X", "%"].contains(button_text)) {
      operator = button_text;
      input_1 = inputController.text;
      inputController.text = "";
    } else if (button_text == "C"){
      inputController.text = "";
      operator = "";
    } else if (button_text == "<-"){
      inputController.text = inputController.text.substring(0, inputController.text.length - 1);
    } else if (button_text == "="){
      var result = 0.0;
      if (operator == "+") {
        result = double.parse(input_1) + double.parse(inputController.text);
      } else if (operator == "-") {
        result = double.parse(input_1) - double.parse(inputController.text);
      } else if (operator == "X") {
        result = double.parse(input_1) * double.parse(inputController.text);
      } else if (operator == "%") {
        result = double.parse(input_1) / double.parse(inputController.text);
      }
      inputController.text = result.toString();
    } else if (button_text == ""){

    } else {
      inputController.text = inputController.text + button_text;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double device__width = MediaQuery.of(context).size.width;
    double device_height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: inputController,
                readOnly: true,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan, width: 2,),),
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan, width: 2,),),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan, width: 2,),),
                ),
                style: const TextStyle(fontSize: 20),
              ),
              SizedBox(
                  height: device_height * 0.6,
                  child: GridView.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 4,
                    childAspectRatio: 1.8,
                    children: List.generate(button_text_list.length, (index) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Colors.cyan, Colors.greenAccent],
                              begin: FractionalOffset(0.4, 0.0),
                              end: FractionalOffset(1.0, 1.5),
                              stops: [0.0, 0.8],
                              tileMode: TileMode.clamp
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            button_clicked(button_text_list[index]);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          child: Text(
                            button_text_list[index],
                            style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400),
                          ),
                        ),
                      );
                    }),
                  )
              )
            ],
          )
      ),
    );
  }
}