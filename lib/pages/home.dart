import 'package:flutter_time_test/resources/exports.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TimerModel> timers = [];
  bool startTestsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: startTestsEnabled ? () => pushView() : null,
              child: const Text("Start Tests"),
            ),
          ],
        ),
      ),
    );
  }

  void pushView() async {
    setState(() {
      startTestsEnabled = false;
    });
    if (timers.isEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CircleGrid(
            timers: timers,
            start: DateTime.now(),
          ),
        ),
      ).then((_) async {
        // Views being pushed before fully popped
        await Future.delayed(const Duration(seconds: 1));
        pushView();
      });
    } else if (timers.length <= 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CircleGrid(
            timers: timers,
            start: DateTime.now(),
          ),
        ),
      ).then((_) async {
        // Views being pushed before fully popped
        await Future.delayed(const Duration(seconds: 1));
        pushView();
      });
    } else if (timers.length <= 5) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FlutterTests(
            timers: timers,
            start: DateTime.now(),
          ),
        ),
      ).then((_) async {
        // Views being pushed before fully popped
        await Future.delayed(const Duration(seconds: 1));
        pushView();
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SendData(
            timers: timers,
          ),
        ),
      );
    }
  }
}
