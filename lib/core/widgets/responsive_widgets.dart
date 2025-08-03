import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';

/// Responsive container that adapts to screen size
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final Decoration? decoration;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final Clip? clipBehavior;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.decoration,
    this.width,
    this.height,
    this.alignment,
    this.clipBehavior,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? ResponsiveUtils.getResponsivePadding(context),
      margin: margin ?? ResponsiveUtils.getResponsiveMargin(context),
      color: color,
      decoration: decoration,
      width: width,
      height: height,
      alignment: alignment,
      clipBehavior: clipBehavior ?? Clip.none,
      child: child,
    );
  }
}

/// Responsive card that adapts to screen size
class ResponsiveCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final double? elevation;
  final double? borderRadius;
  final VoidCallback? onTap;

  const ResponsiveCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.elevation,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? ResponsiveUtils.getResponsiveCardElevation(context),
      margin: margin ?? ResponsiveUtils.getResponsiveMargin(context),
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          borderRadius ?? ResponsiveUtils.getResponsiveBorderRadius(context),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          borderRadius ?? ResponsiveUtils.getResponsiveBorderRadius(context),
        ),
        child: Padding(
          padding: padding ?? ResponsiveUtils.getResponsivePadding(context),
          child: child,
        ),
      ),
    );
  }
}

/// Responsive text that adapts font size to screen size
class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? mobileFontSize;
  final double? tabletFontSize;
  final double? desktopFontSize;
  final double? largeDesktopFontSize;

  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.mobileFontSize,
    this.tabletFontSize,
    this.desktopFontSize,
    this.largeDesktopFontSize,
  });

  @override
  Widget build(BuildContext context) {
    final fontSize = ResponsiveUtils.getResponsiveFontSize(
      context,
      mobile: mobileFontSize,
      tablet: tabletFontSize,
      desktop: desktopFontSize,
      largeDesktop: largeDesktopFontSize,
    );

    return Text(
      text,
      style: style?.copyWith(fontSize: fontSize) ?? TextStyle(fontSize: fontSize),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Responsive button that adapts to screen size
class ResponsiveButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Widget? icon;
  final ButtonStyle? style;
  final bool isLoading;
  final bool isOutlined;

  const ResponsiveButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.style,
    this.isLoading = false,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonHeight = ResponsiveUtils.getResponsiveButtonHeight(context);
    final fontSize = ResponsiveUtils.getResponsiveFontSize(context);

    final buttonStyle = style ??
        (isOutlined
            ? OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, buttonHeight),
                textStyle: TextStyle(fontSize: fontSize),
              )
            : ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, buttonHeight),
                textStyle: TextStyle(fontSize: fontSize),
              ));

    if (isOutlined) {
      return OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: buttonStyle,
        child: _buildButtonChild(),
      );
    } else {
      return ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: buttonStyle,
        child: _buildButtonChild(),
      );
    }
  }

  Widget _buildButtonChild() {
    if (isLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: 8),
          Text(text),
        ],
      );
    }

    return Text(text);
  }
}

/// Responsive icon button that adapts to screen size
class ResponsiveIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final double? size;
  final String? tooltip;

  const ResponsiveIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.size,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = size ?? ResponsiveUtils.getResponsiveIconSize(context);

    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: iconSize, color: color),
      tooltip: tooltip,
    );
  }
}

/// Responsive grid that adapts column count to screen size
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double? crossAxisSpacing;
  final double? mainAxisSpacing;
  final double? childAspectRatio;
  final EdgeInsets? padding;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
    this.childAspectRatio,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = ResponsiveUtils.getResponsiveGridCrossAxisCount(context);
    final spacing = ResponsiveUtils.getResponsiveSpacing(context);

    return GridView.count(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: crossAxisSpacing ?? spacing,
      mainAxisSpacing: mainAxisSpacing ?? spacing,
      childAspectRatio: childAspectRatio ?? 1.0,
      padding: padding ?? ResponsiveUtils.getResponsivePadding(context),
      children: children,
    );
  }
}

/// Responsive list view that adapts to screen size
class ResponsiveListView extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? padding;
  final double? itemSpacing;
  final ScrollController? controller;
  final bool? primary;

  const ResponsiveListView({
    super.key,
    required this.children,
    this.padding,
    this.itemSpacing,
    this.controller,
    this.primary,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = itemSpacing ?? ResponsiveUtils.getResponsiveSpacing(context);

    return ListView.separated(
      padding: padding ?? ResponsiveUtils.getResponsivePadding(context),
      controller: controller,
      primary: primary,
      itemCount: children.length,
      separatorBuilder: (context, index) => SizedBox(height: spacing),
      itemBuilder: (context, index) => children[index],
    );
  }
}

/// Responsive app bar that adapts to screen size
class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;

  const ResponsiveAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    final appBarHeight = ResponsiveUtils.getResponsiveAppBarHeight(context);
    final fontSize = ResponsiveUtils.getResponsiveFontSize(
      context,
      mobile: 18.0,
      tablet: 20.0,
      desktop: 22.0,
      largeDesktop: 24.0,
    );

    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontSize: fontSize),
      ),
      actions: actions,
      leading: leading,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation ?? ResponsiveUtils.getResponsiveCardElevation(context),
      toolbarHeight: appBarHeight,
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}

/// Responsive spacing widget
class ResponsiveSpacing extends StatelessWidget {
  final bool isVertical;
  final double? multiplier;

  const ResponsiveSpacing({
    super.key,
    this.isVertical = true,
    this.multiplier,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = ResponsiveUtils.getResponsiveSpacing(context);
    final finalSpacing = spacing * (multiplier ?? 1.0);

    return SizedBox(
      height: isVertical ? finalSpacing : null,
      width: isVertical ? null : finalSpacing,
    );
  }
}

/// Responsive divider with spacing
class ResponsiveDivider extends StatelessWidget {
  final Color? color;
  final double? thickness;
  final double? indent;
  final double? endIndent;

  const ResponsiveDivider({
    super.key,
    this.color,
    this.thickness,
    this.indent,
    this.endIndent,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = ResponsiveUtils.getResponsiveSpacing(context);

    return Divider(
      color: color,
      thickness: thickness ?? 1.0,
      indent: indent ?? spacing,
      endIndent: endIndent ?? spacing,
    );
  }
}

/// Responsive floating action button
class ResponsiveFloatingActionButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const ResponsiveFloatingActionButton({
    super.key,
    required this.child,
    this.onPressed,
    this.tooltip,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = ResponsiveUtils.getResponsiveIconSize(context);

    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: tooltip,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      child: SizedBox(
        width: iconSize,
        height: iconSize,
        child: child,
      ),
    );
  }
} 