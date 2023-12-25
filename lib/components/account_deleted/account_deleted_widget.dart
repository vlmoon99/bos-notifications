import 'package:b_o_s_notifications/local_DataBase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

  final String name;
  final DateTime dataDeleted;

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
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  shape: BoxShape.circle,
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://i.near.social/magic/large/https://near.social/magic/img/account/${widget.name}',
                  errorWidget: (context, url, error) {
                    return SvgPicture.network(url);
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    widget.name!,
                    overflow: TextOverflow.ellipsis,
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
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
                            DatabaseHelper dbHelper = DatabaseHelper();
                            var db = await dbHelper.db;

                            FFAppState().update(
                              () async {
                                await dbHelper.deleteRecordByName(widget.name);
                                FFAppState()
                                    .deletedAccountList
                                    .add(await db.query('myDB'));
                              },
                            );

                            await currentUserReference?.update({
                              ...mapToFirestore(
                                {
                                  'subscriptions':
                                      FieldValue.arrayUnion([widget.name]),
                                },
                              ),
                            });
                            final uid = FirebaseAuth.instance.currentUser!.uid;
                            final token =
                                await FirebaseMessaging.instance.getToken();

                            final isThisAccountIdChannelExist =
                                (await FirebaseFirestore.instance
                                            .collection(
                                                'subscriptions_channels')
                                            .doc(widget.name)
                                            .get())
                                        .data()
                                        ?.isNotEmpty ??
                                    false;

                            if (isThisAccountIdChannelExist) {
                              await FirebaseFirestore.instance
                                  .collection('subscriptions_channels')
                                  .doc(widget.name)
                                  .update({uid: token});
                            } else {
                              await FirebaseFirestore.instance
                                  .collection('subscriptions_channels')
                                  .doc(widget.name)
                                  .set({uid: token});
                            }
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
