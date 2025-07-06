import 'package:flutter/material.dart';

void main() => runApp(Notes());

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column( crossAxisAlignment: CrossAxisAlignment.start , children:[Text(
                      'Hibiscus',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ), Text('Let Your Ideas Bloom', style: TextStyle(fontSize: 12))]),

                    CircleAvatar(
                      backgroundImage: NetworkImage("https://avatars.githubusercontent.com/u/142375774?v=4"),
                    )
                  ],
                ),

                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
