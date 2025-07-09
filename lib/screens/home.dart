import 'package:flutter/material.dart';
import 'package:hibiscus/screens/note_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final _user = FirebaseAuth.instance.currentUser;
  String? _avatarLink;

  Stream<QuerySnapshot> getUserNotes() {
    if (_user == null) return const Stream.empty();

    return FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid)
        .collection('notes')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  @override
  void initState() {
    super.initState();
    _avatarLink = _user?.photoURL;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: SizedBox(height: 40),
        body: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Hibiscus',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            ),
                            Text(
                              'Let Your Ideas Bloom',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(12),
                              ),
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                              },
                              child: const Icon(Icons.logout),
                            ),
                            const SizedBox(width: 10),
                            CircleAvatar(
                              backgroundImage: NetworkImage(_avatarLink ?? ''),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: getUserNotes(),
                        builder: (context, snapshot) {
                          // check if it is loading, if iti s loading then we do circular loading
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          // check the notes loading is finished and if docs is empty then do this.
                          // maybe use some good image using the Network image widget
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text("No notes yet. Create one!"),
                            );
                          }

                          // get the notes
                          final notes = snapshot.data!.docs;

                          return ListView.builder(
                            itemCount: notes.length,
                            itemBuilder: (context, index) {
                              final doc = notes[index];
                              final title = doc['title'] ?? 'Untitled';
                              final content = doc['content'] ?? '';

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => NotePage(note: doc),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            title,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          PopupMenuButton<String>(
                                            onSelected: (value) {
                                              if (value == 'delete') {
                                                // delete the note
                                                FirebaseFirestore.instance.collection('users').doc(_user?.uid).collection('notes').doc(doc.id).delete();
                                              }
                                            },
                                            itemBuilder:
                                                (
                                                  BuildContext context,
                                                ) => <PopupMenuEntry<String>>[
                                                  const PopupMenuItem<String>(
                                                    value: 'delete',
                                                    child: Text('Delete'),
                                                  ),
                                                ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        content,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: 20,
              left: MediaQuery.of(context).size.width / 2 - 28,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => const NotePage()),
                  );
                },
                child: const Icon(Icons.note_add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
