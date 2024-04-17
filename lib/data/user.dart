import 'package:genius_bank/data/currencies.dart';

import '../config/dependency.dart';

class User {
  User({
      this.id,
      this.fullName,
      this.phone,
      this.email,
      this.fax,
      this.propic,
      this.zipCode,
      this.city,
      this.country,
      this.address,
      this.balance,
      this.emailVerified,
      this.affilateCode,
      this.affilateLink,
      this.ban,
      this.kycStatus,
      this.kycInfo,
      this.currencyId,
      this.twofa,
      this.otpSubmit,
      this.setupKey
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['full_name'];
    phone = json['phone'];
    email = json['email'];
    fax = json['fax'];
    propic = json['propic'];
    zipCode = json['zip_code'];
    city = json['city'];
    country = json['country'];
    address = json['address'];
    balance = json['balance'];
    emailVerified = json['email_verified'];
    affilateCode = json['affilate_code'];
    affilateLink = json['affilate_link'];
    ban = json['ban'];
    kycStatus = json['kyc_status'] ?? '0';
    kycInfo = json['kyc_info'];
    currencyId = json['currency_id'].toString();
    twofa = json['twofa'];
    setupKey = json['setup_key'];
    otpSubmit = json['otp_submit'];
    try{
      Currencies? curr = Currencies.getCurrencies();
      for(int i=0; i<curr!.data!.length; i++){
        if(curr.data![i].id!.toString() == currencyId){
          instance.registerSingleton<CurrencyData>(curr.data![i]);
          break;
        }
      }
    } catch(e){}
  }
  num? id;
  String? fullName;
  String? phone;
  String? email;
  String? fax;
  String? propic;
  String? zipCode;
  String? city;
  dynamic country;
  String? address;
  String? balance;
  String? emailVerified;
  String? affilateCode;
  String? affilateLink;
  String? ban;
  String? kycStatus;
  dynamic kycInfo;
  String? currencyId;
  String? twofa;
  String? setupKey;
  String? otpSubmit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['full_name'] = fullName;
    map['phone'] = phone;
    map['email'] = email;
    map['fax'] = fax;
    map['propic'] = propic;
    map['zip_code'] = zipCode;
    map['city'] = city;
    map['country'] = country;
    map['address'] = address;
    map['balance'] = balance;
    map['email_verified'] = emailVerified;
    map['affilate_code'] = affilateCode;
    map['affilate_link'] = affilateLink;
    map['ban'] = ban;
    map['kyc_status'] = kycStatus;
    map['kyc_info'] = kycInfo;
    map['currency_id'] = currencyId;
    map['twofa'] = twofa;
    map['setup_key'] = setupKey;
    map['otp_submit'] = otpSubmit;
    return map;
  }

  Map<String, String> toJsonForUpdate() {
    final map = <String, String>{};
    map['name'] = fullName!;
    map['phone'] = phone!;
    map['fax'] = fax!;
    map['zip'] = zipCode!;
    map['city'] = city!;
    map['address'] = address!;
    map['currency_id'] = currencyId!;
    return map;
  }

}