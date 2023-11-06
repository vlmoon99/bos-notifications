import '/components/history_account_deleted/history_account_deleted_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'settings_page_widget.dart' show SettingsPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsPageModel extends FlutterFlowModel<SettingsPageWidget> {
  ///  State fields for stateful widgets in this page.
  final unfocusNode = FocusNode();
  // State field(s) for Switch widget.
  bool? history;
  bool? switchValue;
  // Model for historyAccountDeleted component.
  late HistoryAccountDeletedModel historyAccountDeletedModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    historyAccountDeletedModel =
        createModel(context, () => HistoryAccountDeletedModel());
  }

  void dispose() {
    unfocusNode.dispose();
    historyAccountDeletedModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
