import 'package:b_o_s_notifications/auth/firebase_auth/auth_util.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:b_o_s_notifications/backend/api_requests/api_calls.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rxdart/subjects.dart';
import '/components/filters/filters_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  final ScrollController scrollController = ScrollController();
  final ScrollController scrollControllerForFilter = ScrollController();

  List pastAccounts = [];
  List detectDuplicate = [];
  @override
  void initState() {
    if (FFAppState().filterData.first != '' &&
        FFAppState().filterData.last != '') {
      initNotificationsForFilter();
    } else {
      initNotifications();
    }
    super.initState();
    _model = createModel(context, () => HomePageModel());

    _model.textController ??= TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    bool pause = true;
    scrollControllerForFilter.addListener(() async {
      if (scrollControllerForFilter.position.pixels >=
              scrollControllerForFilter.position.maxScrollExtent - 1500 &&
          pause) {
        pause = false;
        // ИСПОЛНЯЕМЫЙ КОД

        //СОЗДАНИЕ СОРТИРОВОЧНОГО ЛИСТА, ЛОКАЛЬНОГО ПРЕДЕЛЬНОГО БЛОКА И ОБНУЛЕНИЕ ГЛОБАЛЬНОГО ПРЕДЕЛЬНОГО БЛОКА.
        List sortList = [];
        int localLastBlockHeight = FFAppState().lastBlockHeight!;
        FFAppState().lastBlockHeight = null;
        List listAccounts =
            List.from(FFAppState().listAccountForNotifications.value);
        await Future.forEach(listAccounts, (account) async {
          //Апи запрос и получение данных.
          ApiCallResponse notificationsAPI =
              await GetNotificationsByUserIdWithFromValueCall.call(
                  accountId: account, from: localLastBlockHeight - 1);
          List notifications = notificationsAPI.jsonBody;

          //удаление аккаунта из потенциальных аккаунтов при условии
          if (notifications.length != 20 ||
              notifications.last['blockHeight'] < FFAppState().endRes) {
            FFAppState().listAccountForNotifications.value.remove(account);
            FFAppState()
                .listAccountForNotifications
                .add(FFAppState().listAccountForNotifications.value);
          }

          //обозначение общего предельного блока
          if (FFAppState().lastBlockHeight == null ||
              FFAppState().lastBlockHeight! <
                  notifications.last['blockHeight']) {
            FFAppState().lastBlockHeight = notifications.last['blockHeight'];
          }

          //ДОБАВЛЕНИЕ ДЛЯ КАЖДОГО ЭЛЕМЕНТА ВРЕМЕНИ И ДОБАВЛЕНИЕ ЭЛЕМЕНТА В СОРТИРОВКУ.
          await Future.forEach(notifications, (notif) {
            //Вычисление времени
            int blockHeightInNotification = notif['blockHeight'];
            int blockHeightInGlobal = FFAppState().blockHID!;
            int secondsForSubstract =
                blockHeightInGlobal - blockHeightInNotification;
            DateTime TimeForNomberOneNotify =
                DateTime.fromMillisecondsSinceEpoch(FFAppState().currentTime!);
            DateTime TimeForCurrentNotify = TimeForNomberOneNotify.subtract(
                Duration(seconds: secondsForSubstract));
            int unixTimeForNotify = TimeForCurrentNotify.millisecondsSinceEpoch;

            //Добавление элемента в сортировку
            sortList.add([notif, unixTimeForNotify, account]);
          });
        });
        //SORT
        await Future.microtask(
          () {
            print(sortList.length);
            sortList.removeWhere((element) =>
                element[0]['blockHeight'] < FFAppState().lastBlockHeight!);

            sortList.sort(
                (a, b) => b[0]['blockHeight'].compareTo(a[0]['blockHeight']));
            print('$sortList');
            sortList.removeWhere(
                (element) => element[0]['blockHeight'] < FFAppState().endRes);
          },
        );
        //добавление в лист
        FFAppState()
            .streamNotifications
            .add(FFAppState().streamNotifications.value + sortList);
        //ПАУЗА
        await Future.delayed(Duration(milliseconds: 500));
        pause = true;
      }
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 1500 &&
          pause) {
        pause = false;
        // ИСПОЛНЯЕМЫЙ КОД

        //СОЗДАНИЕ СОРТИРОВОЧНОГО ЛИСТА, ЛОКАЛЬНОГО ПРЕДЕЛЬНОГО БЛОКА И ОБНУЛЕНИЕ ГЛОБАЛЬНОГО ПРЕДЕЛЬНОГО БЛОКА.
        Set timeSet = {};
        List sortList = [];
        int localLastBlockHeight = FFAppState().lastBlockHeight!;
        FFAppState().lastBlockHeight = null;

        List listAccounts =
            List.from(FFAppState().listAccountForNotifications.value);
        print(listAccounts);
        await Future.forEach(listAccounts, (account) async {
          //Апи запрос и получение данных.
          ApiCallResponse notificationsAPI =
              await GetNotificationsByUserIdWithFromValueCall.call(
                  accountId: account, from: localLastBlockHeight - 1);
          List notifications = notificationsAPI.jsonBody;

          //удаление аккаунта из потенциальных аккаунтов при условии
          if (notifications.length != 20) {
            FFAppState().listAccountForNotifications.value.remove(account);
            FFAppState()
                .listAccountForNotifications
                .add(FFAppState().listAccountForNotifications.value);
          }

          //обозначение общего предельного блока
          if (FFAppState().lastBlockHeight == null ||
              FFAppState().lastBlockHeight! <
                  notifications.last['blockHeight']) {
            FFAppState().lastBlockHeight = notifications.last['blockHeight'];
          }

          //ДОБАВЛЕНИЕ ДЛЯ КАЖДОГО ЭЛЕМЕНТА ВРЕМЕНИ И ДОБАВЛЕНИЕ ЭЛЕМЕНТА В СОРТИРОВКУ.
          await Future.forEach(notifications, (notif) {
            //Вычисление времени
            int blockHeightInNotification = notif['blockHeight'];
            int blockHeightInGlobal = FFAppState().blockHID!;
            int secondsForSubstract =
                blockHeightInGlobal - blockHeightInNotification;
            DateTime TimeForNomberOneNotify =
                DateTime.fromMillisecondsSinceEpoch(FFAppState().currentTime!);
            DateTime TimeForCurrentNotify = TimeForNomberOneNotify.subtract(
                Duration(seconds: secondsForSubstract));
            int unixTimeForNotify = TimeForCurrentNotify.millisecondsSinceEpoch;

            //Добавление элемента в сортировку
            timeSet.add(unixTimeForNotify);
            sortList.add([notif, unixTimeForNotify, account]);
          });
        });
        //сортировка
        await Future.microtask(
          () {
            print(timeSet.length);
            print(sortList.length);
            sortList.removeWhere((element) =>
                element[0]['blockHeight'] < FFAppState().lastBlockHeight!);

            sortList
              ..sort(
                  (a, b) => b[0]['blockHeight'].compareTo(a[0]['blockHeight']));
            print('$sortList');
          },
        );

        //добавление в лист
        FFAppState()
            .streamNotifications
            .add(FFAppState().streamNotifications.value + sortList);
        //ПАУЗА
        await Future.delayed(Duration(milliseconds: 500));
        pause = true;
      }
    });

    // scrollControllerForFilter.addListener(() async {
    //   if (scrollControllerForFilter.position.pixels >=
    //           scrollControllerForFilter.position.maxScrollExtent - 1500 &&
    //       pause) {
    //     int myLastBlockId = 0;
    //     List accountList =
    //         List.from(FFAppState().listAccountForNotifications.value);
    //     // print(FFAppState().listAccountForNotifications.value);
    //     // print(accountList);
    //     // print(FFAppState().streamNotifications.value.length);

    //     pause = false;

    //     // print('hello');
    //     FFAppState().sortStreamNotifications.add([]);
    //     print('hello');
    //     await Future.forEach(accountList, (element) async {
    //       int timeUNIXresult;
    //       ApiCallResponse value =
    //           await GetNotificationsByUserIdWithFromValueCall.call(
    //         accountId: element['name'],
    //         from: element['lastBlockHeight'],
    //       );
    //       List result = value.jsonBody;
    //       Future.forEach(result, (element) {
    //         DateTime originalDate =
    //             DateTime.fromMillisecondsSinceEpoch(FFAppState().currentTime!);
    //         Duration durationToSubtract = Duration(
    //             seconds:
    //                 (FFAppState().blockHID! - element['blockHeight']).toInt());
    //         DateTime newDate =
    //             originalDate.toUtc().subtract(durationToSubtract).toLocal();
    //         timeUNIXresult = newDate.millisecondsSinceEpoch;
    //         FFAppState()
    //             .sortStreamNotifications
    //             .value
    //             .add([element, timeUNIXresult]);

    //         FFAppState()
    //             .sortStreamNotifications
    //             .add(FFAppState().sortStreamNotifications.value);
    //       });

    //       FFAppState().listAccountForNotifications.value.remove(element);
    //       FFAppState()
    //           .listAccountForNotifications
    //           .add(FFAppState().listAccountForNotifications.value);
    //       if (result.length >= 10) {
    //         FFAppState().update(
    //           () {
    //             FFAppState().listAccountForNotifications.value.add({
    //               'name': element['name'],
    //               'lastBlockHeight': result.last['blockHeight'],
    //             });
    //             FFAppState()
    //                 .listAccountForNotifications
    //                 .add(FFAppState().listAccountForNotifications.value);
    //           },
    //         );

    //         if (myLastBlockId < result.last['blockHeight']) {
    //           myLastBlockId = result.last['blockHeight'];
    //         }
    //       }
    //     });

    //     FFAppState().sortStreamNotifications.value.removeWhere(
    //         (element) => element[0]['blockHeight'] < myLastBlockId);
    //     FFAppState()
    //         .sortStreamNotifications
    //         .value
    //         .sort((a, b) => b[0]['blockHeight'].compareTo(a[0]['blockHeight']));
    //     if (FFAppState().sortStreamNotifications.value.isEmpty) {
    //       print('LOADING');
    //       return;
    //     }
    //     FFAppState().update(
    //       () {
    //         FFAppState().streamNotifications.value.addAll(FFAppState()
    //             .sortStreamNotifications
    //             .value
    //             .sublist(1, FFAppState().sortStreamNotifications.value.length));
    //       },
    //     );

    //     await Future.delayed(Duration(milliseconds: 500));
    //     pause = true;
    //   }
    // });

    // scrollController.addListener(() async {
    //   if (scrollController.position.pixels >=
    //           scrollController.position.maxScrollExtent - 1500 &&
    //       pause) {
    //     List accountList =
    //         List.from(FFAppState().listAccountForNotifications.value);
    //     print(FFAppState().listAccountForNotifications.value);
    //     print(accountList);
    //     print(FFAppState().streamNotifications.value.length);

    //     pause = false;
    //     // FFAppState().sortStreamNotifications.value.clear();
    //     // FFAppState()
    //     //     .sortStreamNotifications
    //     //     .add(FFAppState().sortStreamNotifications.value);
    //     await Future.forEach(accountList, (element) async {
    //       print(FFAppState().streamNotifications.value.length);
    //       print(3);
    //       int timeUNIXresult;
    //       ApiCallResponse value =
    //           await GetNotificationsByUserIdWithFromValueCall.call(
    //         accountId: element['name'],
    //         from: FFAppState().lastBlockHeight,
    //       );
    //       List result = value.jsonBody;
    //       Future.forEach(result, (element) {
    //         DateTime originalDate =
    //             DateTime.fromMillisecondsSinceEpoch(FFAppState().currentTime!);
    //         Duration durationToSubtract = Duration(
    //             seconds:
    //                 (FFAppState().blockHID! - element['blockHeight']).toInt());
    //         DateTime newDate =
    //             originalDate.toUtc().subtract(durationToSubtract).toLocal();
    //         timeUNIXresult = newDate.millisecondsSinceEpoch;
    //         FFAppState()
    //             .sortStreamNotifications
    //             .value
    //             .add([element, timeUNIXresult]);
    //       });

    //       FFAppState()
    //           .sortStreamNotifications
    //           .add(FFAppState().sortStreamNotifications.value);

    //       FFAppState().listAccountForNotifications.value.remove(element);
    //       FFAppState()
    //           .listAccountForNotifications
    //           .add(FFAppState().listAccountForNotifications.value);
    //       if (result.length >= 10) {
    //         FFAppState().update(
    //           () {
    //             FFAppState().listAccountForNotifications.value.add({
    //               'name': element['name'],
    //             });
    //             FFAppState()
    //                 .listAccountForNotifications
    //                 .add(FFAppState().listAccountForNotifications.value);
    //           },
    //         );

    //         if (FFAppState().lastBlockHeight! > result.last['blockHeight']) {
    //           FFAppState().lastBlockHeight = result.last['blockHeight'];
    //         }
    //       }
    //     });

    //     FFAppState().sortStreamNotifications.value.removeWhere((element) =>
    //         element[0]['blockHeight'] < FFAppState().lastBlockHeight!);
    //     FFAppState()
    //         .sortStreamNotifications
    //         .value
    //         .sort((a, b) => b[0]['blockHeight'].compareTo(a[0]['blockHeight']));
    //     if (FFAppState().sortStreamNotifications.value.isEmpty) {
    //       print('LOADING');
    //       return;
    //     }
    //     FFAppState().update(
    //       () {
    //         FFAppState().streamNotifications.value.addAll(FFAppState()
    //             .sortStreamNotifications
    //             .value
    //             .sublist(1, FFAppState().sortStreamNotifications.value.length));
    //         FFAppState()
    //             .streamNotifications
    //             .add(FFAppState().streamNotifications.value);
    //       },
    //     );

    //     await Future.delayed(Duration(milliseconds: 500));

    //     pause = true;
    //   }
    // });
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

    return Title(
        title: 'HomePage',
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
                    'Home',
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 0.0, 24.0),
                    child: Text(
                      'Notifications',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 24.0, 0.0),
                          child: Container(
                            width: () {
                              if (MediaQuery.sizeOf(context).width <
                                  valueOrDefault<double>(
                                    kBreakpointSmall,
                                    400.0,
                                  )) {
                                return 250.0;
                              } else if (MediaQuery.sizeOf(context).width <
                                  valueOrDefault<double>(
                                    kBreakpointMedium,
                                    1025.0,
                                  )) {
                                return 350.0;
                              } else if (MediaQuery.sizeOf(context).width <
                                  valueOrDefault<double>(
                                    kBreakpointLarge,
                                    1500.0,
                                  )) {
                                return 450.0;
                              } else {
                                return 600.0;
                              }
                            }(),
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
                                Container(
                                  width: () {
                                    if (MediaQuery.sizeOf(context).width <
                                        valueOrDefault<double>(
                                          kBreakpointSmall,
                                          400.0,
                                        )) {
                                      return 205.0;
                                    } else if (MediaQuery.sizeOf(context)
                                            .width <
                                        valueOrDefault<double>(
                                          kBreakpointMedium,
                                          1025.0,
                                        )) {
                                      return 305.0;
                                    } else if (MediaQuery.sizeOf(context)
                                            .width <
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
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    child: TextFormField(
                                      controller: _model.textController,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText:
                                            'Search by Account ID or Name',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMediumFamily,
                                              color: Color(0xFFBDBDBD),
                                              fontSize: 12.0,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
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
                        Container(
                          width: 45.0,
                          height: 45.0,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            children: [
                              OutlinedButton(
                                child: SvgPicture.asset(
                                  'assets/icons/Icon_filter.svg',
                                  color: Colors.white,
                                  fit: BoxFit.cover,
                                ),
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.white,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: Container(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.85,
                                          child: FiltersWidget(),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                              ),
                              Opacity(
                                opacity: (FFAppState().filterData.first !=
                                                null &&
                                            FFAppState().filterData.first !=
                                                '') &&
                                        (FFAppState().filterData.last != null &&
                                            FFAppState().filterData.last != '')
                                    ? 1.0
                                    : 0.0,
                                child: Align(
                                  alignment: AlignmentDirectional(1.00, -1.00),
                                  child: Container(
                                    width: 16.0,
                                    height: 16.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF7966),
                                      shape: BoxShape.circle,
                                    ),
                                    alignment:
                                        AlignmentDirectional(0.00, -1.00),
                                    child: Align(
                                      alignment:
                                          AlignmentDirectional(0.00, -1.00),
                                      child: Text(
                                        '1',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              color: Colors.white,
                                              fontSize: 13.0,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily),
                                            ),
                                      ),
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
                  Visibility(
                    visible: currentUserDocument?.subscriptions.isEmpty ?? true,
                    child: SizedBox(
                      height: 450,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/accounts.svg',
                            height: 120,
                            color: Color(0xFFC6F5F4),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                25.0, 0.0, 25.0, 0.0),
                            child: RichText(
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        'Oops! It seems you didn’t add any accounts yet. ',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: Color(0xFFBDBDBD),
                                          fontWeight: FontWeight.bold,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily),
                                        ),
                                  ),
                                  TextSpan(
                                    text: 'Add a new Account ',
                                    style: TextStyle(
                                      color: Color(0xFF65C3A2),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'to receive notifications',
                                    style: TextStyle(
                                      color: Color(0xFFBDBDBD),
                                    ),
                                  )
                                ],
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible:
                        !(currentUserDocument?.subscriptions.isEmpty ?? true),
                    child: StreamBuilder(
                        stream: FFAppState().streamNotifications,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                            return Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height - 305,
                                  width: MediaQuery.sizeOf(context).width >= 300
                                      ? 400
                                      : null,
                                  child: ListView.builder(
                                    controller:
                                        FFAppState().streamConroller.value
                                            ? scrollControllerForFilter
                                            : scrollController,
                                    itemCount: snapshot.data?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return snapshot.data!.isEmpty
                                          ? SizedBox()
                                          : Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFFAF9F8),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      8,
                                                    ),
                                                  ),
                                                  height: 75,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              clipBehavior: Clip
                                                                  .antiAliasWithSaveLayer,
                                                              width: 60,
                                                              height: 60,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100)),
                                                              child: snapshot
                                                                      .data!
                                                                      .isEmpty
                                                                  ? SizedBox()
                                                                  : CachedNetworkImage(
                                                                      imageUrl:
                                                                          'https://i.near.social/magic/large/https://near.social/magic/img/account/${snapshot.data![index][0]['accountId']}',
                                                                      errorWidget:
                                                                          (context,
                                                                              url,
                                                                              error) {
                                                                        return Image
                                                                            .asset(
                                                                          'assets/images/nonAvatar.png',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        );
                                                                      },
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10),
                                                              child: SizedBox(
                                                                width: 150,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      snapshot.data?[index]
                                                                              [
                                                                              0]
                                                                          [
                                                                          'accountId'],
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                    Text(
                                                                      snapshot.data?[index][0]
                                                                              [
                                                                              'value']
                                                                          [
                                                                          'type'],
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          color:
                                                                              Color(0xFF7E7E7E)),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(snapshot.data?[
                                                                        index]
                                                                        [2]
                                                                    .toString() ??
                                                                ''),
                                                            Text(snapshot.data?[
                                                                        index]
                                                                        [0][
                                                                        'blockHeight']
                                                                    .toString() ??
                                                                ''),
                                                            Text(
                                                              DateFormat(
                                                                      'MMM dd')
                                                                  .format(DateTime
                                                                      .fromMillisecondsSinceEpoch(
                                                                          snapshot.data?[index]
                                                                              [
                                                                              1]))
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFFBDBDBD)),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                  // Text(
                                                  //     '${snapshot.data?[index].toString()} $index ${snapshot.data?.length}'),
                                                  ),
                                            );
                                    },
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
