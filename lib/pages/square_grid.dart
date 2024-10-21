import 'package:flutter_time_test/resources/exports.dart';

class SquareGrid extends StatefulWidget {
  const SquareGrid({super.key, required this.timers, required this.start});
  final List<TimerModel> timers;
  final DateTime start;

  @override
  State<SquareGrid> createState() => _SquareGridState();
}

class _SquareGridState extends State<SquareGrid> {
  late TimerModel timer;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    timer = TimerModel(
      viewTested: "square_grid",
      testNumber: widget.timers.length,
    );
    timer.setStartTime(widget.start);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      timer.viewLoadedTimer();
    });
  }

  // Generates a large number of randomly colored squares
    List<Widget> generateComplexSquares(int count) {
    final random = Random();
    return List<Widget>.generate(count, (index) {
      return Container(
        // Randomize sizes for more complexity
        width: (10 + random.nextInt(20)).toDouble(),
        height: (10 + random.nextInt(20)).toDouble(),
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(
                255,
                random.nextInt(256),
                random.nextInt(256),
                random.nextInt(256),
              ),
              Color.fromARGB(
                255,
                random.nextInt(256),
                random.nextInt(256),
                random.nextInt(256),
              ),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 4.0,
              spreadRadius: 1.0,
              offset: Offset(random.nextDouble() * 4 - 2, random.nextDouble() * 4 - 2),
            )
          ],
          borderRadius: BorderRadius.circular(5),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('square_key'),
      onVisibilityChanged: (visibilityInfo) {
        num visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage == 100) {
          timer.stopTimer();
          widget.timers.add(timer);
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Square Grid')),
        body: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            children: generateComplexSquares(500000),
          ),
        ),
      ),
    );
  }
}


