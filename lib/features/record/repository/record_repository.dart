import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niwa_app/features/auth/state/auth_state.dart';
import 'package:niwa_app/features/record/models/record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'record_repository.g.dart';

@riverpod
RecordRepository recordRepository(Ref ref) {
  final user = ref.watch(authNotifierProvider).user;
  return RecordRepository(FirebaseFirestore.instance, user!.uid);
}

class RecordRepository {
  RecordRepository(this._db, this._userId);
  final FirebaseFirestore _db;
  final String _userId;

  CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection('records').doc(_userId).collection('entries');

  Record _recordFromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Record(
      id: doc.id,
      mood: data['mood'] as String,
      text: data['text'] as String,
      date: data['date'] as String,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      stamps: List<String>.from(data['stamps'] as List<dynamic>? ?? []),
    );
  }

  Stream<List<Record>> watchAllRecords() {
    final query = _col.orderBy('createdAt', descending: true);
    return query.snapshots().map((snap) {
      return snap.docs.map(_recordFromDoc).toList();
    });
  }

  Stream<List<Record>> watchTodayRecords(String date) {
    final query = _col
        .where('date', isEqualTo: date)
        .orderBy('createdAt', descending: true);

    return query.snapshots().map((snap) {
      return snap.docs.map(_recordFromDoc).toList();
    });
  }

  Future<void> addRecord({
    required String mood,
    required String text,
    required String date,
    required List<String> stamps,
  }) async {
    await _col.add({
      'mood': mood,
      'text': text,
      'date': date,
      'stamps': stamps,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
