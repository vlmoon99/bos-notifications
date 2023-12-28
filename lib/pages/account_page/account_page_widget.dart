import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/components/account_deleting_dialog/account_deleting_dialog_widget.dart';
import '/components/subscribe_bottom_bar/subscribe_bottom_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'account_page_model.dart';
export 'account_page_model.dart';

class AccountPageWidget extends StatefulWidget {
  const AccountPageWidget({Key? key}) : super(key: key);

  @override
  _AccountPageWidgetState createState() => _AccountPageWidgetState();
}

class _AccountPageWidgetState extends State<AccountPageWidget> {
  late AccountPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AccountPageModel());

    _model.textController ??= TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        setState(() {
          FFAppState().accountSelected = [];
        });
        FFAppState().update(() {
          FFAppState().deletionAccountList.value.clear();
          FFAppState()
              .deletionAccountList
              .add(FFAppState().deletionAccountList.value);
        });
        setState(() {
          FFAppState().selectAccounts = false;
        });
      },
      child: Title(
          title: 'AccountPage',
          color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFFF5F5EF),
            appBar: AppBar(
              backgroundColor: Color(0x004B39EF),
              automaticallyImplyLeading: false,
              title: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Account',
                      textScaleFactor: 1,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontSize: 24.0,
                            fontWeight: FontWeight.normal,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ],
                ),
              ),
              actions: [],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(70.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 25.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      height: 40.0,
                      constraints: BoxConstraints(
                        maxWidth: 300.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: FFButtonWidget(
                        onPressed: () async {
                          setState(() {
                            FFAppState().tapButton = true;
                          });
                          await showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            enableDrag: false,
                            context: context,
                            builder: (context) {
                              return SubscribeBottomBarWidget();
                            },
                          ).then((value) => safeSetState(() {}));

                          setState(() {
                            FFAppState().tapButton = false;
                          });
                        },
                        text: 'Add a new Account',
                        icon: Icon(
                          Icons.add,
                          size: 15.0,
                        ),
                        options: FFButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FFAppState().tapButton
                              ? Color(0xCD7EF4CA)
                              : Colors.black,
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
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          25.0, 25.0, 25.0, 15.0),
                      child: Container(
                        constraints:
                            BoxConstraints(minWidth: 400, maxWidth: 524),
                        width: MediaQuery.sizeOf(context).width * 0.7,
                        height: 45.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5EF),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 45,
                              width: 45,
                              child: InkWell(
                                child: SvgPicture.asset(
                                  'assets/icons/Icon_search.svg',
                                  fit: BoxFit.none,
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                child: TextField(
                                  controller: _model.textController,
                                  onChanged: (_) => EasyDebounce.debounce(
                                    '_model.textController',
                                    Duration(milliseconds: 100),
                                    () async {
                                      setState(() {
                                        FFAppState().searchAccount =
                                            _model.textController.text;
                                      });
                                    },
                                  ),
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Search by Account ID or Name',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelMediumFamily,
                                          color: Color(0xFFBDBDBD),
                                          fontSize: 12.0,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .labelMediumFamily),
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
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
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 10.0),
                      child: Container(
                        constraints:
                            BoxConstraints(minWidth: 400, maxWidth: 524),
                        width: MediaQuery.sizeOf(context).width * 0.7,
                        height: 30.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Accounts',
                              textScaleFactor: 1,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                  ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(1.00, 1.00),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    FFAppState().accountSelected = [];
                                  });
                                  FFAppState().update(() {
                                    FFAppState()
                                        .deletionAccountList
                                        .value
                                        .clear();
                                    FFAppState().deletionAccountList.add(
                                        FFAppState().deletionAccountList.value);
                                  });
                                  setState(() {
                                    FFAppState().selectAccounts =
                                        !FFAppState().selectAccounts;
                                  });
                                },
                                child: Text(
                                  valueOrDefault<String>(
                                    FFAppState().selectAccounts
                                        ? 'Cancel'
                                        : 'Select',
                                    'Select',
                                  ),
                                  textScaleFactor: 1,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: Color(0xFF65C3A2),
                                        fontWeight: FontWeight.bold,
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
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            25.0, 0.0, 25.0, 0.0),
                        child: Container(
                          height: MediaQuery.sizeOf(context).height,
                          constraints:
                              BoxConstraints(minWidth: 400, maxWidth: 524),
                          width: MediaQuery.sizeOf(context).width * 0.7,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: AuthUserStreamWidget(
                            builder: (context) => Builder(
                              builder: (context) {
                                final accounts =
                                    (currentUserDocument!.subscriptions);
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: accounts.length,
                                  itemBuilder: (context, accountsIndex) {
                                    final accountsItem =
                                        accounts[accountsIndex];
                                    return Visibility(
                                      visible: (_model.textController.text ==
                                                  null ||
                                              _model.textController.text ==
                                                  '') ||
                                          accountsItem.toLowerCase().startsWith(
                                              _model.textController.text
                                                  .toLowerCase()),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            if (FFAppState().selectAccounts ==
                                                true) {
                                              if (FFAppState()
                                                  .deletionAccountList
                                                  .value
                                                  .contains(accountsItem)) {
                                                setState(() {
                                                  FFAppState()
                                                      .deletionAccountList
                                                      .value
                                                      .remove(accountsItem);
                                                  FFAppState()
                                                      .deletionAccountList
                                                      .add(FFAppState()
                                                          .deletionAccountList
                                                          .value);
                                                  FFAppState()
                                                      .removeFromAccountSelected(
                                                          accountsItem);
                                                  FFAppState()
                                                      .removeFromAccountSelected(
                                                          accountsItem);
                                                });
                                              } else {
                                                setState(() {
                                                  FFAppState()
                                                      .deletionAccountList
                                                      .value
                                                      .add(accountsItem);
                                                  FFAppState()
                                                      .deletionAccountList
                                                      .add(FFAppState()
                                                          .deletionAccountList
                                                          .value);
                                                  FFAppState()
                                                      .addToAccountSelected(
                                                          accountsItem);
                                                });
                                              }
                                            }
                                            ;
                                          },
                                          onLongPress: () async {
                                            setState(() {
                                              FFAppState().selectAccounts =
                                                  true;
                                            });
                                            if (FFAppState()
                                                .deletionAccountList
                                                .value
                                                .contains(accountsItem)) {
                                              FFAppState().update(() {
                                                FFAppState()
                                                    .deletionAccountList
                                                    .value
                                                    .remove(accountsItem);
                                                FFAppState()
                                                    .deletionAccountList
                                                    .add(FFAppState()
                                                        .deletionAccountList
                                                        .value);
                                                FFAppState()
                                                    .removeFromAccountSelected(
                                                        accountsItem);
                                              });
                                            } else {
                                              FFAppState().update(() {
                                                FFAppState()
                                                    .deletionAccountList
                                                    .value
                                                    .add(accountsItem);
                                                FFAppState()
                                                    .deletionAccountList
                                                    .add(FFAppState()
                                                        .deletionAccountList
                                                        .value);
                                                FFAppState()
                                                    .addToAccountSelected(
                                                        accountsItem);
                                              });
                                            }
                                            if (FFAppState()
                                                .deletionAccountList
                                                .value
                                                .isEmpty) {
                                              FFAppState().selectAccounts =
                                                  false;
                                            }
                                            ;
                                          },
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.7,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.06,
                                            constraints: BoxConstraints(
                                              minWidth: 400,
                                              maxWidth: 524,
                                              maxHeight: 60.0,
                                              minHeight: 50,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFAF9F8),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(2.0, 3.0, 2.0, 3.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(3.0, 0.0,
                                                                7.0, 0.0),
                                                    child: Container(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      clipBehavior: Clip
                                                          .antiAliasWithSaveLayer,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            'https://i.near.social/magic/large/https://near.social/magic/img/account/$accountsItem',
                                                        errorWidget: (context,
                                                            url, error) {
                                                          return SvgPicture
                                                              .network(
                                                            'https://i.near.social/magic/large/https://near.social/magic/img/account/$accountsItem',
                                                            fit: BoxFit.cover,
                                                          );
                                                        },
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          accountsItem,
                                                          textScaleFactor: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.00, 0.00),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    3.0,
                                                                    0.0),
                                                        child: Stack(
                                                          children: [
                                                            if (FFAppState()
                                                                    .selectAccounts &&
                                                                FFAppState()
                                                                    .deletionAccountList
                                                                    .value
                                                                    .contains(
                                                                        accountsItem))
                                                              InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  if (FFAppState()
                                                                      .deletionAccountList
                                                                      .value
                                                                      .contains(
                                                                          accountsItem)) {
                                                                    setState(
                                                                        () {
                                                                      FFAppState()
                                                                          .deletionAccountList
                                                                          .value
                                                                          .remove(
                                                                              accountsItem);
                                                                      FFAppState()
                                                                          .deletionAccountList
                                                                          .add(FFAppState()
                                                                              .deletionAccountList
                                                                              .value);
                                                                      FFAppState()
                                                                          .removeFromAccountSelected(
                                                                              accountsItem);
                                                                      FFAppState()
                                                                          .removeFromAccountSelected(
                                                                              accountsItem);
                                                                    });
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      FFAppState()
                                                                          .deletionAccountList
                                                                          .value
                                                                          .add(
                                                                              accountsItem);
                                                                      FFAppState()
                                                                          .deletionAccountList
                                                                          .add(FFAppState()
                                                                              .deletionAccountList
                                                                              .value);
                                                                      FFAppState()
                                                                          .addToAccountSelected(
                                                                              accountsItem);
                                                                    });
                                                                  }
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              10),
                                                                  child: SvgPicture
                                                                      .asset(
                                                                          'assets/icons/boxon.svg'),
                                                                ),
                                                              ),
                                                            if (FFAppState()
                                                                    .selectAccounts &&
                                                                !FFAppState()
                                                                    .accountSelected
                                                                    .contains(
                                                                        accountsItem))
                                                              InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  if (FFAppState()
                                                                      .accountSelected
                                                                      .contains(
                                                                          accountsItem)) {
                                                                    FFAppState()
                                                                        .update(
                                                                            () {
                                                                      FFAppState()
                                                                          .deletionAccountList
                                                                          .value
                                                                          .remove(
                                                                              accountsItem);
                                                                      FFAppState()
                                                                          .deletionAccountList
                                                                          .add(FFAppState()
                                                                              .deletionAccountList
                                                                              .value);
                                                                      FFAppState()
                                                                          .removeFromAccountSelected(
                                                                              accountsItem);
                                                                    });
                                                                  } else {
                                                                    FFAppState()
                                                                        .update(
                                                                            () {
                                                                      FFAppState()
                                                                          .deletionAccountList
                                                                          .value
                                                                          .add(
                                                                              accountsItem);
                                                                      FFAppState()
                                                                          .deletionAccountList
                                                                          .add(FFAppState()
                                                                              .deletionAccountList
                                                                              .value);
                                                                      FFAppState()
                                                                          .addToAccountSelected(
                                                                              accountsItem);
                                                                    });
                                                                  }
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              10),
                                                                  child: SvgPicture
                                                                      .asset(
                                                                          'assets/icons/boxoff.svg'),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  if (!FFAppState()
                                                      .selectAccounts)
                                                    Expanded(
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                1.00, 0.00),
                                                        child: Builder(
                                                          builder: (context) =>
                                                              Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        3.0,
                                                                        0.0),
                                                            child: InkWell(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            10),
                                                                child: SvgPicture
                                                                    .asset(
                                                                        'assets/icons/trash.svg'),
                                                              ),
                                                              onTap: () async {
                                                                await showAlignedDialog(
                                                                  context:
                                                                      context,
                                                                  isGlobal:
                                                                      true,
                                                                  avoidOverflow:
                                                                      false,
                                                                  targetAnchor: AlignmentDirectional(
                                                                          0.0,
                                                                          0.0)
                                                                      .resolve(
                                                                          Directionality.of(
                                                                              context)),
                                                                  followerAnchor: AlignmentDirectional(
                                                                          0.0,
                                                                          0.0)
                                                                      .resolve(
                                                                          Directionality.of(
                                                                              context)),
                                                                  builder:
                                                                      (dialogContext) {
                                                                    return Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          AccountDeletingDialogWidget(
                                                                        name:
                                                                            accountsItem,
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    setState(
                                                                        () {}));
                                                              },
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
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
