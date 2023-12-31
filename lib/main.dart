import 'package:b_o_s_notifications/local_DataBase.dart';
import 'package:b_o_s_notifications/notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '/components/accounts_deleting_dialog/accounts_deleting_dialog_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';
import 'package:aligned_dialog/aligned_dialog.dart';

import 'backend/push_notifications/push_notifications_util.dart';
import 'backend/firebase/firebase_config.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'flutter_flow/nav/nav.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  usePathUrlStrategy();
  await initFirebase();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await DatabaseHelper().initDb();
  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  await LocalNotificationService.init();

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   LocalNotificationService.showNotificationOnForeground(
  //       LocalNotificationMessage(
  //           message.notification?.title, message.notification?.body, {}));
  //   print('go');
  // });

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.system;

  late Stream<BaseAuthUser> userStream;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  final authUserSub = authenticatedUserStream.listen((_) {});
  final fcmTokenSub = fcmTokenUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = nearSocialNotificationsFirebaseUserStream()
      ..listen((user) => _appStateNotifier.update(user));
    jwtTokenStream.listen((_) {});
    Future.delayed(
      Duration(milliseconds: isWeb ? 0 : 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  @override
  void dispose() {
    authUserSub.cancel();
    fcmTokenSub.cancel();
    super.dispose();
  }

  void setLocale(String language) {
    setState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'NearSocialNotifications',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        scrollbarTheme: ScrollbarThemeData(),
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.page}) : super(key: key);

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'HomePage';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'HomePage': HomePageWidget(),
      'AccountPage': AccountPageWidget(),
      'SettingsPage': SettingsPageWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    return Scaffold(
      body: _currentPage ?? tabs[_currentPageName],
      bottomNavigationBar: StreamBuilder<List<String>>(
          stream: FFAppState().deletionAccountList,
          builder: (context, snapshot) {
            final accountDeletingList = snapshot.data ?? [];
            if (accountDeletingList.isNotEmpty)
              return Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 30,
                        blurStyle: BlurStyle.normal,
                        color: Color.fromARGB(43, 164, 164, 164))
                  ],
                  color: Colors.white,
                ),
                width: MediaQuery.sizeOf(context).width,
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${FFAppState().accountSelected.length} account selected',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(126, 126, 126, 1),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await showAlignedDialog(
                              context: context,
                              isGlobal: true,
                              avoidOverflow: false,
                              targetAnchor: AlignmentDirectional(0.0, 0.0)
                                  .resolve(Directionality.of(context)),
                              followerAnchor: AlignmentDirectional(0.0, 0.0)
                                  .resolve(Directionality.of(context)),
                              builder: (dialogContext) {
                                return Material(
                                  color: Colors.transparent,
                                  child: AccountsDeletingDialogWidget(),
                                );
                              },
                            ).then((value) => setState(() {}));
                          },
                          child: SvgPicture.asset('assets/icons/trash.svg'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            return Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(10, 0, 0, 0), blurRadius: 100),
                ],
              ),
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() {
                        _currentPage = null;
                        _currentPageName = tabs.keys.toList()[0];
                      }),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: currentIndex == 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 151, 151, 255),
                                  borderRadius: BorderRadius.circular(2)),
                              width: 45,
                              height: 3,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: SvgPicture.asset(
                                    'assets/icons/tabhome2.svg',
                                    color: currentIndex == 0
                                        ? Color.fromARGB(255, 151, 151, 255)
                                        : Colors.grey,
                                  ),
                                ),
                                Text('Home',
                                    textScaleFactor: 1,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: currentIndex == 0
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: currentIndex == 0
                                          ? Color.fromARGB(255, 151, 151, 255)
                                          : Colors.grey,
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() {
                        _currentPage = null;
                        _currentPageName = tabs.keys.toList()[1];
                      }),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: currentIndex == 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 151, 151, 255),
                                  borderRadius: BorderRadius.circular(2)),
                              width: 45,
                              height: 3,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: SvgPicture.asset(
                                    'assets/icons/accounts.svg',
                                    color: currentIndex == 1
                                        ? Color.fromARGB(255, 151, 151, 255)
                                        : Colors.grey,
                                  ),
                                ),
                                Text('Accounts',
                                    textScaleFactor: 1,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: currentIndex == 1
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: currentIndex == 1
                                          ? Color.fromARGB(255, 151, 151, 255)
                                          : Colors.grey,
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() {
                        _currentPage = null;
                        _currentPageName = tabs.keys.toList()[2];
                      }),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: currentIndex == 2,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 151, 151, 255),
                                  borderRadius: BorderRadius.circular(2)),
                              width: 45,
                              height: 3,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: SvgPicture.asset(
                                    'assets/icons/Icon_settings.svg',
                                    color: currentIndex == 2
                                        ? Color.fromARGB(255, 151, 151, 255)
                                        : Colors.grey,
                                  ),
                                ),
                                Text(
                                  'Settings',
                                  textScaleFactor: 1,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: currentIndex == 2
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: currentIndex == 2
                                        ? Color.fromARGB(255, 151, 151, 255)
                                        : Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // child: BottomNavigationBar(
              //   currentIndex: currentIndex,
              //   onTap: (i) => setState(() {
              //     _currentPage = null;
              //     _currentPageName = tabs.keys.toList()[i];
              //   }),
              //   backgroundColor: Colors.white,
              //   selectedItemColor: Color(0xFF9797FF),
              //   unselectedItemColor: Color(0xFF7E7E7E),
              //   showSelectedLabels: false,
              //   showUnselectedLabels: false,
              //   type: BottomNavigationBarType.fixed,
              //   items: <BottomNavigationBarItem>[
              //     BottomNavigationBarItem(
              //       icon: SvgPicture.asset(
              //         'assets/icons/tabhome2.svg',
              //         color: currentIndex == 0
              //             ? Color.fromARGB(255, 151, 151, 255)
              //             : Colors.grey,
              //         fit: BoxFit.cover,
              //       ),
              //       label: 'Home',
              //       tooltip: '',
              //     ),
              //     BottomNavigationBarItem(
              //       icon: SvgPicture.asset(
              //         'assets/icons/accounts.svg',
              //         color: currentIndex == 1
              //             ? Color.fromARGB(255, 151, 151, 255)
              //             : Colors.grey,
              //         fit: BoxFit.cover,
              //       ),
              //       label: 'Account',
              //       tooltip: '',
              //     ),
              //     BottomNavigationBarItem(
              //       icon: SvgPicture.asset(
              //         'assets/icons/Icon_settings.svg',
              //         color: currentIndex == 2
              //             ? Color.fromARGB(255, 151, 151, 255)
              //             : Colors.grey,
              //         fit: BoxFit.cover,
              //       ),
              //       label: 'Settings',
              //       tooltip: '',
              //     )
              //   ],
              // ),
            );
          }),
    );
  }
}
