import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

const _repoUrl = 'https://github.com/paxel/catlog';
const _issuesUrl = '$_repoUrl/issues';
const _feedbackMail = 'taum@tuta.io';

/// Where "buy me a coffee" points. Swap for your Ko-fi / Liberapay /
/// BuyMeACoffee page once it exists. Hidden on iOS: Apple requires
/// In-App Purchase for developer tips there (App Store rule 3.1.1).
const _donateUrl = 'https://ko-fi.com/paxel';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _open(String url) =>
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

  @override
  Widget build(BuildContext context) {
    final showDonate = !Platform.isIOS;
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
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
                ? 'Version ${snapshot.data!.version} (${snapshot.data!.buildNumber})'
                : ''),
          ),
        ),
        const SizedBox(height: 8),
        const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'A local-first catalog for foster cats. Your data lives on '
              'your devices — no server, no account.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ListTile(
          leading: const Icon(Icons.code),
          title: const Text('Source code'),
          subtitle: const Text('$_repoUrl — Apache-2.0 / MIT'),
          onTap: () => _open(_repoUrl),
        ),
        ListTile(
          leading: const Icon(Icons.bug_report_outlined),
          title: const Text('Report a problem or idea'),
          subtitle: const Text('GitHub issues'),
          onTap: () => _open(_issuesUrl),
        ),
        ListTile(
          leading: const Icon(Icons.mail_outline),
          title: const Text('Write the developer'),
          subtitle: const Text(_feedbackMail),
          onTap: () => _open(
              'mailto:$_feedbackMail?subject=cat(a)log%20feedback'),
        ),
        if (showDonate)
          ListTile(
            leading: const Icon(Icons.coffee_outlined),
            title: const Text('Buy the developer a coffee'),
            subtitle: const Text('Entirely optional — the app is free'),
            onTap: () => _open(_donateUrl),
          ),
        ListTile(
          leading: const Icon(Icons.description_outlined),
          title: const Text('Open-source licenses'),
          onTap: () => showLicensePage(
            context: context,
            applicationName: 'cat(a)log',
          ),
        ),
      ]),
    );
  }
}
