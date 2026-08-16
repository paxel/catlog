import 'dart:io';

import 'package:catalog_core/catalog_core.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../celebration.dart';
import '../l10n.dart';
import 'moderation_screen.dart';

const _repoUrl = 'https://github.com/paxel/catlog';
const _issuesUrl = '$_repoUrl/issues';
const _feedbackMail = 'taum@tuta.io';

/// Where "buy me a coffee" points. Swap for your Ko-fi / Liberapay /
/// BuyMeACoffee page once it exists. Hidden on iOS: Apple requires
/// In-App Purchase for developer tips there (App Store rule 3.1.1).
const _donateUrl = 'https://ko-fi.com/paxel7';

class AboutScreen extends StatefulWidget {
  final CatalogStore store;

  const AboutScreen({super.key, required this.store});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {

  Future<void> _open(String url) =>
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final showDonate = !Platform.isIOS;
    return Scaffold(
      appBar: AppBar(title: Text(t.about)),
      body: ListView(children: [
        const SizedBox(height: 24),
        const Center(child: Icon(Icons.pets, size: 64)),
        const SizedBox(height: 8),
        Center(
          child: Text('cat(a)log',
              style: Theme.of(context).textTheme.headlineMedium),
        ),
        Center(
          child: FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) => Text(snapshot.hasData
                ? t.versionLabel(snapshot.data!.version,
                    snapshot.data!.buildNumber)
                : ''),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              t.aboutTagline,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SwitchListTile(
          secondary: const Icon(Icons.celebration_outlined),
          title: Text(t.celebrationsToggle),
          subtitle: Text(t.celebrationsSubtitle),
          value: celebrationsEnabled(widget.store),
          onChanged: (v) =>
              setState(() => setCelebrationsEnabled(widget.store, v)),
        ),
        ListTile(
          leading: const Icon(Icons.code),
          title: Text(t.sourceCode),
          subtitle: const Text('$_repoUrl — Apache-2.0 / MIT'),
          onTap: () => _open(_repoUrl),
        ),
        ListTile(
          leading: const Icon(Icons.bug_report_outlined),
          title: Text(t.reportProblemOrIdea),
          subtitle: Text(t.githubIssues),
          onTap: () => _open(_issuesUrl),
        ),
        ListTile(
          leading: const Icon(Icons.mail_outline),
          title: Text(t.writeTheDeveloper),
          subtitle: const Text(_feedbackMail),
          onTap: () => _open(
              'mailto:$_feedbackMail?subject=cat(a)log%20feedback'),
        ),
        if (showDonate)
          ListTile(
            leading: const Icon(Icons.coffee_outlined),
            title: Text(t.buyCoffee),
            subtitle: Text(t.coffeeSubtitle),
            onTap: () => _open(_donateUrl),
          ),
        ListTile(
          leading: const Icon(Icons.person_off_outlined),
          title: Text(t.moderationTitle),
          subtitle: Text(t.moderationSubtitle),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ModerationScreen(store: widget.store),
          )),
        ),
        ListTile(
          leading: const Icon(Icons.description_outlined),
          title: Text(t.openSourceLicenses),
          onTap: () => showLicensePage(
            context: context,
            applicationName: 'cat(a)log',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            t.machineTranslated,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ),
      ]),
    );
  }
}
