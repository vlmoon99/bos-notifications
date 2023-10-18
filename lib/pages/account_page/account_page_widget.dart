import '/components/subscribe_bottom_bar/subscribe_bottom_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
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
    context.watch<FFAppState>();

    return Title(
        title: 'AccountPage',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
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
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            enableDrag: false,
                            context: context,
                            builder: (context) {
                              return GestureDetector(
                                onTap: () => _model.unfocusNode.canRequestFocus
                                    ? FocusScope.of(context)
                                        .requestFocus(_model.unfocusNode)
                                    : FocusScope.of(context).unfocus(),
                                child: Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: Container(
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.5,
                                    child: SubscribeBottomBarWidget(),
                                  ),
                                ),
                              );
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
                  mainAxisSize: MainAxisSize.max,
                  children: [
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
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 25.0, 15.0, 25.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.7,
                          height: 40.0,
                          constraints: BoxConstraints(
                            maxWidth: 300.0,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F5EF),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: FlutterFlowIconButton(
                                  borderColor: Color(0x004B39EF),
                                  borderRadius: 30.0,
                                  buttonSize: 45.0,
                                  fillColor: Color(0x004B39EF),
                                  icon: Icon(
                                    Icons.search,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                  onPressed: () {
                                    print('IconButton pressed ...');
                                  },
                                ),
                              ),
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
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  child: TextFormField(
                                    controller: _model.textController,
                                    autofocus: true,
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
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
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
                            ],
                          ),
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
