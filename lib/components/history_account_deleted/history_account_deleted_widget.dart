import '/auth/firebase_auth/auth_util.dart';
import '/backend/schema/structs/index.dart';
import '/components/account_deleted/account_deleted_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'history_account_deleted_model.dart';
export 'history_account_deleted_model.dart';
import 'package:b_o_s_notifications/pages/settings_page/settings_page_widget.dart';

class HistoryAccountDeletedWidget extends StatefulWidget {
  const HistoryAccountDeletedWidget({Key? key}) : super(key: key);

  @override
  _HistoryAccountDeletedWidgetState createState() =>
      _HistoryAccountDeletedWidgetState();
}

class _HistoryAccountDeletedWidgetState
    extends State<HistoryAccountDeletedWidget> {
  late HistoryAccountDeletedModel _model;
  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HistoryAccountDeletedModel());

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

    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          print('hello');
          FFAppState().update(() {
            FFAppState().historyOnOff.add(false);
          });
        }
      },
      child: Align(
        alignment: AlignmentDirectional(0.00, 0.00),
        child: Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: MediaQuery.sizeOf(context).height * 1.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Align(
            alignment: AlignmentDirectional(0.00, 1.00),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(25.0, 30.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FlutterFlowIconButton(
                        borderRadius: 20.0,
                        borderWidth: 1.0,
                        buttonSize: 40.0,
                        icon: FaIcon(
                          FontAwesomeIcons.angleLeft,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          setState(() {
                            FFAppState().update(() {
                              FFAppState().historyOnOff.add(false);
                            });
                          });
                        },
                      ),
                      Text(
                        'History of deleted accounts',
                        textScaleFactor: 1,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(0.00, -1.00),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 1.0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.85,
                        height: MediaQuery.sizeOf(context).height * 1.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.00, -1.00),
                          child: AuthUserStreamWidget(
                            builder: (context) => Builder(
                              builder: (context) {
                                return StreamBuilder<
                                        List<Map<String, dynamic>>>(
                                    stream: FFAppState().deletedAccountList,
                                    builder: (context, snapshot) {
                                      List<Map<String, dynamic>>
                                          deletedAccountList =
                                          snapshot.data ?? [];
                                      return ListView.separated(
                                        padding: EdgeInsets.zero,
                                        scrollDirection: Axis.vertical,
                                        itemCount: deletedAccountList.length,
                                        separatorBuilder: (_, __) =>
                                            SizedBox(height: 15.0),
                                        itemBuilder:
                                            (context, accountDeletedListIndex) {
                                          final accountDeletedListItem =
                                              deletedAccountList[
                                                  accountDeletedListIndex];
                                          return Container(
                                            key: Key(
                                                'Key6mz_${accountDeletedListIndex}_of_${deletedAccountList.length}'),
                                            height: () {
                                              if (accountDeletedListIndex ==
                                                  0) {
                                                return 70.0;
                                              } else if (dateTimeFormat(
                                                    'd/M/y',
                                                    DateTime.parse(
                                                        accountDeletedListItem[
                                                            'date']),
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  ) !=
                                                  dateTimeFormat(
                                                    'd/M/y',
                                                    DateTime.parse(
                                                        (deletedAccountList ??
                                                                [])[
                                                            accountDeletedListIndex -
                                                                1]['date']),
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  )) {
                                                return 70.0;
                                              } else {
                                                return 50.0;
                                              }
                                            }(),
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.00, 0.00),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  if (() {
                                                    if (accountDeletedListIndex ==
                                                        0) {
                                                      return true;
                                                    } else if (dateTimeFormat(
                                                          'd/M/y',
                                                          DateTime.parse(
                                                              accountDeletedListItem[
                                                                  'date']),
                                                          locale:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .languageCode,
                                                        ) !=
                                                        dateTimeFormat(
                                                          'd/M/y',
                                                          DateTime.parse(
                                                              (deletedAccountList ??
                                                                      [])[
                                                                  accountDeletedListIndex -
                                                                      1]['date']),
                                                          locale:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .languageCode,
                                                        )) {
                                                      return true;
                                                    } else {
                                                      return false;
                                                    }
                                                  }())
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.00, 0.00),
                                                      child: Text(
                                                        dateTimeFormat(
                                                          'd/M/y',
                                                          DateTime.parse(
                                                              accountDeletedListItem[
                                                                  'date']),
                                                          locale:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .languageCode,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                      ),
                                                    ),
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.00, 1.00),
                                                      child:
                                                          AccountDeletedWidget(
                                                        name: (deletedAccountList ??
                                                                    [])[
                                                                accountDeletedListIndex]
                                                            ['name'],
                                                        dataDeleted: DateTime.parse(
                                                            (deletedAccountList ??
                                                                        [])[
                                                                    accountDeletedListIndex]
                                                                ['date']),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    });
                              },
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
        ),
      ),
    );
  }
}
