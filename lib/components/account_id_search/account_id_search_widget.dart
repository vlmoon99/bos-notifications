import '/components/account_id_search_card/account_id_search_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'account_id_search_model.dart';
export 'account_id_search_model.dart';

class AccountIdSearchWidget extends StatefulWidget {
  const AccountIdSearchWidget({Key? key}) : super(key: key);

  @override
  _AccountIdSearchWidgetState createState() => _AccountIdSearchWidgetState();
}

class _AccountIdSearchWidgetState extends State<AccountIdSearchWidget> {
  late AccountIdSearchModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AccountIdSearchModel());

    _model.textController ??= TextEditingController();
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
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: 900.0,
        height: MediaQuery.sizeOf(context).height * 1.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8.0, 160.0, 8.0, 0.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    wrapWithModel(
                      model: _model.accountIdSearchCardModel1,
                      updateCallback: () => setState(() {}),
                      child: AccountIdSearchCardWidget(),
                    ),
                    wrapWithModel(
                      model: _model.accountIdSearchCardModel2,
                      updateCallback: () => setState(() {}),
                      child: AccountIdSearchCardWidget(),
                    ),
                    wrapWithModel(
                      model: _model.accountIdSearchCardModel3,
                      updateCallback: () => setState(() {}),
                      child: AccountIdSearchCardWidget(),
                    ),
                    wrapWithModel(
                      model: _model.accountIdSearchCardModel4,
                      updateCallback: () => setState(() {}),
                      child: AccountIdSearchCardWidget(),
                    ),
                    wrapWithModel(
                      model: _model.accountIdSearchCardModel5,
                      updateCallback: () => setState(() {}),
                      child: AccountIdSearchCardWidget(),
                    ),
                    wrapWithModel(
                      model: _model.accountIdSearchCardModel6,
                      updateCallback: () => setState(() {}),
                      child: AccountIdSearchCardWidget(),
                    ),
                    wrapWithModel(
                      model: _model.accountIdSearchCardModel7,
                      updateCallback: () => setState(() {}),
                      child: AccountIdSearchCardWidget(),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, -1.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 100.0, 8.0, 0.0),
                child: Container(
                  width: 350.0,
                  child: TextFormField(
                    controller: _model.textController,
                    autofocus: true,
                    textCapitalization: TextCapitalization.none,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Account ID',
                      labelStyle: FlutterFlowTheme.of(context).labelLarge,
                      hintStyle: FlutterFlowTheme.of(context).labelMedium,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).nEARAqua,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).nEARPurple,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).nEARRed,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).nEARRed,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium,
                    textAlign: TextAlign.start,
                    validator:
                        _model.textControllerValidator.asValidator(context),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, -0.95),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 50.0,
                borderWidth: 0.0,
                buttonSize: 60.0,
                fillColor: FlutterFlowTheme.of(context).nEARAqua,
                icon: Icon(
                  Icons.close,
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  size: 24.0,
                ),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
