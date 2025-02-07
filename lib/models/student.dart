import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  String? userId;
  String? name;
  String? major;
  String? email;

  Student({this.userId, this.name, this.major, this.email});

  // تحويل البيانات إلى Map لحفظها في Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'major': major,
      'email': email,
    };
  }

  // إنشاء كائن `Student` من بيانات Firestore
  factory Student.fromMap(Map<String, dynamic> data) {
    return Student(
      userId: data['userId'],
      name: data['name'],
      major: data['major'],
      email: data['email'],
    );
  }

  // حفظ بيانات الطالب في Firestore
  Future<void> saveToFirestore() async {
    await FirebaseFirestore.instance
        .collection('students')
        .doc(userId)
        .set(toMap());
  }

  // البحث عن طالب في Firestore باستخدام `userId`
  static Future<Student?> getStudentById(String userId) async {
    var doc = await FirebaseFirestore.instance
        .collection('students')
        .doc(userId)
        .get();

    if (doc.exists) {
      return Student.fromMap(doc.data()!);
    }
    return null;
  }
}
