import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:thoughtpad/models/thought_model.dart';
import 'package:thoughtpad/providers/thought_provider.dart';

class AddThoughtScreen extends StatefulWidget {
  final Thought? thought;
  const AddThoughtScreen({super.key, this.thought});

  @override
  State<AddThoughtScreen> createState() => _AddThoughtScreenState();
}

class _AddThoughtScreenState extends State<AddThoughtScreen> {
  final _title = TextEditingController();
  final _content = TextEditingController();

  @override
  void initState() {
    if (widget.thought != null) {
      _title.text = widget.thought!.title;
      _content.text = widget.thought!.content;
    }
    super.initState();
  }

  @override
  void dispose() {
    _title.dispose();
    _content.dispose();
    super.dispose();
  }

  String? get _titleErrorText {
    final title = _title.value.text;

    if (title.isEmpty) {
      return 'Please enter a title for your thought.';
    }

    return null;
  }

  String? get _contentErrorText {
    final content = _content.value.text;

    if (content.isEmpty) {
      return 'Empty mind? Not possible!';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.thought != null ? 'Edit Thought' : 'Add Thought',
            style: GoogleFonts.cabin()),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: widget.thought == null
                  ? (_title.value.text.isNotEmpty &&
                          _content.value.text.isNotEmpty)
                      ? _insertThought
                      : null
                  : (_title.value.text.isNotEmpty &&
                          _content.value.text.isNotEmpty)
                      ? _updateThought
                      : null,
              icon: const Icon(Icons.done)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: _title,
              textCapitalization: TextCapitalization.words,
              style: GoogleFonts.cairo(),
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: GoogleFonts.cairo(),
                  errorText: _titleErrorText,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(height: 15),
            Expanded(
                child: TextField(
              controller: _content,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (_) => setState(() {}),
              maxLines: 20,
              style: GoogleFonts.cairo(),
              decoration: InputDecoration(
                  hintText: 'What\'s on your mind?',
                  hintStyle: GoogleFonts.cairo(),
                  errorText: _contentErrorText,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            )),
          ],
        ),
      ),
    );
  }

  _insertThought() {
    final Thought thought = Thought(
        title: _title.text, content: _content.text, createdAt: DateTime.now());
    Provider.of<ThoughtProvider>(context, listen: false)
        .insert(thought: thought);
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  _updateThought() {
    final Thought thought = Thought(
        id: widget.thought!.id,
        title: _title.text,
        content: _content.text,
        createdAt: DateTime.now());
    Provider.of<ThoughtProvider>(context, listen: false)
        .update(thought: thought);
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
