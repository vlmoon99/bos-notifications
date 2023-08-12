import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'subscribe_bottom_bar_model.dart';
export 'subscribe_bottom_bar_model.dart';

class SubscribeBottomBarWidget extends StatefulWidget {
  const SubscribeBottomBarWidget({Key? key}) : super(key: key);

  @override
  _SubscribeBottomBarWidgetState createState() =>
      _SubscribeBottomBarWidgetState();
}

class _SubscribeBottomBarWidgetState extends State<SubscribeBottomBarWidget> {
  late SubscribeBottomBarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SubscribeBottomBarModel());

    _model.textController ??= TextEditingController();
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

    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
        child: Container(
          width: 400.0,
          height: 300.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: [
              BoxShadow(
                blurRadius: 4.0,
                color: Color(0x33000000),
                offset: Offset(0.0, 2.0),
              )
            ],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 16.0, 8.0, 0.0),
                child: Container(
                  width: 350.0,
                  child: TextFormField(
                    controller: _model.textController,
                    autofocus: true,
                    textCapitalization: TextCapitalization.none,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Account ID',
                      labelStyle: FlutterFlowTheme.of(context).labelLarge,
                      hintStyle: FlutterFlowTheme.of(context).labelMedium,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).nEARAqua,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).nEARPurple,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).nEARRed,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).nEARRed,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium,
                    textAlign: TextAlign.start,
                    validator:
                        _model.textControllerValidator.asValidator(context),
                  ),
                ),
              ),
              Flexible(
                child: Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: Container(
                    width: 180.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          var _shouldSetState = false;
                          if (FFAppState()
                                  .subscriptions
                                  .contains(_model.textController.text) ==
                              false) {
                            _model.requestedAccountIdNearSocialInformation =
                                await GetNearSocialInformationCall.call(
                              accountId: _model.textController.text,
                            );
                            _shouldSetState = true;
                          } else {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'This accountId already in you subscriptions',
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                  ),
                                ),
                                duration: Duration(milliseconds: 300),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).secondary,
                              ),
                            );
                            if (_shouldSetState) setState(() {});
                            return;
                          }

                          if (GetNearSocialInformationCall.all(
                                (_model.requestedAccountIdNearSocialInformation
                                        ?.jsonBody ??
                                    ''),
                              ) !=
                              '{}') {
                            setState(() {
                              FFAppState().addToSubscriptions(
                                  _model.textController.text);
                            });
                          } else {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Account was not found',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyLargeFamily,
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyLargeFamily),
                                      ),
                                ),
                                duration: Duration(milliseconds: 600),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).secondary,
                              ),
                            );
                            if (_shouldSetState) setState(() {});
                            return;
                          }

                          await SubscriptionsChannelsRecord.collection
                              .doc()
                              .set({
                            ...createSubscriptionsChannelsRecordData(
                              accountId: _model.textController.text,
                            ),
                            'subscribersFcmTokens': ['token'],
                          });

                          await currentUserReference!.update({
                            'subscriptions': FieldValue.arrayUnion(
                                [_model.textController.text]),
                          });
                          if (_shouldSetState) setState(() {});
                        },
                        text: 'Subscribe',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).nEARAqua,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: Colors.white,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .titleSmallFamily),
                              ),
                          elevation: 3.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
