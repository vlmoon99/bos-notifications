// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AccountsDeletedStruct extends FFFirebaseStruct {
  AccountsDeletedStruct({
    String? name,
    DateTime? date,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _date = date,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;
  bool hasName() => _name != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;
  bool hasDate() => _date != null;

  static AccountsDeletedStruct fromMap(Map<String, dynamic> data) =>
      AccountsDeletedStruct(
        name: data['name'] as String?,
        date: data['date'] as DateTime?,
      );

  static AccountsDeletedStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? AccountsDeletedStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'date': _date,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static AccountsDeletedStruct fromSerializableMap(Map<String, dynamic> data) =>
      AccountsDeletedStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'AccountsDeletedStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AccountsDeletedStruct &&
        name == other.name &&
        date == other.date;
  }

  @override
  int get hashCode => const ListEquality().hash([name, date]);
}

AccountsDeletedStruct createAccountsDeletedStruct({
  String? name,
  DateTime? date,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AccountsDeletedStruct(
      name: name,
      date: date,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AccountsDeletedStruct? updateAccountsDeletedStruct(
  AccountsDeletedStruct? accountsDeleted, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    accountsDeleted
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAccountsDeletedStructData(
  Map<String, dynamic> firestoreData,
  AccountsDeletedStruct? accountsDeleted,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (accountsDeleted == null) {
    return;
  }
  if (accountsDeleted.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && accountsDeleted.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final accountsDeletedData =
      getAccountsDeletedFirestoreData(accountsDeleted, forFieldValue);
  final nestedData =
      accountsDeletedData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = accountsDeleted.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAccountsDeletedFirestoreData(
  AccountsDeletedStruct? accountsDeleted, [
  bool forFieldValue = false,
]) {
  if (accountsDeleted == null) {
    return {};
  }
  final firestoreData = mapToFirestore(accountsDeleted.toMap());

  // Add any Firestore field values
  accountsDeleted.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAccountsDeletedListFirestoreData(
  List<AccountsDeletedStruct>? accountsDeleteds,
) =>
    accountsDeleteds
        ?.map((e) => getAccountsDeletedFirestoreData(e, true))
        .toList() ??
    [];
