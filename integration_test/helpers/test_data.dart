import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

import 'fake_providers.dart' show testUid;

Future<void> seedRecord(
  FakeFirebaseFirestore firestore, {
  required String date,
  String mood = 'よかった',
  String text = 'テスト記録',
  List<String> stamps = const [],
}) async {
  await firestore
      .collection('records')
      .doc(testUid)
      .collection('entries')
      .add({
    'mood': mood,
    'text': text,
    'date': date,
    'stamps': stamps,
    'createdAt': Timestamp.fromDate(DateTime.parse('${date}T12:00:00')),
  });
}

Future<void> seedFeedback(
  FakeFirebaseFirestore firestore, {
  required String date,
  String affirmation = 'よく頑張りました。',
  List<String> steps = const ['小さな一歩1', '小さな一歩2'],
}) async {
  await firestore
      .collection('ai_feedbacks')
      .doc(testUid)
      .collection('days')
      .doc(date)
      .set({
    'affirmation': affirmation,
    'emotion': {
      'positive_rate': 80,
      'trend': '上向き',
      'summary': 'ポジティブな傾向',
    },
    'steps': steps,
    'generatedAt': Timestamp.fromDate(DateTime.parse('${date}T23:00:00')),
  });
}

Future<void> clearFirestore(FakeFirebaseFirestore firestore) async {
  final entries = await firestore
      .collection('records')
      .doc(testUid)
      .collection('entries')
      .get();
  for (final doc in entries.docs) {
    await doc.reference.delete();
  }

  final days = await firestore
      .collection('ai_feedbacks')
      .doc(testUid)
      .collection('days')
      .get();
  for (final doc in days.docs) {
    await doc.reference.delete();
  }
}
