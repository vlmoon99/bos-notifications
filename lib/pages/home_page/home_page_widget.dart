import 'dart:async';

import 'package:b_o_s_notifications/auth/firebase_auth/auth_util.dart';
import 'package:b_o_s_notifications/notifications.dart';
import 'package:b_o_s_notifications/pages/account_page/account_page_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:b_o_s_notifications/backend/api_requests/api_calls.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
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
  Timer? timer;
  late HomePageModel _model;
  bool activeText = true;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController scrollController = ScrollController();
  final ScrollController scrollControllerForFilter = ScrollController();

  List pastAccounts = [];
  List detectDuplicate = [];
  bool isNotificationsListenerInited = false;

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(
        () {
          FFAppState().newMessage = true;
          if (FFAppState().streamConroller.value &&
              scrollControllerForFilter.position.pixels <
                  scrollControllerForFilter.position.minScrollExtent + 100) {
            initNotificationsForFilter();
            FFAppState().newMessage = false;
          } else if (!FFAppState().streamConroller.value &&
              scrollController.position.pixels <
                  scrollController.position.minScrollExtent + 100) {
            initNotifications();
            FFAppState().newMessage = false;
          }
        },
      );

      print('Message data: ${message.data}');
      //(Notifi 2)Got a message whilst in the foreground

      // LocalNotificationService.showNotificationOnForeground(
      //     LocalNotificationMessage(title, body, {}));
    });
  }

  void _handleMessage(RemoteMessage message) {
    //(Notifi 3)Got a message whilst in the foreground

    // Modular.to.pushNamedAndRemoveUntil(
    //     Routes.home.getRoute(Routes.home.notifications), (route) {
    //   log("route ${route.settings.name}");
    //   return route.settings.name == '/home/';
    // });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (FFAppState().firstInit.value) {
          print('Пользователь открывает приложение впервые');

          context.pushReplacementNamed('AccountPage');
        }
      },
    );

    setupInteractedMessage();
    FFAppState().messageNull = true;
    FFAppState().filterID = null;
    FFAppState().listTapNotifications.value.clear();

    if (FFAppState().filterData.first != '' &&
        FFAppState().filterData.last != '') {
      initNotificationsForFilter();
    } else {
      initNotifications();
    }
    super.initState();
    _model = createModel(context, () => HomePageModel());

    _model.textController ??= TextEditingController();
    scrollControllerForFilter.addListener(() async {
      if (scrollControllerForFilter.position.pixels <=
              scrollControllerForFilter.position.minScrollExtent + 10 &&
          DateTime.parse(FFAppState().filterData.first) >= DateTime.now() &&
          FFAppState().newMessage) {
        FFAppState().newMessage = false;
        initNotificationsForFilter();
      }
      if (scrollControllerForFilter.position.pixels >=
              scrollControllerForFilter.position.maxScrollExtent - 1500 &&
          FFAppState().pause) {
        FFAppState().pause = false;
        // ИСПОЛНЯЕМЫЙ КОД

        //СОЗДАНИЕ СОРТИРОВОЧНОГО ЛИСТА, ЛОКАЛЬНОГО ПРЕДЕЛЬНОГО БЛОКА И ОБНУЛЕНИЕ ГЛОБАЛЬНОГО ПРЕДЕЛЬНОГО БЛОКА.
        List sortList = [];
        int localLastBlockHeight = FFAppState().lastBlockHeight ?? 0;
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
          if (notifications.length <= 295 ||
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
          await Future.forEach(notifications, (notif) async {
            String name = '';
            if (FFAppState().listNameId.value.any(
                  (el) => el['id'] == notif['accountId'],
                )) {
              name = FFAppState()
                  .listNameId
                  .value
                  .firstWhere((el) => el['id'] == notif['accountId'])['name'];
            } else {
              ApiCallResponse x = await GetNearSocialNameCall.call(
                  accountId: notif['accountId']);
              if (x.jsonBody[notif['accountId']] != null) {
                print(x.jsonBody[notif['accountId']]);
                name = x.jsonBody[notif['accountId']]['profile']['name'];
                FFAppState()
                    .listNameId
                    .value
                    .add({'id': notif['accountId'], 'name': name});
              } else {
                FFAppState()
                    .listNameId
                    .value
                    .add({'id': notif['accountId'], 'name': ''});
              }
            }
            //Вычисление времени
            int blockHeightInNotification = notif['blockHeight'];
            int blockHeightInGlobal = FFAppState().blockHID!;
            int secondsForSubstract =
                blockHeightInGlobal - blockHeightInNotification;
            DateTime TimeForNomberOneNotify = FFAppState().currentTime!;
            DateTime TimeForCurrentNotify = TimeForNomberOneNotify.subtract(
                Duration(seconds: secondsForSubstract));
            DateTime unixTimeForNotify = TimeForCurrentNotify;

            //Добавление элемента в сортировку
            sortList.add([notif, unixTimeForNotify, account, name]);
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
        FFAppState().pause = true;
      }
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels <=
              scrollController.position.minScrollExtent + 10 &&
          FFAppState().newMessage) {
        FFAppState().newMessage = false;
        initNotifications();
      }
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 1500 &&
          FFAppState().pause) {
        FFAppState().pause = false;
        // ИСПОЛНЯЕМЫЙ КОД

        //СОЗДАНИЕ СОРТИРОВОЧНОГО ЛИСТА, ЛОКАЛЬНОГО ПРЕДЕЛЬНОГО БЛОКА И ОБНУЛЕНИЕ ГЛОБАЛЬНОГО ПРЕДЕЛЬНОГО БЛОКА.
        Set timeSet = {};
        List sortList = [];
        int localLastBlockHeight = FFAppState().lastBlockHeight ?? 0;
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
          if (notifications.length <= 295) {
            FFAppState().listAccountForNotifications.value.remove(account);
            FFAppState()
                .listAccountForNotifications
                .add(FFAppState().listAccountForNotifications.value);
          }

          //обозначение общего предельного блока
          if (notifications.isNotEmpty) {
            if (FFAppState().lastBlockHeight == null ||
                (FFAppState().lastBlockHeight ?? 0) <
                    notifications.last['blockHeight']) {
              FFAppState().lastBlockHeight = notifications.last['blockHeight'];
            }
          }

          //ДОБАВЛЕНИЕ ДЛЯ КАЖДОГО ЭЛЕМЕНТА ВРЕМЕНИ И ДОБАВЛЕНИЕ ЭЛЕМЕНТА В СОРТИРОВКУ.
          await Future.forEach(notifications, (notif) async {
            String name = '';
            if (FFAppState().listNameId.value.any(
                  (el) => el['id'] == notif['accountId'],
                )) {
              name = FFAppState()
                  .listNameId
                  .value
                  .firstWhere((el) => el['id'] == notif['accountId'])['name'];
            } else {
              ApiCallResponse x = await GetNearSocialNameCall.call(
                  accountId: notif['accountId']);
              if (x.jsonBody[notif['accountId']] != null) {
                name = x.jsonBody[notif['accountId']]['profile']['name'];
                FFAppState()
                    .listNameId
                    .value
                    .add({'id': notif['accountId'], 'name': name});
              } else {
                FFAppState()
                    .listNameId
                    .value
                    .add({'id': notif['accountId'], 'name': ''});
              }
            }

            //Вычисление времени
            int blockHeightInNotification = notif['blockHeight'];
            int blockHeightInGlobal = FFAppState().blockHID!;
            int secondsForSubstract =
                blockHeightInGlobal - blockHeightInNotification;
            DateTime TimeForNomberOneNotify = FFAppState().currentTime!;
            DateTime TimeForCurrentNotify = TimeForNomberOneNotify.subtract(
                Duration(seconds: secondsForSubstract));
            DateTime unixTimeForNotify = TimeForCurrentNotify;

            //Добавление элемента в сортировку
            timeSet.add(unixTimeForNotify);
            sortList.add([notif, unixTimeForNotify, account, name]);
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

        FFAppState().pause = true;
      }
    });
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
                    'Social Notifications',
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
            centerTitle: false,
            elevation: 0.0,
          ),
          body: SafeArea(
            top: true,
            child: IgnorePointer(
              ignoring: FFAppState().firstInit.value,
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              'Notifications',
                              textScaler: TextScaler.noScaling,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: InkWell(
                              onTap: () async {
                                HapticFeedback.lightImpact();
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.85,
                                      child: FiltersWidget(),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: Text(
                                'Filters',
                                textScaler: TextScaler.noScaling,
                                style: TextStyle(
                                    color: Color(0xFF65C3A2),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      width: MediaQuery.sizeOf(context).width,
                      height: 1,
                      decoration: BoxDecoration(
                        color: Color(0xFFEDEEEE),
                        borderRadius: BorderRadius.circular(
                          100,
                        ),
                      ),
                    ),
                    // Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   mainAxisAlignment: MediaQuery.sizeOf(context).width > 600
                    //       ? MainAxisAlignment.start
                    //       : MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Container(
                    //       constraints: BoxConstraints(
                    //         maxWidth: 450,
                    //       ),
                    //       width: MediaQuery.sizeOf(context).width * 0.7,
                    //       height: 45.0,
                    //       decoration: BoxDecoration(
                    //         color: Color(0xFFF5F5EF),
                    //         borderRadius: BorderRadius.circular(8.0),
                    //       ),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: [
                    //           SizedBox(
                    //             height: 45,
                    //             width: 45,
                    //             child: InkWell(
                    //               child: SvgPicture.asset(
                    //                 'assets/icons/Icon_search.svg',
                    //                 fit: BoxFit.none,
                    //               ),
                    //               onTap: () {},
                    //             ),
                    //           ),
                    //           Expanded(
                    //             child: OverflowBox(
                    //               maxHeight: 1000,
                    //               child: Container(
                    //                 margin: EdgeInsets.only(bottom: 0),
                    //                 child: TextField(
                    //                   autocorrect: false,
                    //                   textAlignVertical: TextAlignVertical.bottom,
                    //                   onChanged: (value) async {
                    //                     HapticFeedback.lightImpact();
                    //                     timer?.cancel();
                    //                     timer = Timer(Duration(milliseconds: 300),
                    //                         () {
                    //                       FFAppState().update(
                    //                         () {
                    //                           FFAppState().filterID = value
                    //                               .replaceAll(RegExp(r'\s'), '');
                    //                         },
                    //                       );
                    //                       FFAppState().streamConroller.value
                    //                           ? scrollControllerForFilter
                    //                               .animateTo(
                    //                               0.0,
                    //                               duration:
                    //                                   Duration(milliseconds: 300),
                    //                               curve: Curves.easeInOut,
                    //                             )
                    //                           : scrollController.animateTo(
                    //                               0.0,
                    //                               duration:
                    //                                   Duration(milliseconds: 300),
                    //                               curve: Curves.easeInOut,
                    //                             );
                    //                       if (!(currentUserDocument
                    //                                   ?.subscriptions ??
                    //                               [])
                    //                           .any((e) => e.startsWith(
                    //                               FFAppState().filterID ?? ''))) {
                    //                       } else {}
                    //                       // if (FFAppState().filterData.last !=
                    //                       //         '' &&
                    //                       //     FFAppState().filterData.first !=
                    //                       //         '') {
                    //                       //   initNotificationsForFilter();
                    //                       // } else {
                    //                       //   initNotifications();
                    //                       // }
                    //                     });
                    //                   },
                    //                   controller: _model.textController,
                    //                   autofocus: false,
                    //                   obscureText: false,
                    //                   decoration: InputDecoration(
                    //                     hintText: 'Search by Account ID or Name',
                    //                     hintStyle: FlutterFlowTheme.of(context)
                    //                         .labelMedium
                    //                         .override(
                    //                           fontFamily:
                    //                               FlutterFlowTheme.of(context)
                    //                                   .labelMediumFamily,
                    //                           color: Color(0xFFBDBDBD),
                    //                           fontSize: 15.0,
                    //                           useGoogleFonts: GoogleFonts.asMap()
                    //                               .containsKey(
                    //                                   FlutterFlowTheme.of(context)
                    //                                       .labelMediumFamily),
                    //                         ),
                    //                     floatingLabelBehavior:
                    //                         FloatingLabelBehavior.never,
                    //                     enabledBorder: InputBorder.none,
                    //                     focusedBorder: InputBorder.none,
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: EdgeInsets.only(
                    //           left: (MediaQuery.sizeOf(context).width > 600)
                    //               ? 24
                    //               : 0),
                    //       child: Container(
                    //         width: 55,
                    //         height: 55,
                    //         child: Stack(
                    //           alignment: AlignmentDirectional(0.0, 0.0),
                    //           children: [
                    //             Container(
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(8),
                    //                 color: Colors.black,
                    //               ),
                    //               height: 45,
                    //               width: 45,
                    //               child: InkWell(
                    //                 child: SvgPicture.asset(
                    //                   'assets/icons/Icon_filter.svg',
                    //                   height: 25,
                    //                   width: 25,
                    //                   fit: BoxFit.none,
                    //                   color: Colors.white,
                    //                 ),
                    //                 onTap: () async {
                    //                   HapticFeedback.lightImpact();
                    //                   await showModalBottomSheet(
                    //                     isScrollControlled: true,
                    //                     backgroundColor: Colors.transparent,
                    //                     enableDrag: false,
                    //                     context: context,
                    //                     builder: (context) {
                    //                       return Container(
                    //                         height: MediaQuery.sizeOf(context)
                    //                                 .height *
                    //                             0.85,
                    //                         child: FiltersWidget(),
                    //                       );
                    //                     },
                    //                   ).then((value) => safeSetState(() {}));
                    //                 },
                    //               ),
                    //             ),
                    //             Opacity(
                    //               opacity: (FFAppState().filterData.first !=
                    //                               null &&
                    //                           FFAppState().filterData.first !=
                    //                               '') &&
                    //                       (FFAppState().filterData.last != null &&
                    //                           FFAppState().filterData.last != '')
                    //                   ? 1.0
                    //                   : 0.0,
                    //               child: Align(
                    //                 alignment: AlignmentDirectional(1.00, -1.00),
                    //                 child: Container(
                    //                   width: 16.0,
                    //                   height: 16.0,
                    //                   decoration: BoxDecoration(
                    //                     color: Color(0xFFFF7966),
                    //                     shape: BoxShape.circle,
                    //                   ),
                    //                   alignment:
                    //                       AlignmentDirectional(0.00, -1.00),
                    //                   child: Align(
                    //                     alignment:
                    //                         AlignmentDirectional(0.00, -1.00),
                    //                     child: Text(
                    //                       '1',
                    //                       textScaleFactor: 1,
                    //                       style: FlutterFlowTheme.of(context)
                    //                           .bodyMedium
                    //                           .override(
                    //                             fontFamily:
                    //                                 FlutterFlowTheme.of(context)
                    //                                     .bodyMediumFamily,
                    //                             color: Colors.white,
                    //                             fontSize: 13.0,
                    //                             useGoogleFonts: GoogleFonts
                    //                                     .asMap()
                    //                                 .containsKey(
                    //                                     FlutterFlowTheme.of(
                    //                                             context)
                    //                                         .bodyMediumFamily),
                    //                           ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Visibility(
                      visible:
                          (currentUserDocument?.subscriptions.isEmpty ?? true),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.sizeOf(context).height < 900
                                ? 20
                                : 100),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/accounts.svg',
                              height: MediaQuery.sizeOf(context).height < 900
                                  ? 80
                                  : 120,
                              color: Color(0xFFC6F5F4),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  25.0, 0.0, 25.0, 0.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'Oops! It seems you didn’t add any accounts yet. ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontSize: MediaQuery.sizeOf(context)
                                                        .height <
                                                    900
                                                ? 11
                                                : 14,
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
                                        fontSize:
                                            MediaQuery.sizeOf(context).height <
                                                    900
                                                ? 11
                                                : 14,
                                      ),
                                    )
                                  ],
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.sizeOf(context).height < 900
                                            ? 11
                                            : 14,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Visibility(
                    //   visible: (currentUserDocument?.subscriptions.isNotEmpty ??
                    //           false) &&
                    //       FFAppState().messageNull,
                    //   child: Expanded(
                    //     child: Center(
                    //       child: ,
                    //     ),
                    //   ),
                    // ),
                    Visibility(
                      visible: !FFAppState().messageNull &&
                          FFAppState().streamNotifications.value.isEmpty &&
                          (currentUserDocument?.subscriptions.isNotEmpty ??
                              false),
                      child: Expanded(
                        child: Center(
                          child: Text(
                            'No notifications.',
                            textScaler: TextScaler.noScaling,
                            style: TextStyle(
                              color: Color(0xFF65C3A2),
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !(currentUserDocument?.subscriptions.isEmpty ??
                          false),
                      child: Expanded(
                        child: StreamBuilder(
                            stream: FFAppState().streamNotifications,
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data!.isNotEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Container(
                                    height: MediaQuery.sizeOf(context).height,
                                    constraints: BoxConstraints(
                                        minWidth: 400, maxWidth: 524),
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.7,
                                    child: ListView.builder(
                                      controller:
                                          FFAppState().streamConroller.value
                                              ? scrollControllerForFilter
                                              : scrollController,
                                      itemCount: snapshot.data?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return snapshot.data!.isEmpty
                                            ? CircularProgressIndicator(
                                                backgroundColor: Colors.white,
                                                color: Colors.green,
                                              )
                                            : Column(
                                                children: [
                                                  StreamBuilder<Object>(
                                                      stream: FFAppState()
                                                          .filterCategories,
                                                      builder: (context,
                                                          filterData) {
                                                        return Visibility(
                                                          visible: (FFAppState()
                                                                  .filterCategories
                                                                  .value
                                                                  .contains(snapshot.data![index][0]['value'][
                                                                      'type']) ||
                                                              (snapshot.data![index][0]['value']['type'] !=
                                                                      null &&
                                                                  snapshot.data![index][0]['value']['type']
                                                                      .startsWith(
                                                                          'devgovgigs') &&
                                                                  FFAppState()
                                                                      .filterCategories
                                                                      .value
                                                                      .contains('devgovgigs'))),
                                                          // (FFAppState()
                                                          //             .filterID ==
                                                          //         null) ||
                                                          //     (snapshot.data?[index]
                                                          //                 [2] ??
                                                          //             '')
                                                          //         .toString()
                                                          //         .startsWith(FFAppState()
                                                          //                 .filterID ??
                                                          //             ''),
                                                          child: InkWell(
                                                            onTap: () async {
                                                              HapticFeedback
                                                                  .mediumImpact();
                                                              FFAppState()
                                                                  .update(
                                                                () {
                                                                  FFAppState()
                                                                      .listTapNotifications
                                                                      .value
                                                                      .add(
                                                                          index);
                                                                },
                                                              );

                                                              Timer(
                                                                  Duration(
                                                                      seconds:
                                                                          2),
                                                                  () {
                                                                FFAppState()
                                                                    .update(() {
                                                                  FFAppState()
                                                                      .listTapNotifications
                                                                      .value
                                                                      .remove(
                                                                          index);
                                                                });
                                                              });
                                                              String url;
                                                              if (snapshot
                                                                  .data![index]
                                                                      [0]
                                                                      ['value']
                                                                      ['type']
                                                                  .toString()
                                                                  .startsWith(
                                                                      'devgovgigs')) {
                                                                String idPost = snapshot
                                                                    .data![
                                                                        index]
                                                                        [0][
                                                                        'value']
                                                                        ['post']
                                                                    .toString();
                                                                url =
                                                                    'https://near.social/devhub.near/widget/app?page=post&id=$idPost';
                                                              } else if (snapshot
                                                                      .data![
                                                                          index]
                                                                          [0][
                                                                          'value']
                                                                          [
                                                                          'type']
                                                                      .toString() ==
                                                                  'mention') {
                                                                String id = snapshot
                                                                    .data![
                                                                        index]
                                                                        [0][
                                                                        'accountId']
                                                                    .toString();
                                                                String block = snapshot
                                                                    .data![
                                                                        index]
                                                                        [0][
                                                                        'blockHeight']
                                                                    .toString();
                                                                url =
                                                                    'https://near.social/mob.near/widget/MainPage.N.Post.Page?accountId=$id&blockHeight=$block';
                                                              } else {
                                                                if (snapshot.data![index][0]['value']['type'].toString() != 'like' &&
                                                                    snapshot.data![index][0]['value']['type']
                                                                            .toString() !=
                                                                        'repost' &&
                                                                    snapshot.data![index][0]['value']['type']
                                                                            .toString() !=
                                                                        'comment') {
                                                                  return;
                                                                }
                                                                String id = snapshot
                                                                    .data![
                                                                        index]
                                                                        [2]
                                                                    .toString();

                                                                String block = snapshot
                                                                    .data![
                                                                        index]
                                                                        [0][
                                                                        'value']
                                                                        ['item']
                                                                        [
                                                                        'blockHeight']
                                                                    .toString();
                                                                url =
                                                                    'https://near.social/mob.near/widget/MainPage.N.Post.Page?accountId=$id&blockHeight=$block';
                                                              }

                                                              await launchUrlString(
                                                                  url);
                                                            },
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  vertical: (MediaQuery.sizeOf(context).height *
                                                                              0.01) >
                                                                          12
                                                                      ? 12
                                                                      : (MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.008)),
                                                              child:
                                                                  AnimatedContainer(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        100),
                                                                constraints:
                                                                    BoxConstraints(
                                                                  minHeight: 50,
                                                                  maxHeight:
                                                                      100,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FFAppState()
                                                                          .listTapNotifications
                                                                          .value
                                                                          .contains(
                                                                              index)
                                                                      ? Color.fromARGB(
                                                                          255,
                                                                          232,
                                                                          249,
                                                                          230)
                                                                      : Color(
                                                                          0xFFFAF9F8),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    8,
                                                                  ),
                                                                ),
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.065,
                                                                child: Padding(
                                                                  padding: EdgeInsets.all(
                                                                      MediaQuery.sizeOf(context).width >
                                                                              600
                                                                          ? 8
                                                                          : 2),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Container(
                                                                            constraints:
                                                                                BoxConstraints(
                                                                              minWidth: 45,
                                                                              minHeight: 45,
                                                                              maxHeight: 65,
                                                                              maxWidth: 65,
                                                                            ),
                                                                            clipBehavior:
                                                                                Clip.antiAliasWithSaveLayer,
                                                                            width:
                                                                                MediaQuery.sizeOf(context).height * 0.05,
                                                                            height:
                                                                                MediaQuery.sizeOf(context).height * 0.05,
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100)),
                                                                            child: snapshot.data!.isEmpty
                                                                                ? SizedBox()
                                                                                : CachedNetworkImage(
                                                                                    imageUrl: 'https://i.near.social/magic/large/https://near.social/magic/img/account/${snapshot.data![index][0]['accountId']}',
                                                                                    errorWidget: (context, url, error) {
                                                                                      return SvgPicture.network(url);
                                                                                    },
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: 10),
                                                                            child:
                                                                                SizedBox(
                                                                              width: 130,
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    (snapshot.data?[index][3] != '') ? snapshot.data![index][3] : snapshot.data![index][0]['accountId'] ?? '',
                                                                                    textScaler: TextScaler.noScaling,
                                                                                    style: TextStyle(
                                                                                      color: Color(0xFF000000),
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                                    maxLines: 1,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                  Text(
                                                                                    snapshot.data?[index][0]['value']['type'] ?? '',
                                                                                    maxLines: 1,
                                                                                    textScaler: TextScaler.noScaling,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: TextStyle(color: Color(0xFF7E7E7E)),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.end,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                65,
                                                                            height:
                                                                                20,
                                                                            child:
                                                                                Text(
                                                                              snapshot.data?[index][2].toString() ?? '',
                                                                              textAlign: TextAlign.end,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              textScaleFactor: 1,
                                                                              style: TextStyle(fontSize: MediaQuery.sizeOf(context).height < 900 ? 11 : 14, color: Color(0xFF7E7E7E)),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            DateFormat('MMM dd').format(snapshot.data?[index][1]).toString(),
                                                                            textScaleFactor:
                                                                                1,
                                                                            style:
                                                                                TextStyle(fontSize: MediaQuery.sizeOf(context).height < 900 ? 11 : 14, color: Color(0xFFBDBDBD)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                  Visibility(
                                                    visible: index ==
                                                            snapshot.data!
                                                                    .length -
                                                                1 &&
                                                        FFAppState()
                                                            .filterCategories
                                                            .value
                                                            .isNotEmpty &&
                                                        FFAppState()
                                                            .listAccountForNotifications
                                                            .value
                                                            .isNotEmpty,
                                                    child:
                                                        CircularProgressIndicator(
                                                      backgroundColor:
                                                          Colors.white,
                                                      color: Colors.green,
                                                    ),
                                                  )
                                                ],
                                              );
                                      },
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            }),
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
