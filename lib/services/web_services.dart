import 'package:astrologeradmin/model/common_response.dart';
import 'package:astrologeradmin/services/api_path.dart';
import 'package:astrologeradmin/services/http_services.dart';

class Webservice {
  static HttpServices apiService = HttpServices();

  static Future<CommonResponse> fetchData(String endPath) async {
    CommonResponse commonResponse = CommonResponse();
    try {
      // Fetch data from API
      await apiService.get(endPath).then((onValue){
        print('API Response: $onValue'); // Debugging log
        commonResponse = CommonResponse.fromJson(onValue);
      });
    } catch (e) {
      print('Error in fetchUserData: $e');
    }
    return commonResponse;
  }



}
