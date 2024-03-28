
import 'package:smartpay/src/core/api_client.dart';
import 'package:smartpay/src/core/endpoints.dart';
import 'package:smartpay/src/core/request_res.dart';

class DashboardRepository extends ApiClient {
  Future<RequestRes> dashboard() async {
    try {
      final response = await get(Endpoints.home).then((value) => value['data']['secret']);

      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> logout() async {
    try {
      final response = await post(Endpoints.logout, data: {}).then((value) => value['message']);
      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }
}
