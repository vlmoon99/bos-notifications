import 'dart:async';

import 'package:b_o_s_notifications/auth/firebase_auth/auth_util.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:b_o_s_notifications/backend/api_requests/api_calls.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rxdart/subjects.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          print(MediaQuery.of(context).viewInsets.bottom);
        }));
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
        pause = true;
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
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
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MediaQuery.sizeOf(context).width > 600
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 450,
                        ),
                        width: MediaQuery.sizeOf(context).width * 0.7,
                        height: 45.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5EF),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
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
                              constraints: BoxConstraints(
                                maxWidth: 405,
                              ),
                              height: 100.0,
                              width:
                                  MediaQuery.sizeOf(context).width * 0.7 - 45,
                              child: TextField(
                                onSubmitted: (value) {
                                  activeText = true;
                                },
                                onChanged: (value) async {
                                  activeText = false;
                                  timer?.cancel();
                                  timer = Timer(Duration(seconds: 1), () {
                                    bool empty =
                                        RegExp(r'^\s*$').hasMatch(value);

                                    FFAppState().filterID = empty
                                        ? null
                                        : value.replaceAll(RegExp(r'\s'), '');
                                    print(FFAppState().filterID);
                                    if (FFAppState().filterData.last != '' &&
                                        FFAppState().filterData.first != '') {
                                      initNotificationsForFilter();
                                    } else {
                                      initNotifications();
                                    }
                                    FFAppState().filterID = null;
                                  });
                                },
                                controller: _model.textController,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: activeText
                                      ? 'Search by Account ID or Name'
                                      : null,
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
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: (MediaQuery.sizeOf(context).width > 600)
                                ? 24
                                : 0),
                        child: Container(
                          width: 55,
                          height: 55,
                          child: Stack(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.black,
                                ),
                                height: 45,
                                width: 45,
                                child: InkWell(
                                  child: SvgPicture.asset(
                                    'assets/icons/Icon_filter.svg',
                                    height: 25,
                                    width: 25,
                                    fit: BoxFit.none,
                                    color: Colors.white,
                                  ),
                                  onTap: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      enableDrag: false,
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.85,
                                          child: FiltersWidget(),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  },
                                ),
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
                      ),
                    ],
                  ),
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
                  Visibility(
                    visible:
                        !(currentUserDocument?.subscriptions.isEmpty ?? true),
                    child: Expanded(
                      child: StreamBuilder(
                          stream: FFAppState().streamNotifications,
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                              return Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        minWidth: 400, maxWidth: 524),
                                    height: MediaQuery.sizeOf(context).height,
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
                                            ? SizedBox()
                                            : Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: (MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.01) >
                                                            12
                                                        ? 12
                                                        : (MediaQuery.sizeOf(
                                                                    context)
                                                                .height *
                                                            0.008)),
                                                child: InkWell(
                                                  onTap: () async {
                                                    String url;
                                                    if (snapshot.data![index][0]
                                                            ['value']['type']
                                                        .toString()
                                                        .startsWith(
                                                            'devgovgigs')) {
                                                      String idPost = snapshot
                                                          .data![index][0]
                                                              ['value']['post']
                                                          .toString();
                                                      url =
                                                          'https://near.social/devhub.near/widget/app?page=post&id=$idPost';
                                                    } else {
                                                      if (snapshot.data![index]
                                                                      [0]
                                                                      ['value']
                                                                      ['type']
                                                                  .toString() !=
                                                              'like' &&
                                                          snapshot.data![index]
                                                                      [0]
                                                                      ['value']
                                                                      ['type']
                                                                  .toString() !=
                                                              'repost' &&
                                                          snapshot.data![index]
                                                                      [0]
                                                                      ['value']
                                                                      ['type']
                                                                  .toString() !=
                                                              'comment') {
                                                        return;
                                                      }
                                                      String id = snapshot
                                                          .data![index][2]
                                                          .toString();

                                                      String block = snapshot
                                                          .data![index][0]
                                                              ['value']['item']
                                                              ['blockHeight']
                                                          .toString();
                                                      url =
                                                          'https://near.social/mob.near/widget/MainPage.N.Post.Page?accountId=$id&blockHeight=$block';
                                                    }

                                                    await launchUrlString(url);
                                                  },
                                                  child: Container(
                                                      constraints:
                                                          BoxConstraints(
                                                        minHeight: 50,
                                                        maxHeight: 100,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFFAF9F8),
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
                                                            MediaQuery.sizeOf(
                                                                            context)
                                                                        .width >
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
                                                                    minWidth:
                                                                        45,
                                                                    minHeight:
                                                                        45,
                                                                    maxHeight:
                                                                        65,
                                                                    maxWidth:
                                                                        65,
                                                                  ),
                                                                  clipBehavior:
                                                                      Clip.antiAliasWithSaveLayer,
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .height *
                                                                      0.06,
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .height *
                                                                      0.06,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100)),
                                                                  child: snapshot
                                                                          .data!
                                                                          .isEmpty
                                                                      ? SizedBox()
                                                                      : CachedNetworkImage(
                                                                          imageUrl:
                                                                              'https://i.near.social/magic/large/https://near.social/magic/img/account/${snapshot.data![index][0]['accountId']}',
                                                                          errorWidget: (context,
                                                                              url,
                                                                              error) {
                                                                            return Image.asset(
                                                                              'assets/images/nonAvatar.png',
                                                                              fit: BoxFit.cover,
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
                                                                  child:
                                                                      SizedBox(
                                                                    width: 150,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          (snapshot.data?[index][3] != '')
                                                                              ? snapshot.data![index][3]
                                                                              : snapshot.data![index][0]['accountId'],
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xFF000000),
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                        Text(
                                                                          snapshot.data?[index][0]['value']
                                                                              [
                                                                              'type'],
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              TextStyle(color: Color(0xFF7E7E7E)),
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
                                                                SizedBox(
                                                                  width: 50,
                                                                  height: 20,
                                                                  child:
                                                                      FittedBox(
                                                                    child: Text(
                                                                      snapshot.data?[index][2]
                                                                              .toString() ??
                                                                          '',
                                                                      style: TextStyle(
                                                                          fontSize: MediaQuery.sizeOf(context).height < 900
                                                                              ? 11
                                                                              : 14,
                                                                          color:
                                                                              Color(0xFF7E7E7E)),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  DateFormat(
                                                                          'MMM dd')
                                                                      .format(snapshot
                                                                              .data?[
                                                                          index][1])
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.sizeOf(context).height <
                                                                              900
                                                                          ? 11
                                                                          : 14,
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
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
