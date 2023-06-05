import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {
  const TextComposer({Key? key, required this.sendMessage}) : super(key: key);

  final Function(String text) sendMessage;

  @override
  State<TextComposer> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final TextEditingController _editController = TextEditingController();
  bool _isComposing = false;

  void reset() {
    _editController.clear();
    _isComposing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _editController,
            decoration: InputDecoration.collapsed(hintText: 'Enviar mensagem'),
            onChanged: (event) {
              setState(() {
                _isComposing = event.isNotEmpty;
              });
            },
            onSubmitted: (text) {
              widget.sendMessage(text);
              reset();
            },
          ),
        ),
        IconButton(
          onPressed: _isComposing
              ? () {
            widget.sendMessage(_editController.text);
            reset();
          }
              : null,
          icon: Icon(Icons.send),
        ),
      ],
    );
  }
}
