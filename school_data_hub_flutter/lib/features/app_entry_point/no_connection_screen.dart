import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return Scaffold(
      backgroundColor: style.colors.canvas,
      body: Container(
        decoration: BoxDecoration(color: style.colors.accent),
        child: Center(
          child: SizedBox(
            height: 500,
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
                  'Keine Internetverbindung!',
                  style: context.typography.title.withColor(
                    style.colors.background,
                  ).copyWith(fontSize: 25),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
