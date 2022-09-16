import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts/models/contact.dart';
import 'package:contacts/repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeContacts extends StatefulWidget {
  const HomeContacts({super.key});

  @override
  State<HomeContacts> createState() => _HomeContactsState();
}

class _HomeContactsState extends State<HomeContacts> {
  final DataRepository reposity = DataRepository();
  final boldStyle =
      const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: reposity.getStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LinearProgressIndicator();
          }
          return _buildList(context, snapshot.data?.docs ?? []);
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((e) => _buildListItem(context, e)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final contact = Contact.fromSnapshot(snapshot);
    return ContactCard(
      contact: contact,
      boldStyle: boldStyle,
    );
  }
}

class ContactCard extends StatelessWidget {
  const ContactCard(
      {super.key, required this.contact, required this.boldStyle});

  final Contact contact;
  final TextStyle boldStyle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  contact.name,
                  style: boldStyle,
                ),
              ),
            ),
          ],
        ),
        // onTap: ,
      ),
    );
  }
}
