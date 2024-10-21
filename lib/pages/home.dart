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
    late Widget viewToPush;
    switch (timers.length) {
      case <= 1:
        viewToPush = CircleGrid(
          timers: timers,
          start: DateTime.now(),
        );
      case > 1 && <= 3:
        viewToPush = SquareGrid(
          timers: timers,
          start: DateTime.now(),
        );
      case > 3 && <= 5:
        viewToPush = FlutterTests(
          timers: timers,
          start: DateTime.now(),
        );
      default:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SendData(
              timers: timers,
            ),
          ),
        );
        return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => viewToPush))
        .then(
      (_) async {
        // Views being pushed before fully popped
        await Future.delayed(const Duration(seconds: 1));
        pushView();
      },
    );
  }
}
