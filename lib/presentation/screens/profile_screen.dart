import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/theme_bloc/theme_bloc.dart';
import '../../logic/theme_bloc/theme_event.dart';
import '../../logic/theme_bloc/theme_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: const AssetImage("assets/images/avatar.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text("Gourav", style: Theme.of(context).textTheme.headlineSmall),

            const SizedBox(height: 8),

            Text(
              "Flutter Developer | UI/UX Enthusiast",
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 20),

            const Divider(),

            const SizedBox(height: 16),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "About Me",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "A passionate Flutter developer who loves building modern, smooth and beautiful mobile apps. "
              "Experience with BLoC, REST APIs, Firebase, and clean architecture.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 24),

            const Divider(),

            const SizedBox(height: 16),

            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, themeState) {
                return SwitchListTile(
                  title: const Text("Dark Mode"),
                  secondary: Icon(
                    themeState.isDark ? Icons.dark_mode : Icons.light_mode,
                    size: 30,
                  ),
                  value: themeState.isDark,
                  onChanged: (val) {
                    context.read<ThemeBloc>().add(ToggleThemeEvent());
                  },
                );
              },
            ),

            const Divider(),

            const SizedBox(height: 16),

            _profileOption(
              icon: Icons.email,
              title: "Email",
              value: "gouravlambha007@gmail.com",
            ),

            _profileOption(
              icon: Icons.phone,
              title: "Phone",
              value: "+91 7455868820",
            ),

            _profileOption(
              icon: Icons.info,
              title: "App Version",
              value: "3.0.0",
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
                backgroundColor: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileOption({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return ListTile(
      leading: Icon(icon, size: 28),
      title: Text(title),
      subtitle: Text(value),
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
    );
  }
}
