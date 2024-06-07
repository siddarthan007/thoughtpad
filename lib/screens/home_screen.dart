import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thoughtpad/screens/add_thought.dart';
import 'package:provider/provider.dart';
import 'package:thoughtpad/providers/thought_provider.dart';
import 'package:thoughtpad/widgets/thought_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ThoughtPad', style: GoogleFonts.cabin()),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showAdaptiveDialog(
                    context: context,
                    builder: (context) => AlertDialog.adaptive(
                          content: Text(
                              "App created as a part of ELC activity of B.E. CSE second semester at Thapar Institute of Engineering and Technology, Patiala.",
                              style: GoogleFonts.cabin()),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("OK",
                                    style: GoogleFonts.cabin(
                                        fontWeight: FontWeight.bold)))
                          ],
                        ));
              },
              icon: const Icon(Icons.code))
        ],
      ),
      body: Consumer<ThoughtProvider>(
        builder: (context, provider, child) {
          return provider.thoughts.isEmpty
              ? Center(
                  child: Text(
                  'No Thoughts :(',
                  style: GoogleFonts.lato(
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                              color:
                                  Theme.of(context).colorScheme.primaryFixed),
                      fontWeight: FontWeight.bold),
                ))
              : ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  children: provider.thoughts
                      .map((e) => Dismissible(
                          key: Key(e.title),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            Provider.of<ThoughtProvider>(context, listen: false)
                                .delete(thought: e);
                          },
                          background: Container(
                              color: Colors.red,
                              child: const Icon(Icons.delete,
                                  color: Colors.white)),
                          child: ThoughtWidget(thought: e)))
                      .toList(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddThoughtScreen()));
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
