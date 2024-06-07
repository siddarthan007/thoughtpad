import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thoughtpad/models/thought_model.dart';
import 'package:thoughtpad/providers/thought_provider.dart';
import 'package:thoughtpad/screens/add_thought.dart';

class ReadThoughtScreen extends StatefulWidget {
  final Thought thought;
  const ReadThoughtScreen({super.key, required this.thought});

  @override
  State<ReadThoughtScreen> createState() => _ReadThoughtScreenState();
}

class _ReadThoughtScreenState extends State<ReadThoughtScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thought', style: GoogleFonts.cabin()),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            AddThoughtScreen(thought: widget.thought)));
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Text(
                            "Are you sure you want to delete this thought?",
                            style: GoogleFonts.cabin(),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("No",
                                    style: GoogleFonts.cabin(
                                        fontWeight: FontWeight.bold))),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _deleteThought();
                                },
                                child: Text("Yes",
                                    style: GoogleFonts.cabin(
                                        fontWeight: FontWeight.bold)))
                          ],
                        ));
              },
              icon: const Icon(Icons.delete_outline))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.thought.title,
                  style: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      textStyle: Theme.of(context).textTheme.headlineLarge)),
              const SizedBox(height: 5),
              Text(DateFormat().format(widget.thought.createdAt),
                  style: GoogleFonts.cabin(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                      textStyle: Theme.of(context).textTheme.titleSmall)),
              const SizedBox(height: 30),
              Text(widget.thought.content,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.bitter(
                      color: Theme.of(context).colorScheme.secondary,
                      textStyle: Theme.of(context).textTheme.bodyMedium))
            ],
          ),
        ),
      ),
    );
  }

  _deleteThought() {
    Provider.of<ThoughtProvider>(context, listen: false)
        .delete(thought: widget.thought)
        .then((isDone) {
      Navigator.pop(context);
    });
  }
}
