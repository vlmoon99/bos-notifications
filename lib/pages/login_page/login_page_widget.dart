import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'login_page_model.dart';
export 'login_page_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  late LoginPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => () async {
          GoRouter.of(context).prepareAuthEvent();
          final user = await authManager.signInAnonymously(context);
          if (user == null) {
            return;
          }

          context.pushNamedAuth('HomePage', context.mounted);
        }());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Image.asset(
        () {
          if (MediaQuery.sizeOf(context).width >
              MediaQuery.sizeOf(context).height) {
            print('dek');
            return 'asss/Dekstop.png';
          } else if (MediaQuery.sizeOf(context).height > 3000) {
            print('table');
            return 'asg';
          } else {
            print('phone');
            return '.png';
          }
        }(),
        fit: BoxFit.cover,
      ),
    );
  }
}
