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

  List<String> _accountDeleted = [];
  List<String> get accountDeleted => _accountDeleted;
  set accountDeleted(List<String> _value) {
    _accountDeleted = _value;
  }

  void addToAccountDeleted(String _value) {
    _accountDeleted.add(_value);
  }

  void removeFromAccountDeleted(String _value) {
    _accountDeleted.remove(_value);
  }

  void removeAtIndexFromAccountDeleted(int _index) {
    _accountDeleted.removeAt(_index);
  }

  void updateAccountDeletedAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _accountDeleted[_index] = updateFn(_accountDeleted[_index]);
  }

  void insertAtIndexInAccountDeleted(int _index, String _value) {
    _accountDeleted.insert(_index, _value);
  }

  List<String> _accountSelected = [];
  List<String> get accountSelected => _accountSelected;
  set accountSelected(List<String> _value) {
    _accountSelected = _value;
  }

  void addToAccountSelected(String _value) {
    _accountSelected.add(_value);
  }

  void removeFromAccountSelected(String _value) {
    _accountSelected.remove(_value);
  }

  void removeAtIndexFromAccountSelected(int _index) {
    _accountSelected.removeAt(_index);
  }

  void updateAccountSelectedAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _accountSelected[_index] = updateFn(_accountSelected[_index]);
  }

  void insertAtIndexInAccountSelected(int _index, String _value) {
    _accountSelected.insert(_index, _value);
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
