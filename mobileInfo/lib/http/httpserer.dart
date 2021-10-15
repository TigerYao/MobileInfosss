import 'dart:convert';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'dart:async';

String serviceUrl = 'https://hooks.slack.com/services/';

Future requestDataForm(String address, var data,
    {Function? success,
      Function? fail,
      Function? onError,
      Function? complete,
      Function? onSendProgress,
      String method = 'post'}) async {
  try {
    // ProgressHUD.showProgress();
    Dio dio = new Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client){
      client.badCertificateCallback=(cert, host, port){
        return true;
      };
    };
    print('参数=》：${data.toString()}');
    print('请求=》：$address');
    Response response;
    if (method != null && method == 'get') {
      response = await dio.get(serviceUrl + address, queryParameters: data);
    }  else {
      response = await dio.post(serviceUrl + address, data: data);
    }
    // response.headers.add('Access-Control-Allow-Origin', '*');
    print('$address请求结果=>：${response.toString()}...${response.statusCode}');
    if (response.statusCode == 200) {
      var result = json.decode(response.toString());
      if (result['rst'] == 'ok') {
        if (success != null) success(result['data']);
      } else {
        if(onError != null){
          onError("");
        } else if (fail != null) {
          fail("");
        } else
          throw Exception(result);
      }
      return result['rst'] == "ok" ? result['data'] : getErrorMsg(result);
    } else {
      throw Exception('请求失败，稍后重试');
    }
  } catch (e) {
    // Fluttertoast.showToast(msg: e?.toString()??"接口错误");
    if (fail != null) fail("请求超时，稍后再试");
    print('Error =========> $e');
  } finally {
    if (complete != null) complete();
    // ProgressHUD.dismiss();
  }
}

const Map errors = {
  0: "Success",
  401: "拒绝请求",
  402: "没有处理权限",
  403: "没有可用数据",
  405: "第三方接口错误",
  406: "写入数据库失败",
  407: "配置有误",
  408: "第三方平台返回空数据",
  3001: "账号不存在",
  3002: "用户ID无效",
  3003: "手机号码已存在",
  3004: "密码错误",
  3005: "确认密码不一致",
  3006: "用户注册失败",
  3007: "账户已注册",
  3008: "登录过期",
  3009: "二维码过期",
  4001: "APP应用不存在",
  4002: "项目不存在",
  4003: "项目已下架",
  4102: "商品库存不足",
  4103: "余额不足",
  4201: "支付密码错误",
  4202: "支付密码修改失败",
  4203: "支付平台网关错误",
  4204: "支付平台返回空数据",
  4205: "签名错误",
  4206: "订单重复",
  4207: "订单不存在或超时",
  4208: "订单不存在",
  9001: "私钥无效",
  9002: "公钥钥无效",
  9003: "jwt算法无效",
  9005: "配置不存在",
  9006: "文件不存在",
  9007: "文件大于10mb",
  9010: "验证码错误",
  9011: "验证码无效",
  9012: "验证码已使用",
  9013: "短信平台余额不足",
  9014: "短信发送频率24小时10次",
  9015: "反馈信息每分钟一次"
};

String getErrorMsg(Map result) {
  try {
    int code = result['code'];
    if (errors.containsKey(code))
      return code == 4103 ? {code: errors[code]}.toString() : errors[code];
    return result['msg'];
  } catch (e) {
    return "发生错误，稍后重试";
  }
}
