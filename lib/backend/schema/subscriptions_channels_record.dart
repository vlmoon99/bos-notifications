import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SubscriptionsChannelsRecord extends FirestoreRecord {
  SubscriptionsChannelsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "accountId" field.
  String? _accountId;
  String get accountId => _accountId ?? '';
  bool hasAccountId() => _accountId != null;

  // "subscribersFcmTokens" field.
  List<String>? _subscribersFcmTokens;
  List<String> get subscribersFcmTokens => _subscribersFcmTokens ?? const [];
  bool hasSubscribersFcmTokens() => _subscribersFcmTokens != null;

  void _initializeFields() {
    _accountId = snapshotData['accountId'] as String?;
    _subscribersFcmTokens = getDataList(snapshotData['subscribersFcmTokens']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('subscriptions_channels');

  static Stream<SubscriptionsChannelsRecord> getDocument(
          DocumentReference ref) =>
      ref.snapshots().map((s) => SubscriptionsChannelsRecord.fromSnapshot(s));

  static Future<SubscriptionsChannelsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => SubscriptionsChannelsRecord.fromSnapshot(s));

  static SubscriptionsChannelsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SubscriptionsChannelsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SubscriptionsChannelsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SubscriptionsChannelsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SubscriptionsChannelsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SubscriptionsChannelsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSubscriptionsChannelsRecordData({
  String? accountId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'accountId': accountId,
    }.withoutNulls,
  );

  return firestoreData;
}

class SubscriptionsChannelsRecordDocumentEquality
    implements Equality<SubscriptionsChannelsRecord> {
  const SubscriptionsChannelsRecordDocumentEquality();

  @override
  bool equals(
      SubscriptionsChannelsRecord? e1, SubscriptionsChannelsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.accountId == e2?.accountId &&
        listEquality.equals(e1?.subscribersFcmTokens, e2?.subscribersFcmTokens);
  }

  @override
  int hash(SubscriptionsChannelsRecord? e) =>
      const ListEquality().hash([e?.accountId, e?.subscribersFcmTokens]);

  @override
  bool isValidKey(Object? o) => o is SubscriptionsChannelsRecord;
}
