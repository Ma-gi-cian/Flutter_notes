import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  final DocumentSnapshot? note; // If null → new note

  const NotePage({super.key, this.note});

  @override
  State<NotePage> createState() => _NotePage();
}

class _NotePage extends State<NotePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      _titleController.text = widget.note!['title'] ?? '';
      _contentController.text = widget.note!['content'] ?? '';
    }
  }

  Future<void> _saveNote() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final notesRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('notes');

    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty && content.isEmpty) {
      Navigator.pop(context); // Don’t save empty note
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      if (widget.note == null) {
        // New note
        await notesRef.add({
          'title': title,
          'content': content,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      } else {
        // Existing note
        await widget.note!.reference.update({
          'title': title,
          'content': content,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
      Navigator.pop(context); // Go back after save
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save note')),
      );
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: _isSaving
                ? CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  )
                : Icon(Icons.check),
            onPressed: _isSaving ? null : _saveNote,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLines: 1,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                decoration: InputDecoration.collapsed(hintText: 'Title'),
              ),
              SizedBox(height: 20),
              Expanded(
                child: TextField(
                  controller: _contentController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration:
                      InputDecoration.collapsed(hintText: 'Start writing your thoughts...'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
