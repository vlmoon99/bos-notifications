import 'dart:math';

import 'package:b_o_s_notifications/auth/firebase_auth/auth_util.dart';
import 'package:b_o_s_notifications/auth/firebase_auth/firebase_auth_manager.dart';
import 'package:b_o_s_notifications/backend/api_requests/api_calls.dart';
import 'package:b_o_s_notifications/local_DataBase.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'package:rxdart/rxdart.dart';
import 'main.dart';

class FFAppState extends ChangeNotifier {
  DateTime? currentTime;
  int? blockHID;
  int? firstTime;
  int? endRes;
  int? lastBlockHeight;
  String? filterID;
  bool cycle = true;
  bool selectAccounts = false;
  bool pause = false;
  bool newMessage = false;
  bool messageNull = true;
  bool initStateForSwitch = true;
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  final BehaviorSubject<List<Map>> listNameId = BehaviorSubject<List<Map>>()
    ..add([]);
  final BehaviorSubject<List<int>> listTapNotifications =
      BehaviorSubject<List<int>>()..add([]);
  final BehaviorSubject<bool> streamConroller = BehaviorSubject<bool>()
    ..add(false);

  final BehaviorSubject<List> sortStreamNotifications = BehaviorSubject<List>();

  final BehaviorSubject<List> streamBlockHeight = BehaviorSubject<List>()
    ..add([]);
  final BehaviorSubject<List<String>> listAccountForNotifications =
      BehaviorSubject<List<String>>()..add([]);

  final BehaviorSubject<List> streamNotifications = BehaviorSubject<List>();

  final BehaviorSubject<List<String>> subsAccountList =
      BehaviorSubject<List<String>>()..add([]);

  final BehaviorSubject<List<Map<String, dynamic>>> deletedAccountList =
      BehaviorSubject<List<Map<String, dynamic>>>()..add([]);

  final BehaviorSubject<List<String>> deletionAccountList =
      BehaviorSubject<List<String>>()..add([]);

  final BehaviorSubject<bool> historyOnOff = BehaviorSubject<bool>()
    ..add(false);

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

