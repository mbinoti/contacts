import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {
  String? referenceId;
  String name;
  String? lastName;
  String? phone;
  String? email;
  String? birthDate;
  Contact(
    this.name, {
    required this.lastName,
    required this.phone,
    required this.email,
    required this.birthDate,
    this.referenceId,
  });

  factory Contact.fromSnapshot(DocumentSnapshot snapshot) {
    final newContact =
        Contact.fromJson(snapshot.data() as Map<String, dynamic>);
    newContact.referenceId = snapshot.reference.id;
    return newContact;
  }

  factory Contact.fromJson(Map<String, dynamic> json) => _contactFromJson(json);

  Map<String, dynamic> toJson() => _contactToJson(this);
}

Contact _contactFromJson(Map<String, dynamic> json) {
  return Contact(
    json['name'] as String,
    lastName: json['lastName'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String,
    birthDate: json['birthDate'] as String,
  );
}

Map<String, dynamic> _contactToJson(Contact instance) => <String, dynamic>{
      'name': instance.name,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'email': instance.email,
      'birthDate': instance.birthDate,
    };
