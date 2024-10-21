class TimerModel {
  DateTime? initTime;
  DateTime? viewLoadedTime;
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

  void viewLoadedTimer() {
    viewLoadedTime = DateTime.now();
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

  Duration getTimeToLoad() {
    if (initTime != null && viewLoadedTime != null) {
      return viewLoadedTime!.difference(initTime!);
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