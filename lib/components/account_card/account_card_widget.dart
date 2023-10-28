import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'account_card_model.dart';
export 'account_card_model.dart';

class AccountCardWidget extends StatefulWidget {
  const AccountCardWidget({Key? key}) : super(key: key);

  @override
  _AccountCardWidgetState createState() => _AccountCardWidgetState();
}

class _AccountCardWidgetState extends State<AccountCardWidget> {
  late AccountCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AccountCardModel());

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
      width: MediaQuery.sizeOf(context).width * 0.7,
      height: MediaQuery.sizeOf(context).height * 0.06,
      constraints: BoxConstraints(
        maxWidth: 300.0,
        maxHeight: 60.0,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFFAF9F8),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(2.0, 3.0, 2.0, 3.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 7.0, 0.0),
              child: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.network(
                      'data:image/png;base64,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',
                    ).image,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _model.accountName,
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
                Text(
                  'Platform',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        color: Color(0xFF7E7E7E),
                        fontSize: 12.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyMediumFamily),
                      ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional(1.00, 0.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 3.0, 0.0),
                  child: FlutterFlowIconButton(
                    borderColor: Color(0x004B39EF),
                    borderRadius: 30.0,
                    borderWidth: 0.0,
                    buttonSize: 40.0,
                    fillColor: Color(0x00FDFDFD),
                    icon: FaIcon(
                      FontAwesomeIcons.solidTrashAlt,
                      color: Color(0xFFFF7966),
                      size: 20.0,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
