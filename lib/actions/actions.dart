import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_manager.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

Future fetchUserSubscriptions(BuildContext context) async {
  SubscriptionsRecord? queriedUserSubscriptions;

  queriedUserSubscriptions = await querySubscriptionsRecordOnce(
    singleRecord: true,
  ).then((s) => s.firstOrNull);
  FFAppState().update(() {
    FFAppState().userSubscriptions = queriedUserSubscriptions!.subscriptions
        .toList()
        .cast<SubscriptionStruct>();
  });
}
