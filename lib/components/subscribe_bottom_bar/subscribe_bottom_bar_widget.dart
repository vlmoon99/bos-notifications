import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    _model.textFieldFocusNode ??= FocusNode();
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
      alignment: AlignmentDirectional(0.00, -1.00),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: MediaQuery.sizeOf(context).height * 0.5,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 4.0,
              color: Color(0x33000000),
              offset: Offset(0.0, 2.0),
            )
          ],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: AlignmentDirectional(0.00, -1.00),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(50.0, 10.0, 50.0, 10.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.15,
                  height: 5.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFBDBDBD),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-1.00, 0.00),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(25.0, 15.0, 0.0, 15.0),
                child: Text(
                  'Adding a new Account',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        fontSize: () {
                          if (MediaQuery.sizeOf(context).width <
                              valueOrDefault<double>(
                                kBreakpointSmall,
                                400.0,
                              )) {
                            return 18.0;
                          } else if (MediaQuery.sizeOf(context).width <
                              valueOrDefault<double>(
                                kBreakpointMedium,
                                1025.0,
                              )) {
                            return 20.0;
                          } else if (MediaQuery.sizeOf(context).width <
                              valueOrDefault<double>(
                                kBreakpointLarge,
                                1500.0,
                              )) {
                            return 30.0;
                          } else {
                            return 40.0;
                          }
                        }(),
                        fontWeight: FontWeight.bold,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyMediumFamily),
                      ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-1.00, 0.00),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(25.0, 5.0, 0.0, 20.0),
                child: Text(
                  'Enter Account ID in the field below',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        fontSize: () {
                          if (MediaQuery.sizeOf(context).width <
                              valueOrDefault<double>(
                                kBreakpointSmall,
                                400.0,
                              )) {
                            return 12.0;
                          } else if (MediaQuery.sizeOf(context).width <
                              valueOrDefault<double>(
                                kBreakpointMedium,
                                1025.0,
                              )) {
                            return 16.0;
                          } else if (MediaQuery.sizeOf(context).width <
                              valueOrDefault<double>(
                                kBreakpointLarge,
                                1500.0,
                              )) {
                            return 20.0;
                          } else {
                            return 26.0;
                          }
                        }(),
                        fontWeight: FontWeight.w500,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyMediumFamily),
                      ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-1.00, 0.00),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 10.0),
                child: Text(
                  'Add an Account:',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        color: Color(0xFF7E7E7E),
                        fontSize: () {
                          if (MediaQuery.sizeOf(context).width <
                              valueOrDefault<double>(
                                kBreakpointSmall,
                                400.0,
                              )) {
                            return 15.0;
                          } else if (MediaQuery.sizeOf(context).width <
                              valueOrDefault<double>(
                                kBreakpointMedium,
                                1025.0,
                              )) {
                            return 19.0;
                          } else if (MediaQuery.sizeOf(context).width <
                              valueOrDefault<double>(
                                kBreakpointLarge,
                                1500.0,
                              )) {
                            return 23.0;
                          } else {
                            return 29.0;
                          }
                        }(),
                        fontWeight: FontWeight.w500,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyMediumFamily),
                      ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(
                  valueOrDefault<double>(
                    MediaQuery.sizeOf(context).width <
                            valueOrDefault<double>(
                              kBreakpointSmall,
                              400.0,
                            )
                        ? 0.0
                        : -1.0,
                    0.0,
                  ),
                  0.00),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 5.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: 40.0,
                  constraints: BoxConstraints(
                    maxWidth: 350.0,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5EF),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: Color(0xFFBDBDBD),
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: () {
                          if (MediaQuery.sizeOf(context).width <
                              valueOrDefault<double>(
                                kBreakpointSmall,
                                400.0,
                              )) {
                            return 205.0;
                          } else if (MediaQuery.sizeOf(context).width <
                              valueOrDefault<double>(
                                kBreakpointMedium,
                                1025.0,
                              )) {
                            return 305.0;
                          } else if (MediaQuery.sizeOf(context).width <
                              valueOrDefault<double>(
                                kBreakpointLarge,
                                1500.0,
                              )) {
                            return 405.0;
                          } else {
                            return 555.0;
                          }
                        }(),
                        height: 100.0,
                        constraints: BoxConstraints(
                          maxWidth: 550.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(8.0),
                            topLeft: Radius.circular(0.0),
                            topRight: Radius.circular(8.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              14.0, 0.0, 14.0, 0.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            child: TextFormField(
                              controller: _model.textController,
                              focusNode: _model.textFieldFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.textController',
                                Duration(milliseconds: 2000),
                                () async {
                                  setState(() {
                                    FFAppState().userfound = 0;
                                  });
                                },
                              ),
                              onFieldSubmitted: (_) async {
                                var _shouldSetState = false;
                                if (_model.textController.text == '') {
                                  setState(() {
                                    FFAppState().userfound = 0;
                                  });
                                  if (_shouldSetState) setState(() {});
                                  return;
                                }
                                _model.socialInformation =
                                    await GetNearSocialInformationCall.call(
                                  accountId: _model.textController.text,
                                );
                                _shouldSetState = true;
                                if ((_model.socialInformation?.bodyText ??
                                        '') !=
                                    '{}') {
                                  setState(() {
                                    FFAppState().userfound = 1;
                                  });
                                } else {
                                  setState(() {
                                    FFAppState().userfound = 2;
                                  });
                                }

                                if (_shouldSetState) setState(() {});
                              },
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Enter Account ID here...',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .labelMediumFamily,
                                      color: Color(0xFFBDBDBD),
                                      fontSize: 12.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .labelMediumFamily),
                                    ),
                                hintStyle:
                                    FlutterFlowTheme.of(context).labelMedium,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    fontSize: 14.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                  ),
                              validator: _model.textControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 5.0),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Opacity(
                          opacity: FFAppState().userfound == 1 ? 1.0 : 0.0,
                          child: Icon(
                            Icons.check,
                            color: Color(0xFF65C3A2),
                            size: 20.0,
                          ),
                        ),
                        Opacity(
                          opacity: FFAppState().userfound == 0 ? 0.0 : 1.0,
                          child: Align(
                            alignment: AlignmentDirectional(-1.00, 0.00),
                            child: Text(
                              FFAppState().userfound == 1
                                  ? 'An account has been found:'
                                  : 'No account with this ID has been found',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: FFAppState().userfound == 1
                                        ? Color(0xFF65C3A2)
                                        : Color(0xFFFF7966),
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Opacity(
              opacity: FFAppState().userfound == 1 ? 1.0 : 0.0,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 25.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: 55.0,
                  constraints: BoxConstraints(
                    maxWidth: 350.0,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFFAF9F8),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5.0, 3.0, 5.0, 3.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 4.0, 0.0, 4.0),
                          child: Container(
                            width: 45.0,
                            height: 45.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFFF0000),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.network(
                                  '',
                                ).image,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '@${_model.textController.text}',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                              ),
                              Text(
                                'Platform',
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Text(
              currentUserUid,
              style: FlutterFlowTheme.of(context).bodyMedium,
            ),
            Align(
              alignment: AlignmentDirectional(0.00, 0.00),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 0.0),
                child: StreamBuilder<List<UsersRecord>>(
                  stream: queryUsersRecord(
                    queryBuilder: (usersRecord) => usersRecord.where(
                      'uid',
                      isEqualTo: currentUserUid,
                    ),
                    singleRecord: true,
                  ),
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
                    List<UsersRecord> buttonUsersRecordList = snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final buttonUsersRecord = buttonUsersRecordList.isNotEmpty
                        ? buttonUsersRecordList.first
                        : null;
                    return FFButtonWidget(
                      onPressed: () async {
                        if (((_model.socialInformation?.bodyText ?? '') !=
                                    null &&
                                (_model.socialInformation?.bodyText ?? '') !=
                                    '') &&
                            ((_model.socialInformation?.bodyText ?? '') !=
                                '{}') &&
                            (FFAppState().userfound != 0)) {
                          await currentUserReference!.update({
                            ...mapToFirestore(
                              {
                                'subscriptions': FieldValue.arrayUnion(
                                    [_model.textController.text]),
                              },
                            ),
                          });
                        } else {
                          return;
                        }

                        await buttonUsersRecord!.reference.update({
                          ...mapToFirestore(
                            {
                              'subscriptions': (currentUserDocument
                                      ?.subscriptions
                                      ?.toList() ??
                                  []),
                            },
                          ),
                        });
                      },
                      text: 'Subscribe',
                      options: FFButtonOptions(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        height: 40.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FFAppState().userfound == 1
                            ? Colors.black
                            : Color(0xFFF5F5EF),
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleSmallFamily,
                              color: Colors.white,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .titleSmallFamily),
                            ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
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
