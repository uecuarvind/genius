import 'package:genius_bank/app_helper/api_client.dart';
import 'package:genius_bank/config/dependency.dart';
import 'package:genius_bank/data/currencies.dart';
import 'package:genius_bank/utils/url.dart';

class SplashRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }

  Future getAppCurrencies({required Function(Currencies) onSuccess,required Function(Map<String,dynamic>) onError,bool enableShowError = true}) async {
    await apiClient.Request(
      url: URL.currencies,
      withAuth: false,
      enableShowError: enableShowError,
      onSuccess: (Map<String,dynamic> data) {
        Currencies currencies = Currencies.fromJson(data);
        instance.registerSingleton<Currencies>(currencies);
        for(int i=0; i<currencies.data!.length; i++){
          if(currencies.data![i].isDefault=='1'){
            instance.registerSingleton<CurrencyData>(currencies.data![i]);
            break;
          }
        }
        onSuccess(currencies);
      },
      onError: onError
    );
  }
}