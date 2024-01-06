import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../local_DataBase.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        FFAppState().userfound = 0;
      });
    });

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
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * 0.8,
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
                    color: Colors.white,
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
                            return 17.0;
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
                            return 18.0;
                          } else {
                            return 20.0;
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
                  textScaleFactor: 1,
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
                            return 15.0;
                          } else if (MediaQuery.sizeOf(context).width <
                              valueOrDefault<double>(
                                kBreakpointLarge,
                                1500.0,
                              )) {
                            return 16.0;
                          } else {
                            return 17.0;
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
                  textScaleFactor: 1,
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
                            return 16.0;
                          } else if (MediaQuery.sizeOf(context).width <
                              valueOrDefault<double>(
                                kBreakpointLarge,
                                1500.0,
                              )) {
                            return 18.0;
                          } else {
                            return 20.0;
                          }
                        }(),
                        fontWeight: FontWeight.w500,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyMediumFamily),
                      ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: MediaQuery.sizeOf(context).width,
                alignment: Alignment.center,
                constraints: BoxConstraints(
                  maxWidth: 350.0,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFFAF9F8),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Color(0xFFBDBDBD),
                    width: 1.0,
                  ),
                ),
                child: OverflowBox(
                  maxHeight: 1000,
                  child: TextField(
                    controller: _model.textController,
                    onChanged: (_) {
                      HapticFeedback.lightImpact();
                      EasyDebounce.debounce(
                        '_model.textController',
                        Duration(seconds: 1),
                        () async {
                          var _shouldSetState = false;
                          if (_model.textController.text == '') {
                            setState(() {
                              FFAppState().userfound = 0;
                            });
                            if (_shouldSetState) setState(() {});
                            return;
                          } else {
                            _model.getNearSocialInfoResult =
                                await GetNearSocialInformationCall.call(
                              accountId: _model.textController.text,
                            );
                            _shouldSetState = true;
                            if (((_model.getNearSocialInfoResult?.bodyText ??
                                        '') ==
                                    '') ||
                                ((_model.getNearSocialInfoResult?.bodyText ??
                                        '') ==
                                    '{}')) {
                              setState(() {
                                FFAppState().userfound = 2;
                              });
                              if (_shouldSetState) setState(() {});
                              return;
                            } else {
                              setState(() {
                                FFAppState().userfound = 1;
                              });
                              if (_shouldSetState) setState(() {});
                              return;
                            }
                          }
                        },
                      );
                    },
                    textAlignVertical: TextAlignVertical.top,
                    style: FlutterFlowTheme.of(context)
                        .labelMedium
                        .copyWith(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Enter Account ID here...',
                      hintStyle: FlutterFlowTheme.of(context)
                          .labelMedium
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelMediumFamily,
                            color: Color(0xFFBDBDBD),
                            fontSize: 14.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).labelMediumFamily),
                          ),
                      enabledBorder: InputBorder.none,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.00, 0.00),
              child: Container(
                width: 400.0,
                height: 30.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 5.0),
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (FFAppState().userfound.toString() == '1')
                              Icon(
                                Icons.check,
                                color: Color(0xFF65C3A2),
                                size: 20.0,
                              ),
                            if (FFAppState().userfound.toString() != '0')
                              Align(
                                alignment: AlignmentDirectional(-1.00, 0.00),
                                child: Text(
                                  FFAppState().userfound == 1
                                      ? 'An account has been found:'
                                      : 'No account with this ID has been found',
                                  textScaleFactor: 1,
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (FFAppState().userfound.toString() == '1')
              Padding(
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
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            width: 45.0,
                            height: 45.0,
                            decoration: BoxDecoration(
                              color: Color(0x00815757),
                              shape: BoxShape.circle,
                            ),
                            child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    SvgPicture.network(url),
                                imageUrl: _model.textController.text != ''
                                    ? "https://i.near.social/magic/large/https://near.social/magic/img/account/${_model.textController.text}"
                                    : "https://i.near.social/magic/large/https://near.social/magic/img/account/sesona"),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                '@${_model.textController.text}',
                                textScaleFactor: 1,
                                overflow: TextOverflow.ellipsis,
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
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            Align(
              alignment: AlignmentDirectional(0.00, 1.00),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 50.0),
                child: InkWell(
                  onTap: () async {
                    HapticFeedback.mediumImpact();
                    Future.microtask(
                      () async {
                        if (currentUserDocument?.subscriptions.length == 50) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('limit')));
                        }
                        _model.button = await GetNearSocialInformationCall.call(
                          accountId: _model.textController.text,
                        );
                        if (((_model.button?.bodyText ?? '') != null &&
                                (_model.button?.bodyText ?? '') != '') &&
                            ((_model.button?.bodyText ?? '') != '{}') &&
                            (FFAppState().userfound != 0)) {
                          DatabaseHelper dbHelper = DatabaseHelper();
                          var db = await dbHelper.db;
                          FFAppState().update(
                            () async {
                              await dbHelper.deleteRecordByName(
                                  _model.textController.text);
                              FFAppState()
                                  .deletedAccountList
                                  .add(await db.query('myDB'));
                            },
                          );
                          await currentUserReference!.update({
                            ...mapToFirestore(
                              {
                                'subscriptions': FieldValue.arrayUnion(
                                    [_model.textController.text]),
                              },
                            ),
                          });
                        }

                        final uid = FirebaseAuth.instance.currentUser!.uid;
                        final token = FFAppState().initStateForSwitch
                            ? await FirebaseMessaging.instance.getToken()
                            : '';

                        final isThisAccountIdChannelExist =
                            (await FirebaseFirestore.instance
                                        .collection('subscriptions_channels')
                                        .doc(_model.textController.text)
                                        .get())
                                    .data()
                                    ?.isNotEmpty ??
                                false;

                        if (isThisAccountIdChannelExist) {
                          await FirebaseFirestore.instance
                              .collection('subscriptions_channels')
                              .doc(_model.textController.text)
                              .update({uid: token});
                        } else {
                          await FirebaseFirestore.instance
                              .collection('subscriptions_channels')
                              .doc(_model.textController.text)
                              .set({uid: token});
                        }

                        await currentUserReference!.update({
                          ...mapToFirestore(
                            {
                              'accountDeleted': FieldValue.arrayRemove([
                                getAccountsDeletedFirestoreData(
                                  updateAccountsDeletedStruct(
                                    (currentUserDocument?.accountDeleted
                                                ?.toList() ??
                                            [])
                                        .where((e) =>
                                            e.name ==
                                            _model.textController.text)
                                        .toList()
                                        .first,
                                    clearUnsetFields: false,
                                  ),
                                  true,
                                )
                              ]),
                            },
                          ),
                        });
                      },
                    );
                    await Future.delayed(Duration(milliseconds: 300));
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: 50,
                    constraints: BoxConstraints(
                      maxWidth: 400.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: FFAppState().userfound == 1
                          ? Colors.black
                          : Color(0xFFF5F5EF),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Subscribe',
                        textScaleFactor: 1,
                        style: TextStyle(
                          fontSize: 18,
                          color: !(FFAppState().userfound == 1)
                              ? Colors.black
                              : Color(0xFFF5F5EF),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
