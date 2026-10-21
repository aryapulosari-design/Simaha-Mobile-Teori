import 'package:flutter/material.dart';

class BentoCard extends StatelessWidget {
  const BentoCard({
    super.key,
    required this.child,
    this.accent,
    this.padding = 20,
  });
  final Widget child;
  final Color? accent;
  final double padding;
  @override
  Widget build(BuildContext context) => Card(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: accent == null
            ? null
            : Border(top: BorderSide(color: accent!, width: 4)),
      ),
      padding: EdgeInsets.all(padding),
      child: child,
    ),
  );
}

class MetricTile extends StatelessWidget {
  const MetricTile({
    super.key,
    required this.label,
    required this.value,
    required this.note,
    required this.icon,
    this.progress,
    this.indigo = false,
  });
  final String label, value, note;
  final IconData icon;
  final double? progress;
  final bool indigo;
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final accent = indigo ? t.colorScheme.tertiary : t.colorScheme.primary;
    return BentoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(label, style: t.textTheme.bodyMedium)),
              const SizedBox(width: 8),
              Icon(icon, size: 20, color: accent),
            ],
          ),
          const SizedBox(height: 18),
          Text(value, style: t.textTheme.headlineLarge?.copyWith(fontSize: 30)),
          const SizedBox(height: 8),
          Text(note, style: t.textTheme.bodySmall),
          const SizedBox(height: 16),
          if (progress != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress!.clamp(0.0, 1.0),
                minHeight: 4,
                color: accent,
                backgroundColor: t.colorScheme.surfaceContainerLow,
              ),
            ),
        ],
      ),
    );
  }
}

class BentoGrid extends StatelessWidget {
  const BentoGrid({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      final scale = MediaQuery.textScalerOf(context).scale(1);
      final columns = box.maxWidth >= 900 && scale < 1.4
          ? 4
          : box.maxWidth >= 340 && scale < 1.4
          ? 2
          : 1;
      return Column(
        children: [
          for (var start = 0; start < children.length; start += columns)
            Padding(
              padding: EdgeInsets.only(
                bottom: start + columns < children.length ? 12 : 0,
              ),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var column = 0; column < columns; column++) ...[
                      if (column > 0) const SizedBox(width: 12),
                      Expanded(
                        child: start + column < children.length
                            ? children[start + column]
                            : const SizedBox(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      );
    },
  );
}

class ContextTag extends StatelessWidget {
  const ContextTag(this.label, {super.key, this.icon});
  final String label;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: c.surfaceContainerLow,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: c.primary),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'JetBrainsMono',
                fontSize: 10,
                height: 1.5,
                color: c.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WorkspacePage extends StatelessWidget {
  const WorkspacePage({
    super.key,
    required this.title,
    required this.children,
    this.actions = const [],
  });
  final String title;
  final List<Widget> children, actions;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title), actions: actions),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
        ),
      ],
    ),
  );
}
