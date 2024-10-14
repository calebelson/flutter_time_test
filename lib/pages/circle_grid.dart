import 'package:flutter_time_test/resources/exports.dart';

class CircleGrid extends StatefulWidget {
  const CircleGrid({super.key, required this.timers, required this.start});
  final List<TimerModel> timers;
  final DateTime start;

  @override
  State<CircleGrid> createState() => _CircleGridState();
}

class _CircleGridState extends State<CircleGrid> {
  late TimerModel timer;

  @override
  void initState() {
    super.initState();
    timer = TimerModel(
      viewTested: "circle_grid",
      testNumber: widget.timers.length,
    );
    timer.setStartTime(widget.start);
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
        key: const Key('circle_key'),
        onVisibilityChanged: (visibilityInfo) {
          num visiblePercentage = visibilityInfo.visibleFraction * 100;
          if (visiblePercentage == 100) {
            timer.stopTimer();
            widget.timers.add(timer);
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('Circle Grid')),
          body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 50, // 50 circles per row
              childAspectRatio: 1, // Maintain a square aspect ratio
            ),
            itemCount: 5000, // Total of 50 x 100 circles
            itemBuilder: (context, index) {
              bool isFilled = index < 420; // First 420 are filled
              return Container(
                margin: const EdgeInsets.all(2),
                child: CircleAvatar(
                  backgroundColor: isFilled ? Colors.blue : Colors.transparent,
                  child: isFilled
                      ? null
                      : Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blue, width: 2),
                          ),
                        ),
                ),
              );
            },
          ),
        ));
  }
}
