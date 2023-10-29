import '/auth/firebase_auth/auth_util.dart';
import '/components/account_deleting/account_deleting_widget.dart';
import '/components/subscribe_bottom_bar/subscribe_bottom_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'account_page_widget.dart' show AccountPageWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AccountPageModel extends FlutterFlowModel<AccountPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Models for accountDeleting dynamic component.
  late FlutterFlowDynamicModels<AccountDeletingModel> accountDeletingModels;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    accountDeletingModels =
        FlutterFlowDynamicModels(() => AccountDeletingModel());
  }

  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    accountDeletingModels.dispose();
  }

  /// Action blocks are added here.

  Future buttonColor(BuildContext context) async {}

  /// Additional helper methods are added here.
}
