import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 10;
  int totalSeconds = twentyFiveMinutes;
  bool isRunning = false;
  int totalPomodoros = 0;
  late Timer timer;

  void ontick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), ontick);
    isRunning = true;
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onStopPressed() {
    timer.cancel();
    setState(() {
      totalSeconds = twentyFiveMinutes;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);

    return duration.toString().split(".")[0].substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(children: [
        Flexible(
          flex: 3,
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              format(totalSeconds),
              style: TextStyle(
                color: Theme.of(context).cardColor,
                fontSize: 89,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        Flexible(
          flex: 5,
          child: Column(
            children: [
              Center(
                child: IconButton(
                  iconSize: 120,
                  color: Theme.of(context).cardColor,
                  onPressed: isRunning ? onPausePressed : onStartPressed,
                  icon: Icon(isRunning
                      ? Icons.pause_circle_filled_outlined
                      : Icons.play_circle_fill_outlined),
                ),
              ),
              Center(
                child: IconButton(
                  iconSize: 60,
                  color: Theme.of(context).cardColor,
                  onPressed: onStopPressed,
                  icon: const Icon(Icons.stop_circle_outlined),
                ),
              ),
            ],
          ),
        ),
        Flexible(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(30))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Pomodors',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '$totalPomodoros',
                            style: const TextStyle(
                              fontSize: 40,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            )),
      ]),
    );
  }
}
