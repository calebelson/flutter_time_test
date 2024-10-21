import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_time_test/resources/exports.dart';

class MetricsData {
  List<String> allData = [];

  MetricsData() {
    _getDeviceInfo().then((deviceInfo) {
      allData = [
        deviceInfo['model'] ?? 'Unknown model',
        deviceInfo['systemName'] ?? 'Unknown system',
        deviceInfo['systemVersion'] ?? 'Unknown version',
        '${DateTime.now()}'
      ];
    });
  }

  void addData(TimerModel timer) {
    allData.add('''
      ${timer.getNameAndTestNumber()}:
        start: ${timer.getStartTime()}
        viewLoaded: ${timer.viewLoadedTime}
        timerToLoad: ${timer.getTimeToLoad()}
        end: ${timer.getEndTime()}
        duration: ${timer.getDuration()}
      ''');
  }

  Future<File> writeToFile() async {
    String content = _joinAllData();
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/FlutterTimeTest.txt');
    
    return file.writeAsString(content);
  }

  Future<String> getFileName() async {
    File file = await writeToFile();
    return file.path;
  }

  String _joinAllData() {
    return allData.join('\n');
  }

  Future<Map<String, String>> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, String> deviceInfo = {};

    IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
    deviceInfo['model'] = iosInfo.utsname.machine;
    deviceInfo['systemName'] = iosInfo.systemName;
    deviceInfo['systemVersion'] = iosInfo.systemVersion;

    return deviceInfo;
  }
}
