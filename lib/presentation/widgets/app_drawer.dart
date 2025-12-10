import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/theme_bloc/theme_bloc.dart';
import '../../logic/theme_bloc/theme_event.dart';
import '../../logic/theme_bloc/theme_state.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 42,
          left: 16,
          right: 16,
          bottom: 16,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const SizedBox(height: 10),
            Center(
              child: Container(
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
            ),

            const SizedBox(height: 10),

            Center(
              child: Text(
                "Gourav Kumar",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),

            const SizedBox(height: 8),

            Center(
              child: Text(
                "Flutter Developer | UI/UX Enthusiast",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

            const SizedBox(height: 15),
            const Divider(),
            const SizedBox(height: 10),

            Text(
              "About Me",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              "A passionate Flutter developer who loves building modern, smooth and beautiful mobile apps. "
              "Experience with BLoC, REST APIs, Firebase, and clean architecture.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 18),
            const Divider(),
            const SizedBox(height: 12),

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
            const SizedBox(height: 10),

            _drawerOption(
              icon: Icons.email,
              title: "Email",
              value: "gouravlambha007@gmail.com",
            ),

            _drawerOption(
              icon: Icons.phone,
              title: "Phone",
              value: "+91 7455868820",
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerOption({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(title),
      subtitle: Text(value),
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
    );
  }
}
