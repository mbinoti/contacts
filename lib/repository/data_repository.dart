import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts/models/contact.dart';

class DataRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('contacts');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addContact(Contact contact) {
    return collection.add(contact.toJson());
  }

  void updateContact(Contact contact) async {
    await collection.doc(contact.referenceId).update(contact.toJson());
  }

  void deleteContact(Contact contact) async {
    await collection.doc(contact.referenceId).delete();
  }
}
