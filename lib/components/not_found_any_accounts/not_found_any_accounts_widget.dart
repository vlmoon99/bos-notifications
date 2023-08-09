import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'not_found_any_accounts_model.dart';
export 'not_found_any_accounts_model.dart';

class NotFoundAnyAccountsWidget extends StatefulWidget {
  const NotFoundAnyAccountsWidget({Key? key}) : super(key: key);

  @override
  _NotFoundAnyAccountsWidgetState createState() =>
      _NotFoundAnyAccountsWidgetState();
}

class _NotFoundAnyAccountsWidgetState extends State<NotFoundAnyAccountsWidget> {
  late NotFoundAnyAccountsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotFoundAnyAccountsModel());

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

    return Align(
      alignment: AlignmentDirectional(0.0, -0.1),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
        child: Text(
          'You dont have any subscriptions , please add some account ID to track',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).displaySmall,
        ),
      ),
    );
  }
}
