import 'package:flutter/material.dart';

/// Responsive utilities for handling different screen sizes and orientations
class ResponsiveUtils {
  static const double _mobileBreakpoint = 600;
  static const double _tabletBreakpoint = 900;
  static const double _desktopBreakpoint = 1200;

  /// Get screen size category based on width
  static ScreenSize getScreenSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width < _mobileBreakpoint) {
      return ScreenSize.mobile;
    } else if (width < _tabletBreakpoint) {
      return ScreenSize.tablet;
    } else if (width < _desktopBreakpoint) {
      return ScreenSize.desktop;
    } else {
      return ScreenSize.largeDesktop;
    }
  }

  /// Check if current screen is mobile
  static bool isMobile(BuildContext context) {
    return getScreenSize(context) == ScreenSize.mobile;
  }

  /// Check if current screen is tablet
  static bool isTablet(BuildContext context) {
    return getScreenSize(context) == ScreenSize.tablet;
  }

  /// Check if current screen is desktop
  static bool isDesktop(BuildContext context) {
    return getScreenSize(context) == ScreenSize.desktop;
  }

  /// Check if current screen is large desktop
  static bool isLargeDesktop(BuildContext context) {
    return getScreenSize(context) == ScreenSize.largeDesktop;
  }

  /// Get responsive padding based on screen size
  static EdgeInsets getResponsivePadding(BuildContext context) {
    final screenSize = getScreenSize(context);
    
    switch (screenSize) {
      case ScreenSize.mobile:
        return const EdgeInsets.all(16.0);
      case ScreenSize.tablet:
        return const EdgeInsets.all(24.0);
      case ScreenSize.desktop:
        return const EdgeInsets.all(32.0);
      case ScreenSize.largeDesktop:
        return const EdgeInsets.all(40.0);
    }
  }

  /// Get responsive margin based on screen size
  static EdgeInsets getResponsiveMargin(BuildContext context) {
    final screenSize = getScreenSize(context);
    
    switch (screenSize) {
      case ScreenSize.mobile:
        return const EdgeInsets.all(8.0);
      case ScreenSize.tablet:
        return const EdgeInsets.all(16.0);
      case ScreenSize.desktop:
        return const EdgeInsets.all(24.0);
      case ScreenSize.largeDesktop:
        return const EdgeInsets.all(32.0);
    }
  }

  /// Get responsive font size based on screen size
  static double getResponsiveFontSize(BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    final screenSize = getScreenSize(context);
    
    switch (screenSize) {
      case ScreenSize.mobile:
        return mobile ?? 14.0;
      case ScreenSize.tablet:
        return tablet ?? 16.0;
      case ScreenSize.desktop:
        return desktop ?? 18.0;
      case ScreenSize.largeDesktop:
        return largeDesktop ?? 20.0;
    }
  }

  /// Get responsive icon size based on screen size
  static double getResponsiveIconSize(BuildContext context) {
    final screenSize = getScreenSize(context);
    
    switch (screenSize) {
      case ScreenSize.mobile:
        return 20.0;
      case ScreenSize.tablet:
        return 24.0;
      case ScreenSize.desktop:
        return 28.0;
      case ScreenSize.largeDesktop:
        return 32.0;
    }
  }

  /// Get responsive card elevation based on screen size
  static double getResponsiveCardElevation(BuildContext context) {
    final screenSize = getScreenSize(context);
    
    switch (screenSize) {
      case ScreenSize.mobile:
        return 2.0;
      case ScreenSize.tablet:
        return 3.0;
      case ScreenSize.desktop:
        return 4.0;
      case ScreenSize.largeDesktop:
        return 5.0;
    }
  }

  /// Get responsive border radius based on screen size
  static double getResponsiveBorderRadius(BuildContext context) {
    final screenSize = getScreenSize(context);
    
    switch (screenSize) {
      case ScreenSize.mobile:
        return 8.0;
      case ScreenSize.tablet:
        return 12.0;
      case ScreenSize.desktop:
        return 16.0;
      case ScreenSize.largeDesktop:
        return 20.0;
    }
  }

  /// Get responsive spacing based on screen size
  static double getResponsiveSpacing(BuildContext context) {
    final screenSize = getScreenSize(context);
    
    switch (screenSize) {
      case ScreenSize.mobile:
        return 8.0;
      case ScreenSize.tablet:
        return 12.0;
      case ScreenSize.desktop:
        return 16.0;
      case ScreenSize.largeDesktop:
        return 20.0;
    }
  }

  /// Get responsive grid cross axis count based on screen size
  static int getResponsiveGridCrossAxisCount(BuildContext context) {
    final screenSize = getScreenSize(context);
    
    switch (screenSize) {
      case ScreenSize.mobile:
        return 1;
      case ScreenSize.tablet:
        return 2;
      case ScreenSize.desktop:
        return 3;
      case ScreenSize.largeDesktop:
        return 4;
    }
  }

  /// Get responsive list item height based on screen size
  static double getResponsiveListItemHeight(BuildContext context) {
    final screenSize = getScreenSize(context);
    
    switch (screenSize) {
      case ScreenSize.mobile:
        return 80.0;
      case ScreenSize.tablet:
        return 100.0;
      case ScreenSize.desktop:
        return 120.0;
      case ScreenSize.largeDesktop:
        return 140.0;
    }
  }

  /// Get responsive button height based on screen size
  static double getResponsiveButtonHeight(BuildContext context) {
    final screenSize = getScreenSize(context);
    
    switch (screenSize) {
      case ScreenSize.mobile:
        return 48.0;
      case ScreenSize.tablet:
        return 56.0;
      case ScreenSize.desktop:
        return 64.0;
      case ScreenSize.largeDesktop:
        return 72.0;
    }
  }

  /// Get responsive app bar height based on screen size
  static double getResponsiveAppBarHeight(BuildContext context) {
    final screenSize = getScreenSize(context);
    
    switch (screenSize) {
      case ScreenSize.mobile:
        return kToolbarHeight;
      case ScreenSize.tablet:
        return kToolbarHeight + 8;
      case ScreenSize.desktop:
        return kToolbarHeight + 16;
      case ScreenSize.largeDesktop:
        return kToolbarHeight + 24;
    }
  }

  /// Check if device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Check if device is in portrait mode
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  /// Get safe area padding
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Get screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Get available height (screen height - app bar - safe area)
  static double getAvailableHeight(BuildContext context) {
    final screenHeight = getScreenHeight(context);
    final appBarHeight = getResponsiveAppBarHeight(context);
    final safeArea = getSafeAreaPadding(context);
    
    return screenHeight - appBarHeight - safeArea.top - safeArea.bottom;
  }
}

/// Screen size categories
enum ScreenSize {
  mobile,
  tablet,
  desktop,
  largeDesktop,
} 