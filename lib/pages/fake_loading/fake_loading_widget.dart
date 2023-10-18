import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'fake_loading_model.dart';
export 'fake_loading_model.dart';

class FakeLoadingWidget extends StatefulWidget {
  const FakeLoadingWidget({Key? key}) : super(key: key);

  @override
  _FakeLoadingWidgetState createState() => _FakeLoadingWidgetState();
}

class _FakeLoadingWidgetState extends State<FakeLoadingWidget> {
  late FakeLoadingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FakeLoadingModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      context.pushNamed(
        'LoginPage',
        extra: <String, dynamic>{
          kTransitionInfoKey: TransitionInfo(
            hasTransition: true,
            transitionType: PageTransitionType.fade,
            duration: Duration(milliseconds: 500),
          ),
        },
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Title(
        title: 'fakeLoading',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
              top: true,
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  if (FFAppState().image == 2) {
                    setState(() {
                      FFAppState().image = 0;
                    });
                  } else {
                    setState(() {
                      FFAppState().image = FFAppState().image + 1;
                    });
                  }
                },
                child: Stack(
                  children: [
                    Opacity(
                      opacity: FFAppState().image == 0 ? 1.0 : 0.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/Loading1.png',
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 1.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: FFAppState().image == 1 ? 1.0 : 0.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/Loading2.png',
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 1.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: FFAppState().image == 2 ? 1.0 : 0.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/Loading3.png',
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 1.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0.0,
                      child: Align(
                        alignment: AlignmentDirectional(-1.00, 1.00),
                        child: FlutterFlowTimer(
                          initialTime: _model.timerMilliseconds,
                          getDisplayTime: (value) =>
                              StopWatchTimer.getDisplayTime(
                            value,
                            hours: false,
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
                            context.pushNamed(
                              'LoginPage',
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.scale,
                                  alignment: Alignment.bottomCenter,
                                ),
                              },
                            );
                          },
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context).headlineSmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
