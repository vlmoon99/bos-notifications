import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'test_component_model.dart';
export 'test_component_model.dart';

class TestComponentWidget extends StatefulWidget {
  const TestComponentWidget({Key? key}) : super(key: key);

  @override
  _TestComponentWidgetState createState() => _TestComponentWidgetState();
}

class _TestComponentWidgetState extends State<TestComponentWidget> {
  late TestComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TestComponentModel());

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

    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        await currentUserReference!.update({
          ...mapToFirestore(
            {
              'accountDeleted': FieldValue.arrayUnion([
                getAccountsDeletedFirestoreData(
                  createAccountsDeletedStruct(
                    name: 'sdfg',
                    date: getCurrentTimestamp,
                    clearUnsetFields: false,
                  ),
                  true,
                )
              ]),
            },
          ),
        });
      },
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
      ),
    );
  }
}
