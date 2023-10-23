import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'account_deleted_model.dart';
export 'account_deleted_model.dart';

class AccountDeletedWidget extends StatefulWidget {
  const AccountDeletedWidget({
    Key? key,
    required this.accountName,
  }) : super(key: key);

  final String? accountName;

  @override
  _AccountDeletedWidgetState createState() => _AccountDeletedWidgetState();
}

class _AccountDeletedWidgetState extends State<AccountDeletedWidget> {
  late AccountDeletedModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AccountDeletedModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.timerController.onStartTimer();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 0.15,
      decoration: BoxDecoration(
        color: Color(0x00FFFFFF),
      ),
      child: Align(
        alignment: AlignmentDirectional(0.00, 0.00),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            width: () {
              if (MediaQuery.sizeOf(context).width <
                  valueOrDefault<double>(
                    kBreakpointSmall,
                    400.0,
                  )) {
                return 250.0;
              } else if (MediaQuery.sizeOf(context).width <
                  valueOrDefault<double>(
                    kBreakpointMedium,
                    1025.0,
                  )) {
                return 350.0;
              } else if (MediaQuery.sizeOf(context).width <
                  valueOrDefault<double>(
                    kBreakpointLarge,
                    1500.0,
                  )) {
                return 450.0;
              } else {
                return 600.0;
              }
            }(),
            height: MediaQuery.sizeOf(context).height * 0.06,
            constraints: BoxConstraints(
              maxWidth: 300.0,
              maxHeight: 100.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                LinearPercentIndicator(
                  percent: valueOrDefault<double>(
                    functions.timer(_model.timerValue),
                    1.0,
                  ),
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  lineHeight: 4.0,
                  animation: true,
                  animateFromLastPercent: true,
                  progressColor: FlutterFlowTheme.of(context).primary,
                  backgroundColor: FlutterFlowTheme.of(context).accent4,
                  padding: EdgeInsets.zero,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (false)
                      FlutterFlowTimer(
                        initialTime: _model.timerMilliseconds,
                        getDisplayTime: (value) =>
                            StopWatchTimer.getDisplayTime(
                          value,
                          hours: false,
                          minute: false,
                          milliSecond: false,
                        ),
                        controller: _model.timerController,
                        updateStateInterval: Duration(milliseconds: 1000),
                        onChanged: (value, displayTime, shouldUpdate) {
                          _model.timerMilliseconds = value;
                          _model.timerValue = displayTime;
                          if (shouldUpdate) setState(() {});
                        },
                        onEnded: () async {
                          Navigator.pop(context);
                        },
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).headlineSmall,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
