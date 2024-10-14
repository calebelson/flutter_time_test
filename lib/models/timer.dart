class TimerModel {
  DateTime? initTime;
  DateTime? finishTime;
  final String viewTested;
  final int testNumber;

  TimerModel({required this.viewTested, required this.testNumber});

  void setStartTime(DateTime date) {
    initTime = date;
  }

  void startTimer() {
    initTime = DateTime.now();
  }

  void stopTimer() {
    finishTime = DateTime.now();
  }

  Duration getDuration() {
    if (initTime != null && finishTime != null) {
      return finishTime!.difference(initTime!);
    }
    return Duration.zero;
  }

  String getNameAndTestNumber() {
    return '${viewTested}_$testNumber';
  }

  DateTime getStartTime() {
    return initTime ?? DateTime.now();
  }

  DateTime getEndTime() {
    return finishTime ?? DateTime.now();
  }
}