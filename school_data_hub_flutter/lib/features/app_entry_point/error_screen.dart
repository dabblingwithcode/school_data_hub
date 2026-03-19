import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class ErrorScreen extends StatelessWidget {
  final String error;
  const ErrorScreen({required this.error, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return Scaffold(
      backgroundColor: style.colors.canvas,
      body: Container(
        decoration: BoxDecoration(color: style.colors.accent),
        child: Center(
          child: SizedBox(
            height: 600,
            width: 600,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 300,
                  width: 300,
                  child: Image(image: AssetImage('assets/foreground.png')),
                ),
                Text(
                  "Schuldaten App",
                  style: context.typography.title.withColor(
                    style.colors.background,
                  ).copyWith(fontSize: 30),
                ),
                const Gap(30),
                Text(
                  "Ein Fehler ist aufgetreten!",
                  style: context.typography.title.withColor(
                    style.colors.error,
                  ).copyWith(fontSize: 22),
                ),
                const Gap(20),
                Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            error,
                            style: context.typography.title.withColor(
                              style.colors.background,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.copy, color: style.colors.background),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: error));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Fehlertext in die Zwischenablage kopiert!',
                            ),
                          ),
                        );
                      },
                    ),
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
