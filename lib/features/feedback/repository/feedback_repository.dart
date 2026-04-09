import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niwa_app/features/auth/state/auth_state.dart';
import 'package:niwa_app/features/feedback/models/ai_feedback.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feedback_repository.g.dart';

@riverpod
FeedbackRepository feedbackRepository(Ref ref) {
  final user = ref.watch(authNotifierProvider).user;
  return FeedbackRepository(FirebaseFirestore.instance, user!.uid);
}

class FeedbackRepository {
  FeedbackRepository(this._db, this._userId);
  final FirebaseFirestore _db;
  final String _userId;

  AiFeedback _feedbackFromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return AiFeedback(
      date: doc.id,
      affirmation: data['affirmation'] as String,
      emotion: EmotionSummary.fromJson(data['emotion'] as Map<String, dynamic>),
      steps: List<String>.from(data['steps'] as List),
      generatedAt: (data['generatedAt'] as Timestamp).toDate(),
    );
  }

  Stream<AiFeedback?> watchFeedbackByDate(String date) {
    final docRef = _db
        .collection('ai_feedbacks')
        .doc(_userId)
        .collection('days')
        .doc(date);

    return docRef.snapshots().map((doc) {
      if (!doc.exists) return null;
      return _feedbackFromDoc(doc);
    });
  }

  Stream<AiFeedback?> watchTodayFeedback(String date) {
    final docRef = _db
        .collection('ai_feedbacks')
        .doc(_userId)
        .collection('days')
        .doc(date);

    return docRef.snapshots().map((doc) {
      if (!doc.exists) return null;
      return _feedbackFromDoc(doc);
    });
  }
}
