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
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    timer = TimerModel(
      viewTested: "circle_grid",
      testNumber: widget.timers.length,
    );
    timer.setStartTime(widget.start);
  }

  // Define the list of colors
  final List<Color> circleColors = [
    Colors.blue,
    Colors.brown,
    Colors.cyan,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.yellow,
  ];

  // Get a random color from the list
  Color getRandomColor() {
    return circleColors[_random.nextInt(circleColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;
    // Calculate the aspect ratio: width for 50 circles vs height for 100 circles
    final childAspectRatio = screenSize.width / screenSize.height * (100 / 50);

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
        body: LayoutBuilder(
          builder: (context, constraints) {
            // Get screen width and height
            double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;

            // Calculate the aspect ratio to fit 50 columns and 100 rows
            double circleAspectRatio = screenWidth / screenHeight * (100 / 50);

            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(), // Disable scrolling
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 50, // 50 circles per row
                childAspectRatio: circleAspectRatio, // Aspect ratio to fit all circles
              ),
              itemCount: 5000, // Total of 50 x 100 circles
              itemBuilder: (context, index) {
                bool isFilled = index < 3500; // First 3500 are filled
                Color randomColor = getRandomColor();

                // Wrap each circle in Transform.rotate to rotate it 45 degrees (pi/4 radians)
                return Transform.rotate(
                  angle: pi / 4, // Rotate each circle by 45 degrees
                  child: Container(
                    margin: const EdgeInsets.all(1),
                    child: CircleAvatar(
                      backgroundColor:
                          isFilled ? randomColor : Colors.transparent,
                      child: isFilled
                          ? null
                          : Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: randomColor, width: 2),
                              ),
                            ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
