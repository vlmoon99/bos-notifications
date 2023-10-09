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
