import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'account_deleting_model.dart';
export 'account_deleting_model.dart';

class AccountDeletingWidget extends StatefulWidget {
  const AccountDeletingWidget({
    Key? key,
    String? name,
    required this.index,
  })  : this.name = name ?? 'name',
        super(key: key);

  final String name;
  final int? index;

  @override
  _AccountDeletingWidgetState createState() => _AccountDeletingWidgetState();
}

class _AccountDeletingWidgetState extends State<AccountDeletingWidget> {
  late AccountDeletingModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AccountDeletingModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (_model.start == false) {
        _model.timerController.onStartTimer();
      } else {
        return;
      }

      setState(() {
        _model.start = true;
      });
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

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 55.0, 0.0, 55.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          width: valueOrDefault<double>(
            () {
              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                return 330.0;
              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                return 350.0;
              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                return 370.0;
              } else {
                return 400.0;
              }
            }(),
            330.0,
          ),
          height: 65.0,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 30.0,
                color: Color(0xA05B5B5B),
                offset: Offset(0.0, 10.0),
              )
            ],
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              LinearPercentIndicator(
                percent: functions.timer(_model.timerValue),
                lineHeight: 4.0,
                animation: true,
                animateFromLastPercent: true,
                progressColor: Color(0xFF38AB10),
                backgroundColor: FlutterFlowTheme.of(context).accent4,
                padding: EdgeInsets.zero,
              ),
              FlutterFlowTimer(
                initialTime: _model.timerMilliseconds,
                getDisplayTime: (value) => StopWatchTimer.getDisplayTime(
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
                  _model.updatePage(() {
                    FFAppState().removeFromDeletingAccounts(
                        FFAppState().deletingAccounts[widget.index!]);
                  });
                },
                textAlign: TextAlign.start,
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).headlineSmallFamily,
                      fontSize: 2.0,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).headlineSmallFamily),
                    ),
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                      child: RichText(
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: widget.name,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                  ),
                            ),
                            TextSpan(
                              text: 'has been deleted',
                              style: TextStyle(),
                            )
                          ],
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
                      child: Container(
                        width: 80.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Undo',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: Color(0xFF38AB10),
                                    fontWeight: FontWeight.w600,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                  ),
                            ),
                            FlutterFlowIconButton(
                              borderRadius: 0.0,
                              borderWidth: 0.0,
                              buttonSize: 40.0,
                              icon: Icon(
                                Icons.replay_sharp,
                                color: Color(0xFF38AB10),
                                size: 24.0,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
