import 'dart:math';

abstract class MyProgressStatus {
  const MyProgressStatus();
}

class MyProgress {
  final String description;
  final bool hasSubmission;
  final int id;
  final String name;

  const MyProgress(
      {required this.description,
      required this.hasSubmission,
      required this.id,
      required this.name});

  factory MyProgress.fromJson(Map<String, dynamic>? data) {
    if (data == null) {
      throw e;
    }
    return MyProgress(
      description: data['description'],
      hasSubmission: true,
      id: data['id'],
      name: data['name'],
    );
  }
}

class MyProgresError extends MyProgressStatus {}

class MyProgressSuccess extends MyProgressStatus {
  final Iterable<MyProgress> myProgress;

  const MyProgressSuccess({required this.myProgress});
}
