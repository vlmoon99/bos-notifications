import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'account_deleting_widget.dart' show AccountDeletingWidget;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class AccountDeletingModel extends FlutterFlowModel<AccountDeletingWidget> {
  ///  Local state fields for this component.

  bool start = false;

  double progress = 1.0;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Timer widget.
  int timerMilliseconds = 10000;
  String timerValue = StopWatchTimer.getDisplayTime(
    10000,
    hours: false,
    minute: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  UsersRecord? timerPreviousSnapshot;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    timerController.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
