import 'package:lamie_middle_east_machine_task/network/api_service/api_service.dart';
import 'package:lamie_middle_east_machine_task/util/app_url/app_url.dart';
import 'package:lamie_middle_east_machine_task/util/typedef/type_def.dart';

class AuthenticationRepo {
  EitherResponse loginUserFnc(Map map) async => Api.postApi(Urls.loginUrl, map);

  EitherResponse signupFnc(Map map) async => Api.postApi(Urls.signupUrl, map);

  EitherResponse passLoginDetailsToAppiFnc(Map map) async =>
      Api.postApi(Urls.googleLoginUrl, map);
}
