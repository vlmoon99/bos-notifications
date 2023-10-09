// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SubscriptionStruct extends FFFirebaseStruct {
  SubscriptionStruct({
    String? accountId,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _accountId = accountId,
        super(firestoreUtilData);

  // "accountId" field.
  String? _accountId;
  String get accountId => _accountId ?? '';
  set accountId(String? val) => _accountId = val;
  bool hasAccountId() => _accountId != null;

  static SubscriptionStruct fromMap(Map<String, dynamic> data) =>
      SubscriptionStruct(
        accountId: data['accountId'] as String?,
      );

  static SubscriptionStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? SubscriptionStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'accountId': _accountId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'accountId': serializeParam(
          _accountId,
          ParamType.String,
        ),
      }.withoutNulls;

  static SubscriptionStruct fromSerializableMap(Map<String, dynamic> data) =>
      SubscriptionStruct(
        accountId: deserializeParam(
          data['accountId'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'SubscriptionStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SubscriptionStruct && accountId == other.accountId;
  }

  @override
  int get hashCode => const ListEquality().hash([accountId]);
}

SubscriptionStruct createSubscriptionStruct({
  String? accountId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SubscriptionStruct(
      accountId: accountId,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SubscriptionStruct? updateSubscriptionStruct(
  SubscriptionStruct? subscription, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    subscription
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSubscriptionStructData(
  Map<String, dynamic> firestoreData,
  SubscriptionStruct? subscription,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (subscription == null) {
    return;
  }
  if (subscription.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && subscription.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final subscriptionData =
      getSubscriptionFirestoreData(subscription, forFieldValue);
  final nestedData =
      subscriptionData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = subscription.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSubscriptionFirestoreData(
  SubscriptionStruct? subscription, [
  bool forFieldValue = false,
]) {
  if (subscription == null) {
    return {};
  }
  final firestoreData = mapToFirestore(subscription.toMap());

  // Add any Firestore field values
  subscription.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSubscriptionListFirestoreData(
  List<SubscriptionStruct>? subscriptions,
) =>
    subscriptions?.map((e) => getSubscriptionFirestoreData(e, true)).toList() ??
    [];
