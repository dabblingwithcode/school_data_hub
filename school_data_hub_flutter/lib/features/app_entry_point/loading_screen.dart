import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/logger/presentation/logs_screen/logs_screen.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';

final _envManager = di<EnvManager>();

class LoadingScreen extends WatchingStatefulWidget {
  const LoadingScreen({super.key});

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final style = Style.of(context);

    return Scaffold(
      backgroundColor: style.colors.canvas,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: style.colors.accent),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double maxContentWidth = constraints.maxWidth >= 600
                ? 600
                : constraints.maxWidth;
            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: Style.spacing.xl,
                  vertical: Style.spacing.xxl,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxContentWidth),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 300,
                        width: 300,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (ctx) => const LogsScreen(),
                              ),
                            );
                          },
                          child: const Image(
                            image: AssetImage('assets/foreground.png'),
                          ),
                        ),
                      ),
                      Text(
                        locale.schoolDataHub,
                        textAlign: TextAlign.center,
                        style: context.typography.title
                            .withColor(style.colors.background)
                            .copyWith(fontSize: 30),
                      ),
                      const Gap(15),
                      if (_envManager.activeEnv != null)
                        Text(
                          _envManager.activeEnv!.serverName,
                          textAlign: TextAlign.center,
                          style: context.typography.title.withColor(
                            style.colors.background,
                          ),
                        ),
                      const Gap(40),
                      Text(
                        'Lade Daten...',
                        textAlign: TextAlign.center,
                        style: context.typography.title.withColor(
                          style.colors.background,
                        ),
                      ),
                      const Gap(30),
                      CircularProgressIndicator(color: style.colors.background),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
