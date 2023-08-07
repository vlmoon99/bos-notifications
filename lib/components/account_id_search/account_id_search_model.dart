import '/components/account_id_search_card/account_id_search_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AccountIdSearchModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this component.

  // Model for AccountIdSearchCard component.
  late AccountIdSearchCardModel accountIdSearchCardModel1;
  // Model for AccountIdSearchCard component.
  late AccountIdSearchCardModel accountIdSearchCardModel2;
  // Model for AccountIdSearchCard component.
  late AccountIdSearchCardModel accountIdSearchCardModel3;
  // Model for AccountIdSearchCard component.
  late AccountIdSearchCardModel accountIdSearchCardModel4;
  // Model for AccountIdSearchCard component.
  late AccountIdSearchCardModel accountIdSearchCardModel5;
  // Model for AccountIdSearchCard component.
  late AccountIdSearchCardModel accountIdSearchCardModel6;
  // Model for AccountIdSearchCard component.
  late AccountIdSearchCardModel accountIdSearchCardModel7;
  // State field(s) for TextField widget.
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    accountIdSearchCardModel1 =
        createModel(context, () => AccountIdSearchCardModel());
    accountIdSearchCardModel2 =
        createModel(context, () => AccountIdSearchCardModel());
    accountIdSearchCardModel3 =
        createModel(context, () => AccountIdSearchCardModel());
    accountIdSearchCardModel4 =
        createModel(context, () => AccountIdSearchCardModel());
    accountIdSearchCardModel5 =
        createModel(context, () => AccountIdSearchCardModel());
    accountIdSearchCardModel6 =
        createModel(context, () => AccountIdSearchCardModel());
    accountIdSearchCardModel7 =
        createModel(context, () => AccountIdSearchCardModel());
  }

  void dispose() {
    accountIdSearchCardModel1.dispose();
    accountIdSearchCardModel2.dispose();
    accountIdSearchCardModel3.dispose();
    accountIdSearchCardModel4.dispose();
    accountIdSearchCardModel5.dispose();
    accountIdSearchCardModel6.dispose();
    accountIdSearchCardModel7.dispose();
    textController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
