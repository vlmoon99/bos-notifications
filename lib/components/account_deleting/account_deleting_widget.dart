import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

    return ClipRRect(
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
              percent: valueOrDefault<double>(
                _model.progress,
                1.0,
              ),
              lineHeight: 4.0,
              animation: true,
              animateFromLastPercent: true,
              progressColor: Color(0xFF65C3A2),
              backgroundColor: Color(0xFFF2F1EA),
              padding: EdgeInsets.zero,
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
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
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                              ),
                        ),
                        TextSpan(
                          text: ' has been deleted',
                          style: TextStyle(),
                        )
                      ],
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 3,
                  ),
                  Container(
                    width: 80.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        _model.timerController.onResetTimer();

                        _model.timerController.onStopTimer();
                        setState(() {
                          FFAppState()
                              .removeFromAccountDeletingNames(widget.name);
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Undo',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: Color(0xFF65C3A2),
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                          ),
                          Icon(
                            Icons.replay_sharp,
                            color: Color(0xFF65C3A2),
                            size: 28.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-1.00, -1.00),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                child: StreamBuilder<UsersRecord>(
                  stream: UsersRecord.getDocument(currentUserReference!)
                    ..listen((timerUsersRecord) async {
                      if (_model.timerPreviousSnapshot != null &&
                          !UsersRecordDocumentEquality().equals(
                              timerUsersRecord, _model.timerPreviousSnapshot)) {
                        setState(() {
                          _model.progress = functions.timer(_model.timerValue);
                        });

                        setState(() {});
                      }
                      _model.timerPreviousSnapshot = timerUsersRecord;
                    }),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        ),
                      );
                    }
                    final timerUsersRecord = snapshot.data!;
                    return FlutterFlowTimer(
                      initialTime: _model.timerMilliseconds,
                      getDisplayTime: (value) => StopWatchTimer.getDisplayTime(
                        value,
                        hours: false,
                        minute: false,
                        milliSecond: false,
                      ),
                      controller: _model.timerController,
                      updateStateInterval: Duration(milliseconds: 100),
                      onChanged: (value, displayTime, shouldUpdate) {
                        _model.timerMilliseconds = value;
                        _model.timerValue = displayTime;
                        if (shouldUpdate) setState(() {});
                      },
                      onEnded: () async {
                        setState(() {
                          FFAppState()
                              .removeFromAccountDeletingNames(widget.name);
                          FFAppState().removeFromSubscriptions(widget.name);
                        });

                        await currentUserReference!.update({
                          ...mapToFirestore(
                            {
                              'subscriptions':
                                  FieldValue.arrayRemove([widget.name]),
                            },
                          ),
                        });

                        await timerUsersRecord.reference.update({
                          ...mapToFirestore(
                            {
                              'subscriptions':
                                  FieldValue.arrayRemove([widget.name]),
                            },
                          ),
                        });
                      },
                      textAlign: TextAlign.start,
                      style:
                          FlutterFlowTheme.of(context).headlineSmall.override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineSmallFamily,
                                fontSize: 10.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .headlineSmallFamily),
                              ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
