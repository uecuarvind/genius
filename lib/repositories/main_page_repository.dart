import 'package:genius_bank/app_helper/api_client.dart';
import 'package:genius_bank/module/main_page/data/dashboard.dart';
import 'package:genius_bank/utils/url.dart';

class MainPageRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getDashboardData({required Function(Dashboard) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
      url: URL.dashboard,
      onSuccess: (Map<String,dynamic> data) {
        Dashboard dashboard = Dashboard.fromJson(data);
        onSuccess(dashboard);
      },
      onError: onError
    );
  }
}