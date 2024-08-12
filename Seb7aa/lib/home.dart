// home.dart
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class hasana extends StatefulWidget {
  const hasana({super.key});

  @override
  State<hasana> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<hasana> {
  resetToZero({bool resetGoal = false}) {
    setCount(counter = 0);
    setTimes(times = 0);
    resetGoal == true ? setgoal(goal = 0) : null;
  }

  setCount(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter', value);
    getCount();
  }

  setTimes(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('times', value);
    getCount();
  }

  setColor(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('color', value);
    getCount();
  }

  setgoal(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('goal', value);
    getCount();
  }

  getCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt('counter') ?? 0;
      times = prefs.getInt('time') ?? 0;
      goal = prefs.getInt('goal') ?? 0;
      colorHex = prefs.getInt('color') ?? 0xff81001c;
    });
  }

  @override
  void iniState() {
    getCount();
    super.initState();
  }

  TextDirection textDirection = TextDirection.rtl;
  int rad = 0;
  int colorHex = 0xff81001c;
  int counter = 0;
  int goal = 0;
  int times = 0;
  bool isActive = false;
  Widget build(BuildContext context) {
    Color mainColor = Color(colorHex);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            resetToZero(resetGoal: true);
          },
          child: Icon(Icons.refresh),
          backgroundColor: mainColor,
        ),
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isActive = !isActive;
                    });
                  },
                  child: Icon(
                    isActive ? Icons.color_lens_outlined : Icons.color_lens,
                    color: Colors.white,
                  )),
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(color: mainColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Text("الهدف",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            resetToZero();
                            setgoal(goal - 1);
                          },
                          icon: Icon(
                            Icons.remove_circle,
                            color: Colors.white,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("$goal",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                            )),
                      ),
                      IconButton(
                          onPressed: () {
                            resetToZero();
                            setgoal(goal + 1);
                          },
                          icon: Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          resetToZero();
                          setgoal(goal + 33);
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: Text("33"),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          resetToZero();
                          setgoal(goal + 100);
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: Text("100"),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          resetToZero();
                          setgoal(goal + 100);
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: Text("+100"),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          resetToZero();
                          setgoal(goal + 1000);
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: Text("+1000"),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              children: [
                Text('الأستغفار',
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 28,
                    )),
                SizedBox(
                  height: 20,
                ),
                Text("$counter",
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 28,
                    )),
                SizedBox(
                  height: 20,
                ),
                CircularPercentIndicator(
                  radius: 80.0,
                  lineWidth: 5.0,
                  percent: counter / goal,
                  center: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (counter >= goal) {
                          setTimes(times + 1);
                          setCount(counter = 0);
                        } else {
                          setCount(counter + 1);
                        }
                      });
                    },
                    child: Icon(
                      Icons.touch_app,
                      size: 50.0,
                      color: mainColor,
                    ),
                  ),
                  backgroundColor: mainColor.withOpacity(0.5),
                  progressColor: mainColor,
                ),
                Text('مرات التكرار : ${counter}',
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 28,
                    )),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            Spacer(),
            Padding(padding: const EdgeInsets.all(8.5)),
            Visibility(
              visible: isActive,
              child: Row(
                children: [
                  Radio(
                      fillColor: WidgetStateColor.resolveWith(
                          (State) => Color(0xff81001c)),
                      value: 0xff81001c,
                      groupValue: colorHex,
                      onChanged: (val) {
                        setState(() {
                          setColor(val!);
                        });
                      }),
                  Radio(
                      fillColor: WidgetStateColor.resolveWith(
                          (State) => Color(0xff14212A)),
                      value: 0xff14212A,
                      groupValue: colorHex,
                      onChanged: (val) {
                        setState(() {
                          setColor(val!);
                        });
                      }),
                  Radio(
                      fillColor: WidgetStateColor.resolveWith(
                          (State) => Color(0xff62249F)),
                      value: 0xff62249F,
                      groupValue: colorHex,
                      onChanged: (val) {
                        setState(() {
                          setColor(val!);
                        });
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
