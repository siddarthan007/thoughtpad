import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:thoughtpad/models/thought_model.dart';
import 'package:thoughtpad/screens/read_thought.dart';

class ThoughtWidget extends StatelessWidget {
  final Thought thought;
  const ThoughtWidget({super.key, required this.thought});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ReadThoughtScreen(thought: thought)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primary),
              child: Column(
                children: [
                  Text(
                    DateFormat(DateFormat.ABBR_MONTH).format(thought.createdAt),
                    style: GoogleFonts.lato(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    DateFormat(DateFormat.DAY).format(thought.createdAt),
                    style: GoogleFonts.lato(
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.primaryFixed),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 3),
                  Text(DateFormat(DateFormat.YEAR).format(thought.createdAt),
                      style: GoogleFonts.lato(
                          color: Theme.of(context).colorScheme.inversePrimary))
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(thought.title,
                            style: GoogleFonts.cairo(
                                textStyle:
                                    Theme.of(context).textTheme.titleMedium),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis)),
                    Text(
                      DateFormat(DateFormat.HOUR_MINUTE_TZ)
                          .format(thought.createdAt),
                      style: GoogleFonts.cairo(
                          textStyle: Theme.of(context).textTheme.bodySmall),
                    ),
                  ],
                ),
                Text(thought.content,
                    style: GoogleFonts.cairo(
                        fontWeight: FontWeight.w300, height: 1.5),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
