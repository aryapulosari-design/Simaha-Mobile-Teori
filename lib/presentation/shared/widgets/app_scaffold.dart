import 'package:flutter/material.dart';

/// Standard Material 3 AppScaffold for SIMAHA screens.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.title,
    this.titleWidget,
    required this.body,
    this.actions,
    this.leading,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.padding = const EdgeInsets.all(16),
    this.onRefresh,
    this.centerTitle = false,
  });

  final String? title;
  final Widget? titleWidget;
  final Widget body;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final EdgeInsetsGeometry padding;
  final Future<void> Function()? onRefresh;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: padding,
      child: body,
    );

    if (onRefresh != null) {
      content = RefreshIndicator(
        onRefresh: onRefresh!,
        child: content,
      );
    }

    return Scaffold(
      appBar: (title != null || titleWidget != null || actions != null || leading != null)
          ? AppBar(
              title: titleWidget ?? (title != null ? Text(title!) : null),
              centerTitle: centerTitle,
              leading: leading,
              actions: actions,
            )
          : null,
      body: SafeArea(child: content),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
