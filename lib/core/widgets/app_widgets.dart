// lib/core/widgets/app_widgets.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../constants/app_constants.dart';

// ─── AppButton ───────────────────────────────────────────────────────────────
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isOutlined;
  final bool isLoading;
  final IconData? icon;
  final Color? color;
  final double? width;

  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isOutlined = false,
    this.isLoading = false,
    this.icon,
    this.color,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final btnColor = color ?? AppColors.pink;
    return SizedBox(
      width: width ?? double.infinity,
      height: 52,
      child: isOutlined
          ? OutlinedButton(
              onPressed: isLoading ? null : onTap,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: btnColor, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.radiusMD)),
              ),
              child: _buildChild(btnColor),
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: btnColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.radiusMD)),
                elevation: 0,
              ),
              child: _buildChild(Colors.white),
            ),
    );
  }

  Widget _buildChild(Color textColor) {
    if (isLoading) {
      return SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: textColor));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[Icon(icon, color: textColor, size: 20), const SizedBox(width: 8)],
        Text(label, style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

// ─── GradientButton ──────────────────────────────────────────────────────────
class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final LinearGradient? gradient;
  final IconData? icon;
  final double? width;

  const GradientButton({
    super.key,
    required this.label,
    required this.onTap,
    this.gradient,
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: 52,
        decoration: BoxDecoration(
          gradient: gradient ?? AppColors.gradient1,
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          boxShadow: [
            BoxShadow(
              color: AppColors.pink.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[Icon(icon, color: Colors.white, size: 20), const SizedBox(width: 8)],
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

// ─── AppCard ─────────────────────────────────────────────────────────────────
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? color;
  final VoidCallback? onTap;
  final double? borderRadius;
  final bool hasShadow;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.onTap,
    this.borderRadius,
    this.hasShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = color ?? (isDark ? AppColors.cardDark : AppColors.surface);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(AppConstants.paddingMD),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(borderRadius ?? AppConstants.radiusLG),
          boxShadow: hasShadow
              ? [
                  BoxShadow(
                    color: AppColors.pink.withOpacity(isDark ? 0.1 : 0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: child,
      ),
    );
  }
}

// ─── ChildCard ───────────────────────────────────────────────────────────────
class ChildCard extends StatelessWidget {
  final String name;
  final String age;
  final String emoji;
  final Color color;
  final VoidCallback onTap;
  final String? lastUpdated;

  const ChildCard({
    super.key,
    required this.name,
    required this.age,
    required this.emoji,
    required this.color,
    required this.onTap,
    this.lastUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.4), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Center(child: Text(emoji, style: const TextStyle(fontSize: 28))),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 2),
                  Text(age, style: Theme.of(context).textTheme.bodySmall),
                  if (lastUpdated != null) ...[
                    const SizedBox(height: 4),
                    Text('Updated $lastUpdated', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary)),
                  ],
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle),
              child: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: color.withOpacity(0.8)),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── EmptyStateWidget ────────────────────────────────────────────────────────
class EmptyStateWidget extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final String? buttonLabel;
  final VoidCallback? onButtonTap;

  const EmptyStateWidget({
    super.key,
    required this.emoji,
    required this.title,
    required this.subtitle,
    this.buttonLabel,
    this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 72)),
            const SizedBox(height: 20),
            Text(title, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
            const SizedBox(height: 10),
            Text(subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary), textAlign: TextAlign.center),
            if (buttonLabel != null && onButtonTap != null) ...[
              const SizedBox(height: 28),
              GradientButton(label: buttonLabel!, onTap: onButtonTap!, width: 200),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── SectionHeader ───────────────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        if (actionLabel != null)
          GestureDetector(
            onTap: onAction,
            child: Text(
              actionLabel!,
              style: TextStyle(color: AppColors.pink, fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
      ],
    );
  }
}

// ─── StatChip ────────────────────────────────────────────────────────────────
class StatChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const StatChip({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: color)),
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
