import 'package:flutter_svg/flutter_svg.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'account_deleted_model.dart';
export 'account_deleted_model.dart';

class AccountDeletedWidget extends StatefulWidget {
  const AccountDeletedWidget({
    Key? key,
    required this.name,
    required this.dataDeleted,
  }) : super(key: key);

  final String? name;
  final DateTime? dataDeleted;

  @override
  _AccountDeletedWidgetState createState() => _AccountDeletedWidgetState();
}

class _AccountDeletedWidgetState extends State<AccountDeletedWidget> {
  late AccountDeletedModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AccountDeletedModel());

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
      height: 50.0,
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
                      valueOrDefault<String>(
                        functions.imageReturn(widget.name!),
                        'https://i.near.social/magic/large/https://near.social/magic/img/account/sesona.near',
                      ),
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
                  widget.name!,
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional(1.00, 0.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 3.0, 0.0),
                  child: StreamBuilder<List<UsersRecord>>(
                    stream: queryUsersRecord(
                      singleRecord: true,
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                          ),
                        );
                      }

                      // Return an empty Container when the item does not exist.
                      if (snapshot.data!.isEmpty) {
                        return Container();
                      }

                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          child: SvgPicture.asset(
                            'assets/icons/undo.svg',
                            height: 24,
                          ),
                          onTap: () async {
                            var docRef = FirebaseFirestore.instance
                                .collection("users")
                                .doc("accountDeleted");
                            docRef.get().then(
                              (DocumentSnapshot docRef) async {
                                List<Map<String, dynamic>> data =
                                    docRef.data() as List<Map<String, dynamic>>;
                                data.removeWhere((element) =>
                                    element.containsValue(widget.name));
                                await currentUserReference?.update({
                                  ...mapToFirestore({
                                    'accountDeleted': data,
                                  })
                                });
                              },
                              onError: (e) =>
                                  print("Error getting document: $e"),
                            );

                            // await currentUserReference?.update({
                            //   ...mapToFirestore(
                            //     {'accountDeleted': XXXXXXX},
                            //   ),
                            // });

                            await currentUserReference?.update({
                              ...mapToFirestore(
                                {
                                  'subscriptions':
                                      FieldValue.arrayUnion([widget.name]),
                                },
                              ),
                            });
                          },
                        ),
                      );
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
