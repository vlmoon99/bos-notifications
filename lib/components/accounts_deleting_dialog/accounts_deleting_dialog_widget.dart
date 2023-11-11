import 'package:b_o_s_notifications/local_DataBase.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'accounts_deleting_dialog_model.dart';
export 'accounts_deleting_dialog_model.dart';

class AccountsDeletingDialogWidget extends StatefulWidget {
  const AccountsDeletingDialogWidget({Key? key}) : super(key: key);

  @override
  _AccountsDeletingDialogWidgetState createState() =>
      _AccountsDeletingDialogWidgetState();
}

class _AccountsDeletingDialogWidgetState
    extends State<AccountsDeletingDialogWidget> {
  late AccountsDeletingDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AccountsDeletingDialogModel());

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
      alignment: AlignmentDirectional(0.00, 0.00),
      child: Container(
        width: valueOrDefault<double>(
          () {
            if (MediaQuery.sizeOf(context).width <
                valueOrDefault<double>(
                  kBreakpointSmall,
                  400.0,
                )) {
              return 320.0;
            } else if (MediaQuery.sizeOf(context).width <
                valueOrDefault<double>(
                  kBreakpointMedium,
                  1025.0,
                )) {
              return 420.0;
            } else if (MediaQuery.sizeOf(context).width <
                valueOrDefault<double>(
                  kBreakpointLarge,
                  1500.0,
                )) {
              return 520.0;
            } else {
              return 620.0;
            }
          }(),
          320.0,
        ),
        height: valueOrDefault<double>(
          () {
            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
              return 260.0;
            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
              return 280.0;
            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
              return 300.0;
            } else {
              return 330.0;
            }
          }(),
          260.0,
        ),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 30.0,
              color: Color(0x33000000),
              offset: Offset(0.0, 2.0),
            )
          ],
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: AlignmentDirectional(-1.00, -1.00),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 15.0, 20.0, 15.0),
                child: Text(
                  'Remove an Account',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyMediumFamily),
                      ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
              child: RichText(
                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Are you sure that you want to remove ',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            color: Color(0xFF686868),
                            fontWeight: FontWeight.normal,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                    TextSpan(
                      text:
                          '${FFAppState().accountSelected.length.toString()} accounts',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text:
                          '? You won’t be able to see and receive notifications from it anymore.',
                      style: TextStyle(
                        color: Color(0xFF686868),
                      ),
                    )
                  ],
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.00, 1.00),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        text: 'No, keep it',
                        options: FFButtonOptions(
                          width: MediaQuery.sizeOf(context).width * 0.7,
                          height: 45.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Colors.black,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .titleSmallFamily),
                              ),
                          elevation: 3.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 0.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.00, 1.00),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          20.0, 15.0, 20.0, 15.0),
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
                          List<UsersRecord> buttonUsersRecordList =
                              snapshot.data!;
                          // Return an empty Container when the item does not exist.
                          if (snapshot.data!.isEmpty) {
                            return Container();
                          }
                          final buttonUsersRecord =
                              buttonUsersRecordList.isNotEmpty
                                  ? buttonUsersRecordList.first
                                  : null;
                          return FFButtonWidget(
                            onPressed: () async {
                              var dbHelper = DatabaseHelper();
                              var db = await dbHelper.db;
                              FFAppState()
                                  .deletionAccountList
                                  .value
                                  .forEach((data) async {
                                await db.insert('myDB', {
                                  'name': data,
                                  'date': getCurrentTimestamp
                                      .toString()
                                      .substring(
                                          0,
                                          getCurrentTimestamp
                                                  .toString()
                                                  .length -
                                              7)
                                });
                              });
                              FFAppState()
                                  .deletedAccountList
                                  .add(await db.query('myDB'));
                              print(await db.query('myDB'));
                              print(FFAppState().deletedAccountList.value);
                              FFAppState().subsAccountList.value.remove(
                                  FFAppState().deletionAccountList.value);
                              FFAppState()
                                  .subsAccountList
                                  .add(FFAppState().subsAccountList.value);
                              ;
                              // await currentUserReference?.update({
                              //   ...mapToFirestore({
                              //     'accountDeleted': FieldValue.arrayUnion(
                              //         FFAppState()
                              //             .deletionAccountList
                              //             .value
                              //             .map((e) {
                              //       return {
                              //         'name': e,
                              //         'date': getCurrentTimestamp,
                              //       };
                              //     }).toList())
                              //   })
                              // });

                              await currentUserReference?.update({
                                ...mapFromFirestore({
                                  'subscriptions': FieldValue.arrayRemove(
                                      FFAppState().deletionAccountList.value)
                                })
                              });
                              // onPressed: () async {
                              //   while (FFAppState().accountSelected.length != 0) {
                              //     _model.updatePage(() {
                              //       FFAppState().removeFromSubscriptions(
                              //           FFAppState().accountSelected.first);
                              //     });
                              //     FFAppState().addToAccountDeleted(
                              //         FFAppState().accountSelected.first);

                              //     await currentUserReference!.update({
                              //       ...mapToFirestore(
                              //         {
                              //           'accountDeleted': FieldValue.arrayUnion([
                              //             getAccountsDeletedFirestoreData(
                              //               createAccountsDeletedStruct(
                              //                 name: FFAppState()
                              //                     .accountSelected
                              //                     .first,
                              //                 date: getCurrentTimestamp,
                              //                 clearUnsetFields: false,
                              //               ),
                              //               true,
                              //             )
                              //           ]),
                              //         },
                              //       ),
                              //     });

                              //     await currentUserReference!.update({
                              //       ...mapToFirestore(
                              //         {
                              //           'subscriptions': FieldValue.arrayRemove(
                              //               [FFAppState().accountSelected.first]),
                              //         },
                              //       ),
                              //     });

                              //     await buttonUsersRecord!.reference.update({
                              //       ...mapToFirestore(
                              //         {
                              //           'subscriptions': FieldValue.arrayRemove(
                              //               [FFAppState().accountSelected.first]),
                              //         },
                              //       ),
                              //     });
                              //     setState(() {
                              //       FFAppState()
                              //           .removeAtIndexFromAccountSelected(0);
                              //     });
                              //   }
                              FFAppState().update(() {
                                FFAppState().deletionAccountList.value.clear();
                                FFAppState().deletionAccountList.add(
                                    FFAppState().deletionAccountList.value);
                              });
                              Navigator.pop(context);
                            },
                            text: 'Yes, remove',
                            options: FFButtonOptions(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 45.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Colors.white,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleSmallFamily,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .titleSmallFamily),
                                  ),
                              elevation: 3.0,
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
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
          ],
        ),
      ),
    );
  }
}
