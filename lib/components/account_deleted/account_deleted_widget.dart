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
                      List<UsersRecord> iconButtonUsersRecordList =
                          snapshot.data!;
                      // Return an empty Container when the item does not exist.
                      if (snapshot.data!.isEmpty) {
                        return Container();
                      }
                      final iconButtonUsersRecord =
                          iconButtonUsersRecordList.isNotEmpty
                              ? iconButtonUsersRecordList.first
                              : null;
                      return FlutterFlowIconButton(
                        borderColor: Color(0x004B39EF),
                        borderRadius: 30.0,
                        borderWidth: 0.0,
                        buttonSize: 40.0,
                        fillColor: Color(0x00FDFDFD),
                        icon: FaIcon(
                          FontAwesomeIcons.redoAlt,
                          color: Colors.black,
                          size: 20.0,
                        ),
                        onPressed: () async {
                          await currentUserReference!.update({
                            ...mapToFirestore(
                              {
                                'subscriptions':
                                    FieldValue.arrayUnion([widget.name]),
                              },
                            ),
                          });

                          await iconButtonUsersRecord!.reference.update({
                            ...mapToFirestore(
                              {
                                'subscriptions': (currentUserDocument
                                        ?.subscriptions
                                        ?.toList() ??
                                    []),
                              },
                            ),
                          });

                          await currentUserReference!.update({
                            ...mapToFirestore(
                              {
                                'accountDeleted': FieldValue.arrayRemove([
                                  getAccountsDeletedFirestoreData(
                                    updateAccountsDeletedStruct(
                                      (currentUserDocument?.accountDeleted
                                                  ?.toList() ??
                                              [])
                                          .where((e) => e.name == widget.name)
                                          .toList()
                                          .first,
                                      clearUnsetFields: false,
                                    ),
                                    true,
                                  )
                                ]),
                              },
                            ),
                          });

                          await iconButtonUsersRecord!.reference.update({
                            ...mapToFirestore(
                              {
                                'accountDeleted': FieldValue.arrayRemove([
                                  getAccountsDeletedFirestoreData(
                                    updateAccountsDeletedStruct(
                                      iconButtonUsersRecord?.accountDeleted
                                          ?.where((e) => e.name == widget.name)
                                          .toList()
                                          ?.first,
                                      clearUnsetFields: true,
                                    ),
                                    true,
                                  )
                                ]),
                              },
                            ),
                          });
                        },
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