  @override
  void dispose() {
    // TODO: implement dispose
    listNameId.close();
    streamConroller.close();
    sortStreamNotifications.close();
    listAccountForNotifications.close();
    streamBlockHeight.close();
    subsAccountList.close();
    deletedAccountList.close();
    historyOnOff.close();
    deletionAccountList.close();
    streamNotifications.close();

    super.dispose();
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

Future initNotificationsForFilter() async {
  FFAppState().pause = false;
  FFAppState().messageNull = true;
  if (!FFAppState().cycle) {
    return;
  }
  Future.microtask(
    () async {
      FFAppState().cycle = false;
      await Future.delayed(Duration(seconds: 1));
      FFAppState().cycle = true;
    },
  );

  FFAppState().lastBlockHeight = null;
  DateTime start = DateFormat('MMM d, yyyy')
      .parse(FFAppState().filterData.first)
      .add(Duration(hours: 24))
      .subtract(Duration(milliseconds: 1));
  DateTime end = DateFormat('MMM d, yyyy').parse(FFAppState().filterData.last);
  DateTime startNotifications = FFAppState().currentTime!;
  if (start > startNotifications) {
    start = startNotifications;
  }
  int secondsForStart = startNotifications.difference(start).inSeconds;
  int secondsForEnd = startNotifications.difference(end).inSeconds;
  int BlockHeightForStart = start == startNotifications
      ? FFAppState().blockHID!
      : FFAppState().blockHID! - secondsForStart;
  FFAppState().endRes = FFAppState().blockHID! - secondsForEnd;

  FFAppState().listAccountForNotifications.add([]);
  FFAppState().sortStreamNotifications.add([]);
  FFAppState().streamNotifications.add([]);
  List<String> subs;
  if (FFAppState().filterID == null) {
    subs = List.from(currentUserDocument?.subscriptions ?? []);
  } else {
    subs = List.from(currentUserDocument?.subscriptions ?? []);
    subs.removeWhere(
        (element) => !element.startsWith(FFAppState().filterID ?? ' '));
  }

  await Future.forEach(subs, (elementAcc) async {
    DateTime timeUNIXresult;
    ApiCallResponse valueApi =
        await GetNotificationsByUserIdWithFromValueCall.call(
            accountId: elementAcc, from: BlockHeightForStart);
    List valueApiResult = valueApi.jsonBody;
    if (valueApiResult.isEmpty) {
      return;
    }

    if (valueApiResult.length == 20 &&
        valueApiResult.last['blockHeight'] > FFAppState().endRes) {
      if (FFAppState().lastBlockHeight == null ||
          FFAppState().lastBlockHeight! < valueApiResult.last['blockHeight']) {
        FFAppState().lastBlockHeight = valueApiResult.last['blockHeight'];
      }
      FFAppState().listAccountForNotifications.value.add(elementAcc);
    }
    await Future.forEach(valueApiResult, (element) async {
      String name = '';
      if (FFAppState().listNameId.value.any(
            (el) => el['id'] == element['accountId'],
          )) {
        name = FFAppState()
            .listNameId
            .value
            .firstWhere((el) => el['id'] == element['accountId'])['name'];
      } else {
        ApiCallResponse x =
            await GetNearSocialNameCall.call(accountId: element['accountId']);
        if (x.jsonBody[element['accountId']] != null) {
          name = x.jsonBody[element['accountId']]['profile']['name'];
          FFAppState()
              .listNameId
              .value
              .add({'id': element['accountId'], 'name': name});
        } else {
          FFAppState()
              .listNameId
              .value
              .add({'id': element['accountId'], 'name': ''});
        }
      }

      DateTime originalDate = FFAppState().currentTime!;
      Duration durationToSubtract = Duration(
          seconds: (FFAppState().blockHID! - element['blockHeight']).toInt());
      DateTime newDate = originalDate.subtract(durationToSubtract);
      timeUNIXresult = newDate;

      FFAppState()
          .sortStreamNotifications
          .value
          .add([element, timeUNIXresult, elementAcc, name]);
      FFAppState()
          .sortStreamNotifications
          .add(FFAppState().sortStreamNotifications.value);
    });
  });

  FFAppState().update(
    () {
      List sort = FFAppState().sortStreamNotifications.value;
      sort.removeWhere(
          (element) => element[0]['blockHeight'] < FFAppState().endRes);
      sort.removeWhere((element) =>
          element[0]['blockHeight'] < (FFAppState().lastBlockHeight ?? 0));
      sort.sort((a, b) => b[0]['blockHeight'].compareTo(a[0]['blockHeight']));
      FFAppState().streamNotifications.add(sort);
      FFAppState().messageNull = false;
      FFAppState().streamConroller.add(true);
      FFAppState().pause = true;
    },
  );
}

Future initNotifications() async {
  FFAppState().pause = false;
  FFAppState().messageNull = true;
  bool start = true;
  DateTime timeUNIXresult;
  FFAppState().lastBlockHeight = null;

  int? blockH;
  FFAppState().sortStreamNotifications.add([]);
  FFAppState().streamNotifications.add([]);
  FFAppState().listAccountForNotifications.add([]);
  List<String> subs = [];
  if (FFAppState().filterID == null) {
    subs = List.from(currentUserDocument?.subscriptions ?? []);
  } else if (FFAppState().filterID != null) {
    subs = List.from(currentUserDocument?.subscriptions ?? []);
    subs.removeWhere((element) => !element.startsWith(FFAppState().filterID!));

    print(subs);
    print(FFAppState().filterID);
  }
  if (subs.isEmpty) {
    FFAppState().update(() {
      FFAppState().messageNull = false;
    });
    return;
  }

  subs.forEach((e) async {
    ApiCallResponse _notification =
        await GetNotificationsByUserIdWithoutFromValueCall.call(accountId: e);
    List value = _notification.jsonBody;
    if (value.length == 20) {
      FFAppState().listAccountForNotifications.value.add(e);

      if (FFAppState().lastBlockHeight == null ||
          FFAppState().lastBlockHeight! > value.last['blockHeight']) {
        FFAppState().lastBlockHeight = value.last['blockHeight'];
      }
    }
    await Future.forEach(value, (element) async {
      String name = '';
      if (FFAppState().listNameId.value.any(
            (el) => el['id'] == element['accountId'],
          )) {
        name = FFAppState()
            .listNameId
            .value
            .firstWhere((el) => el['id'] == element['accountId'])['name'];
      } else {
        ApiCallResponse x =
            await GetNearSocialNameCall.call(accountId: element['accountId']);
        if (x.jsonBody[element['accountId']] != null) {
          name = x.jsonBody[element['accountId']]['profile']['name'];
          FFAppState()
              .listNameId
              .value
              .add({'id': element['accountId'], 'name': name});
        } else {
          FFAppState()
              .listNameId
              .value
              .add({'id': element['accountId'], 'name': ''});
        }
      }

      if (start || ((FFAppState().blockHID! - element['blockHeight']) < 0)) {
        var timeUNIX = await GetTimeForNotificationsByBlockHeight.call(
            element['blockHeight']);
        timeUNIXresult = DateTime.fromMillisecondsSinceEpoch(timeUNIX.jsonBody);
        if (FFAppState().currentTime == null ||
            FFAppState().currentTime! < timeUNIXresult) {
          FFAppState().currentTime = timeUNIXresult;
          FFAppState().blockHID = element['blockHeight'];
        }

        DateTime date = DateTime.fromMillisecondsSinceEpoch(timeUNIX.jsonBody);
        blockH = (date.hour * 3600 + date.minute * 60 + date.second);
        start = false;
      } else {
        DateTime originalDate = FFAppState().currentTime!;
        Duration durationToSubtract = Duration(
            seconds: (FFAppState().blockHID! - element['blockHeight']).toInt());
        DateTime newDate =
            originalDate.toUtc().subtract(durationToSubtract).toLocal();
        timeUNIXresult = newDate;
      }

      FFAppState()
          .streamNotifications
          .value
          .add([element, timeUNIXresult, e, name]);
      FFAppState()
          .streamNotifications
          .add(FFAppState().streamNotifications.value);

      FFAppState().update(
        () {
          List sort = FFAppState().streamNotifications.value;
          sort.removeWhere((element) =>
              element[0]['blockHeight'] < FFAppState().lastBlockHeight ?? 0);
          sort.sort(
              (a, b) => b[0]['blockHeight'].compareTo(a[0]['blockHeight']));
          FFAppState().streamNotifications.add(sort);
          FFAppState().messageNull = false;
          FFAppState().streamConroller.add(false);
          FFAppState().pause = true;
        },
      );
    });
    start = true;
  });
}
