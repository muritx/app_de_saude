import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late DatabaseReference _messagesRef;
  final TextEditingController _textEditingController = TextEditingController();
  final List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _messagesRef = FirebaseDatabase.instance.reference().child('messages');
    _messagesRef.onChildAdded.listen((event) => _onMessageAdded(event.snapshot));
  }

  void _onMessageAdded(DataSnapshot snapshot) {
    final messageData = snapshot.value as Map<dynamic, dynamic>?;
    if (messageData != null) {
      final message = Message(
        messageData['text'] ?? '',
        DateTime.fromMillisecondsSinceEpoch(messageData['timestamp'] ?? 0),
      );
      setState(() {
        _messages.add(message);
      });
    }
  }

  void _sendMessage(String text) {
    _messagesRef.push().set({
      'text': text,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(message.text),
                  subtitle: Text(message.timestamp.toString()),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Enviar mensagem',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    final text = _textEditingController.text.trim();
                    if (text.isNotEmpty) {
                      _sendMessage(text);
                      _textEditingController.clear();
                    }
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final DateTime timestamp;

  Message(this.text, this.timestamp);
}
