import 'dart:convert';

import 'package:app/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessageWidget> _messages = [];
  final TextEditingController _textController = TextEditingController();
  Future<void> _sendMessageToGeminiAI(String message) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: 'AIzaSyCx65Jd-JtDpWuOUo8QfWO6TfSXEKps9zk',
      );
      final response = await model.generateContent([Content.text(message)]);
      final aiMessage = response.text ?? 'Error getting AI response.';
      setState(() {
        _messages.insert(
          0,
          ChatMessageWidget(
            isMe: false,
            message: aiMessage,
            senderName: 'Gemini AI',
            timestamp: '${DateTime.now().hour}:${DateTime.now().minute}',
          ),
        );
      });
      _saveChatHistory();
    } catch (e) {
      setState(() {
        _messages.insert(
          0,
          ChatMessageWidget(
            isMe: false,
            message: 'Error: $e',
            senderName: 'Gemini AI',
            timestamp: '${DateTime.now().hour}:${DateTime.now().minute}',
          ),
        );
      });
      _saveChatHistory();
    }
  }

  Future<void> _loadChatHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('chat_history') ?? [];
    setState(() {
      _messages.addAll(
          history.map((json) => ChatMessageWidget.fromJson(jsonDecode(json))));
    });
  }

  Future<void> _saveChatHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history =
        _messages.map((message) => jsonEncode(message.toJson())).toList();
    await prefs.setStringList('chat_history', history);
  }

  @override
  void initState() {
    super.initState();
    _loadChatHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
          MessageInputArea(
            onSend: (message) {
              setState(() {
                _messages.insert(
                  0,
                  ChatMessageWidget(
                    isMe: true,
                    message: message,
                    senderName: 'You',
                    timestamp:
                        '${DateTime.now().hour}:${DateTime.now().minute}',
                  ),
                );
              });
              _sendMessageToGeminiAI(message);
              _textController.clear();
            },
            textController: _textController,
          ),
        ],
      ),
    );
  }
}

class MessageInputArea extends StatelessWidget {
  final Function(String) onSend;
  final TextEditingController textController;
  MessageInputArea({required this.onSend, required this.textController});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (textController.text.isNotEmpty) {
                onSend(textController.text);
              }
            },
          ),
        ],
      ),
    );
  }
}

class ChatMessageWidget extends StatelessWidget {
  final bool isMe;
  final String message;
  final String senderName;
  final String timestamp;
  ChatMessageWidget({
    required this.isMe,
    required this.message,
    required this.senderName,
    required this.timestamp,
  });

  factory ChatMessageWidget.fromJson(Map<String, dynamic> json) {
    return ChatMessageWidget(
      isMe: json['isMe'],
      message: json['message'],
      senderName: json['senderName'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isMe': isMe,
      'message': message,
      'senderName': senderName,
      'timestamp': timestamp,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isMe ? AppColors.boxStartColor : Colors.grey.shade800,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              senderName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(message),
            Text(
              timestamp,
              style: TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}

// class ChatMessageWidget extends StatelessWidget {
//   final bool isMe;
//   final String message;
//   final String senderName;
//   final String timestamp;

//   ChatMessageWidget({
//     required this.isMe,
//     required this.message,
//     required this.senderName,
//     required this.timestamp,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: EdgeInsets.all(8.0),
//         padding: EdgeInsets.all(12.0),
//         decoration: BoxDecoration(
//           color: isMe ? Colors.blue[100] : Colors.green[100],
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         child: Column(
//           crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//           children: [
//             Text(senderName, style: TextStyle(fontWeight: FontWeight.bold)),
//             Text(message),
//             Text(timestamp, style: TextStyle(fontSize: 12.0)),
//           ],
//         ),
//       ),
//     );
//   }
// }
