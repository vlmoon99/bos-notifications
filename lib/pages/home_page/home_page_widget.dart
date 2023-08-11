import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/not_found_any_accounts/not_found_any_accounts_widget.dart';
import '/components/subscribe_bottom_bar/subscribe_bottom_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.latestBlockHeight = await GetMainNetLatestBlockHeightCall.call();
      if ((_model.latestBlockHeight?.succeeded ?? true)) {
        setState(() {
          FFAppState().latestBlockHeight = getJsonField(
            (_model.latestBlockHeight?.jsonBody ?? ''),
            r'''$.result.sync_info.latest_block_height''',
          );
        });
        _model.userSubscriptions = await querySubscriptionsRecordOnce(
          parent: currentUserReference,
          singleRecord: true,
        ).then((s) => s.firstOrNull);
      } else {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Network Error',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            duration: Duration(milliseconds: 350),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );
        return;
      }

      setState(() {
        FFAppState().subscriptions =
            _model.userSubscriptions!.subscriptions.toList().cast<String>();
      });
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

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Builder(
                  builder: (context) {
                    final pageViewPages = FFAppState().subscriptions.toList();
                    if (pageViewPages.isEmpty) {
                      return Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 0.3,
                        child: NotFoundAnyAccountsWidget(),
                      );
                    }
                    return Container(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      child: PageView.builder(
                        controller: _model.pageViewController ??=
                            PageController(
                                initialPage: min(0, pageViewPages.length - 1)),
                        onPageChanged: (_) async {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                _model.pageViewCurrentIndex.toString(),
                                style: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              duration: Duration(milliseconds: 300),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).secondary,
                            ),
                          );
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: pageViewPages.length,
                        itemBuilder: (context, pageViewPagesIndex) {
                          final pageViewPagesItem =
                              pageViewPages[pageViewPagesIndex];
                          return Stack(
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 60.0, 0.0, 0.0),
                                  child: Container(
                                    width: 700.0,
                                    height:
                                        MediaQuery.sizeOf(context).height * 1.0,
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                      border: Border.all(
                                        color: Color(0x00FFFFFF),
                                      ),
                                    ),
                                    child: FlutterFlowWebView(
                                      content:
                                          'https://near.social/vlmoon.near/widget/NotificationFeed?accountId=${FFAppState().subscriptions[pageViewPagesIndex]}',
                                      bypass: true,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              1.0,
                                      verticalScroll: true,
                                      horizontalScroll: true,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, -1.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 16.0, 24.0, 0.0),
                                  child: SelectionArea(
                                      child: Text(
                                    valueOrDefault<String>(
                                      'Account :${valueOrDefault<String>(
                                        pageViewPagesItem,
                                        'noneaccount.near',
                                      )}',
                                      'vlmoon.near',
                                    ).maybeHandleOverflow(
                                      maxChars: 20,
                                      replacement: '…',
                                    ),
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .headlineMediumFamily,
                                          fontSize: () {
                                            if (MediaQuery.sizeOf(context)
                                                    .width <
                                                kBreakpointSmall) {
                                              return 20.0;
                                            } else if (MediaQuery.sizeOf(
                                                        context)
                                                    .width <
                                                kBreakpointMedium) {
                                              return 24.0;
                                            } else if (MediaQuery.sizeOf(
                                                        context)
                                                    .width <
                                                kBreakpointLarge) {
                                              return 35.0;
                                            } else {
                                              return 24.0;
                                            }
                                          }(),
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .headlineMediumFamily),
                                        ),
                                  )),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                  child: Container(
                    width: () {
                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                        return 300.0;
                      } else if (MediaQuery.sizeOf(context).width <
                          kBreakpointMedium) {
                        return 350.0;
                      } else if (MediaQuery.sizeOf(context).width <
                          kBreakpointLarge) {
                        return 400.0;
                      } else {
                        return 300.0;
                      }
                    }(),
                    height: 100.0,
                    constraints: BoxConstraints(
                      maxWidth: 400.0,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).info,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 2.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, -1.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: FlutterFlowIconButton(
                                borderColor: Color(0x00FFFFFF),
                                borderRadius: 50.0,
                                borderWidth: 0.0,
                                buttonSize: 60.0,
                                fillColor:
                                    FlutterFlowTheme.of(context).nEARAqua,
                                icon: Icon(
                                  Icons.logout,
                                  color: FlutterFlowTheme.of(context).accent4,
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  GoRouter.of(context).prepareAuthEvent();
                                  await authManager.signOut();
                                  GoRouter.of(context).clearRedirectLocation();

                                  context.pushNamedAuth(
                                      'LoginPage', context.mounted);
                                },
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: FlutterFlowIconButton(
                                borderColor: Color(0x00FFFFFF),
                                borderRadius: 50.0,
                                borderWidth: 0.0,
                                buttonSize: 60.0,
                                fillColor:
                                    FlutterFlowTheme.of(context).nEARAqua,
                                icon: Icon(
                                  Icons.person_add_alt_1_sharp,
                                  color: FlutterFlowTheme.of(context).info,
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Color(0x00FFFFFF),
                                    barrierColor: Color(0x00FFFFFF),
                                    enableDrag: false,
                                    useSafeArea: true,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () => FocusScope.of(context)
                                            .requestFocus(_model.unfocusNode),
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: Container(
                                            height: 400.0,
                                            child: SubscribeBottomBarWidget(),
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => setState(() {}));
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            child: FlutterFlowIconButton(
                              borderColor: Color(0x00FFFFFF),
                              borderRadius: 50.0,
                              borderWidth: 0.0,
                              buttonSize: 60.0,
                              fillColor: FlutterFlowTheme.of(context).nEARAqua,
                              icon: Icon(
                                Icons.arrow_back,
                                color: FlutterFlowTheme.of(context).info,
                                size: 30.0,
                              ),
                              onPressed: () async {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Webview go back',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 550),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).secondary,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
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
