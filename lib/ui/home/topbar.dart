import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olly_weather/ui/theme/spacing.dart';
import 'package:olly_weather/ui/theme/text.dart';
import 'package:olly_weather/ui/theme/theme.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

class Topbar extends StatelessWidget implements PreferredSizeWidget {
  const Topbar({
    super.key,
    required this.title,
    required this.onGeolocate,
    required this.openSettings,
    required this.onLogout,
    required this.isWebDesign,
  });

  final String title;
  final VoidCallback onGeolocate;
  final VoidCallback openSettings;
  final VoidCallback onLogout;
  final bool isWebDesign;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    if (isWebDesign) {
      return AppBar(
        toolbarHeight: OllyWeatherTheme.appBarHeight,
        leadingWidth: screenWidth > OllyWeatherTheme.tabletWidth ? 200 : 150,
        backgroundColor: colorScheme.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              OllyWeatherSpacing.largeRadius,
            ),
            bottomRight: Radius.circular(
              OllyWeatherSpacing.largeRadius,
            ),
          ),
        ),
        leading: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: OllyWeatherSpacing.bigPadding,
            vertical: OllyWeatherSpacing.smallPadding,
          ),
          child: SvgPicture(
            AssetBytesLoader('assets/vectors/logo.svg.vec'),
          ),
        ),
        centerTitle: screenWidth > OllyWeatherTheme.tabletWidth,
        title: Text(
          title,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: OllyWeatherText.largeStyle.copyWith(
            color: colorScheme.onPrimary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(
              OllyWeatherSpacing.tinyPadding,
            ),
            child: Wrap(
              children: [
                ElevatedButton.icon(
                  onPressed: onGeolocate,
                  icon: Icon(
                    Icons.gps_fixed,
                    color: colorScheme.primary,
                  ),
                  label: Flexible(
                    child: Text(
                      "Find your location",
                      maxLines: 2,
                      style: OllyWeatherText.regularStyle.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: openSettings,
                  child: Text(
                    'Settings',
                    style: OllyWeatherText.regularStyle.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: onLogout,
                  icon: Icon(
                    Icons.logout,
                    color: colorScheme.onPrimary,
                  ),
                  label: Text(
                    "Logout",
                    style: OllyWeatherText.regularStyle.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return SliverAppBar(
        toolbarHeight: OllyWeatherTheme.appBarHeight,
        backgroundColor: colorScheme.primary,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              OllyWeatherSpacing.largeRadius,
            ),
            bottomRight: Radius.circular(
              OllyWeatherSpacing.largeRadius,
            ),
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
          OllyWeatherSpacing.horizontalSpaceSmall,
          Padding(
            padding: const EdgeInsets.only(
              right: OllyWeatherSpacing.mediumPadding,
            ),
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
          style: OllyWeatherText.largeStyle.copyWith(
            color: colorScheme.onPrimary,
          ),
        ),
      );
    }
  }
}
