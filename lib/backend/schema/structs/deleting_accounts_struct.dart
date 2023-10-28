// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DeletingAccountsStruct extends FFFirebaseStruct {
  DeletingAccountsStruct({
    String? accountName,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _accountName = accountName,
        super(firestoreUtilData);

  // "accountName" field.
  String? _accountName;
  String get accountName => _accountName ?? '';
  set accountName(String? val) => _accountName = val;
  bool hasAccountName() => _accountName != null;

  static DeletingAccountsStruct fromMap(Map<String, dynamic> data) =>
      DeletingAccountsStruct(
        accountName: data['accountName'] as String?,
      );

  static DeletingAccountsStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic>
          ? DeletingAccountsStruct.fromMap(data)
          : null;

  Map<String, dynamic> toMap() => {
        'accountName': _accountName,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'accountName': serializeParam(
          _accountName,
          ParamType.String,
        ),
      }.withoutNulls;

  static DeletingAccountsStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      DeletingAccountsStruct(
        accountName: deserializeParam(
          data['accountName'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DeletingAccountsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DeletingAccountsStruct && accountName == other.accountName;
  }

  @override
  int get hashCode => const ListEquality().hash([accountName]);
}

DeletingAccountsStruct createDeletingAccountsStruct({
  String? accountName,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DeletingAccountsStruct(
      accountName: accountName,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DeletingAccountsStruct? updateDeletingAccountsStruct(
  DeletingAccountsStruct? deletingAccounts, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    deletingAccounts
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDeletingAccountsStructData(
  Map<String, dynamic> firestoreData,
  DeletingAccountsStruct? deletingAccounts,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (deletingAccounts == null) {
    return;
  }
  if (deletingAccounts.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && deletingAccounts.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final deletingAccountsData =
      getDeletingAccountsFirestoreData(deletingAccounts, forFieldValue);
  final nestedData =
      deletingAccountsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = deletingAccounts.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDeletingAccountsFirestoreData(
  DeletingAccountsStruct? deletingAccounts, [
  bool forFieldValue = false,
]) {
  if (deletingAccounts == null) {
    return {};
  }
  final firestoreData = mapToFirestore(deletingAccounts.toMap());

  // Add any Firestore field values
  deletingAccounts.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getDeletingAccountsListFirestoreData(
  List<DeletingAccountsStruct>? deletingAccountss,
) =>
    deletingAccountss
        ?.map((e) => getDeletingAccountsFirestoreData(e, true))
        .toList() ??
    [];
