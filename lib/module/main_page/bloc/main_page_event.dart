import 'package:genius_bank/data/currencies.dart';

abstract class MainPageEvent {}

class InitEvent extends MainPageEvent {}
class GetDashboard extends MainPageEvent {}
class UpdateUser extends MainPageEvent {}
class ChangeCurrency extends MainPageEvent {
  CurrencyData data;

  ChangeCurrency(this.data);
}