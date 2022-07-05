import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wandering_wheels/models/anaysis_model.dart';

class AnalyticsProvider extends ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;

  createAnalysisReport({
    required String type,
    required String title,
    required String content,
  }) async {
    Analysis analysis = Analysis(
      type: type,
      content: content,
      invokeTime: DateTime.now(),
      title: title,
    );
    var res = await _isActivated();
    if (res) {
      await db.collection('analysis').doc(analysis.invokeTime.toString()).set(
            analysis.toJson(),
          );
    }
  }

  Future<bool> _isActivated() async {
    var isActive = false;
    var result = await db.collection('flags').doc('analysis').get();
    isActive = result.data()!['activate'];
    return isActive;
  }
}
