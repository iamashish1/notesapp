import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNotes extends StatelessWidget {
  AddNotes({Key? key}) : super(key: key);

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async {
                try {
                  await ref.add({
                    'title': titleController.text,
                    'content': contentController.text
                  }).whenComplete(() {
                    Navigator.pop(context);
                  });
                } catch (e) {
                  Future.error(e.toString());
                }
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
      body: Container(
        margin:
            const EdgeInsets.only(right: 20, left: 20, bottom: 100, top: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Title'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: contentController,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(hintText: 'Content'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
