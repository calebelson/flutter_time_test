import 'package:flutter_time_test/resources/exports.dart';

class FlutterTests extends StatefulWidget {
  final List<TimerModel> timers;
  final DateTime start;

  const FlutterTests({super.key, required this.timers, required this.start});

  @override
  State<FlutterTests> createState() => _FlutterTestsState();
}

class _FlutterTestsState extends State<FlutterTests> {
  late TimerModel timer;

  @override
  void initState() {
    super.initState();
    timer = TimerModel(
      viewTested: "FlutterTestView",
      testNumber: widget.timers.length,
    );
    timer.setStartTime(widget.start);
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
        key: const Key('widget_key'),
        onVisibilityChanged: (visibilityInfo) {
          num visiblePercentage = visibilityInfo.visibleFraction * 100;
          if (visiblePercentage == 100) {
            timer.stopTimer();
            widget.timers.add(timer);
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Flutter Tests"),
          ),
          body: const Center(
            child: Text("Flutter tests"),
          ),
        ));
  }
}
