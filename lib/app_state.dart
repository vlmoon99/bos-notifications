import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  int _latestBlockHeight = 0;
  int get latestBlockHeight => _latestBlockHeight;
  set latestBlockHeight(int _value) {
    _latestBlockHeight = _value;
  }

  List<String> _subscriptions = [];
  List<String> get subscriptions => _subscriptions;
  set subscriptions(List<String> _value) {
    _subscriptions = _value;
  }

  void addToSubscriptions(String _value) {
    _subscriptions.add(_value);
  }

  void removeFromSubscriptions(String _value) {
    _subscriptions.remove(_value);
  }

  void removeAtIndexFromSubscriptions(int _index) {
    _subscriptions.removeAt(_index);
  }

  void updateSubscriptionsAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _subscriptions[_index] = updateFn(_subscriptions[_index]);
  }

  void insertAtIndexInSubscriptions(int _index, String _value) {
    _subscriptions.insert(_index, _value);
  }

  bool _tapButton = false;
  bool get tapButton => _tapButton;
  set tapButton(bool _value) {
    _tapButton = _value;
  }

  List<String> _filterData = ['', ''];
  List<String> get filterData => _filterData;
  set filterData(List<String> _value) {
    _filterData = _value;
  }

  void addToFilterData(String _value) {
    _filterData.add(_value);
  }

  void removeFromFilterData(String _value) {
    _filterData.remove(_value);
  }

  void removeAtIndexFromFilterData(int _index) {
    _filterData.removeAt(_index);
  }

  void updateFilterDataAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _filterData[_index] = updateFn(_filterData[_index]);
  }

  void insertAtIndexInFilterData(int _index, String _value) {
    _filterData.insert(_index, _value);
  }

  int _image = 0;
  int get image => _image;
  set image(int _value) {
    _image = _value;
  }

  int _userfound = 0;
  int get userfound => _userfound;
  set userfound(int _value) {
    _userfound = _value;
  }

  String _searchAccount = '';
  String get searchAccount => _searchAccount;
  set searchAccount(String _value) {
    _searchAccount = _value;
  }

  List<String> _accountDeletingNames = [];
  List<String> get accountDeletingNames => _accountDeletingNames;
  set accountDeletingNames(List<String> _value) {
    _accountDeletingNames = _value;
  }

  void addToAccountDeletingNames(String _value) {
    _accountDeletingNames.add(_value);
  }

  void removeFromAccountDeletingNames(String _value) {
    _accountDeletingNames.remove(_value);
  }

  void removeAtIndexFromAccountDeletingNames(int _index) {
    _accountDeletingNames.removeAt(_index);
  }

  void updateAccountDeletingNamesAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _accountDeletingNames[_index] = updateFn(_accountDeletingNames[_index]);
  }

  void insertAtIndexInAccountDeletingNames(int _index, String _value) {
    _accountDeletingNames.insert(_index, _value);
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
