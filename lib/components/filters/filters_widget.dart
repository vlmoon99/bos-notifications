import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'filters_model.dart';
export 'filters_model.dart';

class FiltersWidget extends StatefulWidget {
  const FiltersWidget({Key? key}) : super(key: key);

  @override
  _FiltersWidgetState createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> {
  late FiltersModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FiltersModel());

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

    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 0.791,
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
            alignment: AlignmentDirectional(0.00, -1.00),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 25.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Filters',
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
                          fontWeight: FontWeight.w500,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyMediumFamily),
                        ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      setState(() {
                        FFAppState().updateFilterDataAtIndex(
                          0,
                          (_) => '',
                        );
                      });
                      setState(() {
                        FFAppState().updateFilterDataAtIndex(
                          1,
                          (_) => '',
                        );
                      });
                    },
                    text: 'Clear All',
                    options: FFButtonOptions(
                      height: 24.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Color(0x004B39EF),
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: Color(0xFF65C3A2),
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
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleSmallFamily),
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Group by Account',
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
                            return 14.0;
                          } else if (MediaQuery.sizeOf(context).width <
                              valueOrDefault<double>(
                                kBreakpointMedium,
                                1025.0,
                              )) {
                            return 17.0;
                          } else if (MediaQuery.sizeOf(context).width <
                              valueOrDefault<double>(
                                kBreakpointLarge,
                                1500.0,
                              )) {
                            return 20.0;
                          } else {
                            return 25.0;
                          }
                        }(),
                        fontWeight: FontWeight.w500,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyMediumFamily),
                      ),
                ),
                Switch.adaptive(
                  value: _model.switchValue ??= true,
                  onChanged: (newValue) async {
                    setState(() => _model.switchValue = newValue!);
                  },
                  activeColor: Colors.black,
                  activeTrackColor: Color(0xFF7EF4CA),
                  inactiveTrackColor: FlutterFlowTheme.of(context).alternate,
                  inactiveThumbColor:
                      FlutterFlowTheme.of(context).secondaryText,
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.0,
            indent: 25.0,
            endIndent: 25.0,
            color: Color(0xFFEDEEEE),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 25.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date Range',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        fontSize: () {
                          if (MediaQuery.sizeOf(context).width <
                              valueOrDefault<double>(
                                kBreakpointSmall,
                                400.0,
                              )) {
                            return 14.0;
                          } else if (MediaQuery.sizeOf(context).width <
                              valueOrDefault<double>(
                                kBreakpointMedium,
                                1025.0,
                              )) {
                            return 17.0;
                          } else if (MediaQuery.sizeOf(context).width <
                              valueOrDefault<double>(
                                kBreakpointLarge,
                                1500.0,
                              )) {
                            return 20.0;
                          } else {
                            return 25.0;
                          }
                        }(),
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyMediumFamily),
                      ),
                ),
                Container(
                  width: () {
                    if (MediaQuery.sizeOf(context).width <
                        valueOrDefault<double>(
                          kBreakpointSmall,
                          400.0,
                        )) {
                      return 200.0;
                    } else if (MediaQuery.sizeOf(context).width <
                        valueOrDefault<double>(
                          kBreakpointMedium,
                          1025.0,
                        )) {
                      return 300.0;
                    } else if (MediaQuery.sizeOf(context).width <
                        valueOrDefault<double>(
                          kBreakpointLarge,
                          1500.0,
                        )) {
                      return 400.0;
                    } else {
                      return 500.0;
                    }
                  }(),
                  height: () {
                    if (MediaQuery.sizeOf(context).width <
                        valueOrDefault<double>(
                          kBreakpointSmall,
                          400.0,
                        )) {
                      return 30.0;
                    } else if (MediaQuery.sizeOf(context).width <
                        valueOrDefault<double>(
                          kBreakpointMedium,
                          1025.0,
                        )) {
                      return 40.0;
                    } else if (MediaQuery.sizeOf(context).width <
                        valueOrDefault<double>(
                          kBreakpointLarge,
                          1500.0,
                        )) {
                      return 50.0;
                    } else {
                      return 60.0;
                    }
                  }(),
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: FFButtonWidget(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    text: '${valueOrDefault<String>(
                      FFAppState().filterData.first,
                      'select data',
                    )}-${valueOrDefault<String>(
                      FFAppState().filterData.last,
                      'select data',
                    )}',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Color(0x004B39EF),
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: Color(0xFF7E7E7E),
                            fontSize: () {
                              if (MediaQuery.sizeOf(context).width <
                                  valueOrDefault<double>(
                                    kBreakpointSmall,
                                    400.0,
                                  )) {
                                return 14.0;
                              } else if (MediaQuery.sizeOf(context).width <
                                  valueOrDefault<double>(
                                    kBreakpointMedium,
                                    1025.0,
                                  )) {
                                return 17.0;
                              } else if (MediaQuery.sizeOf(context).width <
                                  valueOrDefault<double>(
                                    kBreakpointLarge,
                                    1500.0,
                                  )) {
                                return 20.0;
                              } else {
                                return 25.0;
                              }
                            }(),
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleSmallFamily),
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          FlutterFlowCalendar(
            color: Color(0xFF65C3A2),
            iconColor: Color(0xFF65C3A2),
            weekFormat: false,
            weekStartsMonday: false,
            rowHeight: 60.0,
            onChange: (DateTimeRange? newSelectedDate) {
              setState(() => _model.calendarSelectedDay = newSelectedDate);
            },
            titleStyle: FlutterFlowTheme.of(context).headlineSmall.override(
                  fontFamily: FlutterFlowTheme.of(context).headlineSmallFamily,
                  fontSize: 20.0,
                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                      FlutterFlowTheme.of(context).headlineSmallFamily),
                ),
            dayOfWeekStyle: FlutterFlowTheme.of(context).labelLarge.override(
                  fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                      FlutterFlowTheme.of(context).labelLargeFamily),
                  lineHeight: 1.0,
                ),
            dateStyle: FlutterFlowTheme.of(context).bodyMedium,
            selectedDateStyle: FlutterFlowTheme.of(context).titleSmall,
            inactiveDateStyle: FlutterFlowTheme.of(context).labelMedium,
            locale: FFLocalizations.of(context).languageCode,
          ),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional(0.00, 0.00),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FFButtonWidget(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    text: 'Cancel',
                    options: FFButtonOptions(
                      width: () {
                        if (MediaQuery.sizeOf(context).width <
                            valueOrDefault<double>(
                              kBreakpointSmall,
                              400.0,
                            )) {
                          return 150.0;
                        } else if (MediaQuery.sizeOf(context).width <
                            valueOrDefault<double>(
                              kBreakpointMedium,
                              1025.0,
                            )) {
                          return 200.0;
                        } else if (MediaQuery.sizeOf(context).width <
                            valueOrDefault<double>(
                              kBreakpointLarge,
                              1500.0,
                            )) {
                          return 250.0;
                        } else {
                          return 300.0;
                        }
                      }(),
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Colors.white,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleSmallFamily),
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      if (FFAppState().filterData.first == null ||
                          FFAppState().filterData.first == '') {
                        setState(() {
                          FFAppState().updateFilterDataAtIndex(
                            0,
                            (_) => dateTimeFormat(
                              'yMMMd',
                              _model.calendarSelectedDay!.start,
                              locale: FFLocalizations.of(context).languageCode,
                            ),
                          );
                        });
                      } else {
                        if (FFAppState().filterData.last == null ||
                            FFAppState().filterData.last == '') {
                          setState(() {
                            FFAppState().updateFilterDataAtIndex(
                              1,
                              (_) => dateTimeFormat(
                                'yMMMd',
                                _model.calendarSelectedDay!.start,
                                locale:
                                    FFLocalizations.of(context).languageCode,
                              ),
                            );
                          });
                        }
                      }
                    },
                    text: 'Apply',
                    options: FFButtonOptions(
                      width: () {
                        if (MediaQuery.sizeOf(context).width <
                            valueOrDefault<double>(
                              kBreakpointSmall,
                              400.0,
                            )) {
                          return 150.0;
                        } else if (MediaQuery.sizeOf(context).width <
                            valueOrDefault<double>(
                              kBreakpointMedium,
                              1025.0,
                            )) {
                          return 200.0;
                        } else if (MediaQuery.sizeOf(context).width <
                            valueOrDefault<double>(
                              kBreakpointLarge,
                              1500.0,
                            )) {
                          return 250.0;
                        } else {
                          return 300.0;
                        }
                      }(),
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Colors.black,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleSmallFamily),
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
