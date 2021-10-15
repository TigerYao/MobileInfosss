library getmobileinfo;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';
import 'package:r_get_ip/r_get_ip.dart';
import 'http/httpserer.dart';
import 'mobile_info_entity.dart';

/// A Calculator.
class MobleInfoUtils {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
  late MobileInfoEntity _entity;
  Future<dynamic> getMobileInfoEntity()async{
    _entity = MobileInfoEntity();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid){
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      _entity.os = androidInfo.model;
    }else if(Platform.isIOS){
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      _entity.os = iosInfo.systemName;
      _entity.ios_version = iosInfo.systemVersion;
    }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _entity.app_version = packageInfo.version;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      _entity.net_type = "mobile";
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      _entity.net_type = "wifi";
    }
    _entity.ip = await RGetIp.internalIP;
    return _entity;
  }

  void updateMobileInfo(Function success,Function err)async{
     MobileInfoEntity infoEntity = await getMobileInfoEntity();
     await requestDataForm("T0296AG9SDT/B029GJCFPKQ/YPh9xGTQ9YOa7RBkXuJlh3JD", {'text':json.encode(infoEntity)},success: success,fail: err);
  }
}
