import 'package:flutter/material.dart';

class Topbar extends StatelessWidget implements PreferredSizeWidget {
  const Topbar({
    super.key,
    required this.title,
    required this.onGeolocate,
    required this.openSettings,
    required this.onLogout,
  });

  final String title;
  final VoidCallback onGeolocate;
  final VoidCallback openSettings;
  final VoidCallback onLogout;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SliverAppBar(
      toolbarHeight: 80,
      backgroundColor: colorScheme.primary,
      automaticallyImplyLeading: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      actions: [
        IconButton(
          onPressed: onGeolocate,
          icon: Icon(
            Icons.gps_fixed,
            color: colorScheme.onPrimary,
          ),
        ),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: PopupMenuButton(
            child: Icon(
              Icons.more_vert,
              color: colorScheme.onPrimary,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: openSettings,
                child: const Text('Settings'),
              ),
              PopupMenuItem(
                onTap: onLogout,
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ],
      title: Text(
        title,
        maxLines: 2,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }
}
