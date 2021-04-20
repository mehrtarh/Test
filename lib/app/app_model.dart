import 'package:flutter/cupertino.dart';
import 'package:job/api/api_provider.dart';
import 'package:job/pref/pref_provider.dart';
import 'package:job/store/store_provider.dart';
import 'package:job/store/store_provider_abstarct.dart';

abstract class AppModel extends ChangeNotifier {

  ApiProviderAbstract get apiProvider;
  PrefProviderAbstract get prefProvider;
  StoreProviderAbstract get storeProvider;
}

class AppModelImplementation extends AppModel {
  ApiProviderAbstract _apiProvider;
  PrefProviderAbstract _prefProvider;
  StoreProviderAbstract _storeProvider;

  AppModelImplementation() {
    _prefProvider = PrefProvider();
    _apiProvider = ApiProviderI();
    _storeProvider = StoreProvider();

  }

  @override
  ApiProviderAbstract get apiProvider => _apiProvider;

  @override
  PrefProviderAbstract get prefProvider => _prefProvider;

  @override
  StoreProviderAbstract get storeProvider => _storeProvider;



}
