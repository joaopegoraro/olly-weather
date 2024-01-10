import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

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
    if (kIsWeb) {
      return Container(
        height: 80,
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              flex: 3,
              child: SvgPicture(
                AssetBytesLoader('assets/vectors/logo.svg.vec'),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                title,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: onGeolocate,
                    icon: Icon(
                      Icons.gps_fixed,
                      color: colorScheme.primary,
                    ),
                    label: Text(
                      "Find your location",
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  TextButton(
                    onPressed: openSettings,
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  TextButton.icon(
                    onPressed: onLogout,
                    icon: Icon(
                      Icons.logout,
                      color: colorScheme.onPrimary,
                    ),
                    label: Text(
                      "Logout",
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
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
}
