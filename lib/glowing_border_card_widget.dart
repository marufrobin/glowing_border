import 'package:flutter/material.dart';

/// A card widget with two glowing border orbs that start at opposite corners
/// (top-left and bottom-right) and travel around the entire border simultaneously.
class GlowingBorderCard extends StatefulWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? glowColor1; // Travels from bottom-right → clockwise
  final Color? glowColor2; // Travels from top-left → clockwise (opposite start)
  final Color? backgroundColor;
  final double borderWidth;
  final double glowSpread;
  final Duration animationDuration;
  final Duration? startDelay;
  final int? runCount;
  final Widget? child;

  const GlowingBorderCard({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 16,
    this.glowColor1,
    this.glowColor2,
    this.backgroundColor,
    this.borderWidth = 2,
    this.glowSpread = 8,
    this.animationDuration = const Duration(milliseconds: 2500),
    this.startDelay,
    this.runCount,
    this.child,
  });

  @override
  State<GlowingBorderCard> createState() => _GlowingBorderCardState();
}

class _GlowingBorderCardState extends State<GlowingBorderCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isVisible = true;
  bool _isStarted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _initAnimation();
  }

  Future<void> _initAnimation() async {
    if (widget.startDelay != null) {
      await Future.delayed(widget.startDelay!);
    }

    if (!mounted) return;

    setState(() {
      _isStarted = true;
    });

    if (widget.runCount != null) {
      _controller.repeat(count: widget.runCount);
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (mounted) {
            setState(() {
              _isVisible = false;
            });
          }
        }
      });
    } else {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedGlow1 = widget.glowColor1 ?? theme.colorScheme.primary;
    final resolvedGlow2 = widget.glowColor2 ?? theme.colorScheme.tertiary;
    final resolvedBg = widget.backgroundColor ?? theme.colorScheme.surface;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 0.0,
        end: (_isStarted && _isVisible) ? 1.0 : 0.0,
      ),
      duration: const Duration(milliseconds: 500),
      builder: (context, glowOpacity, child) {
        return AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: GlowingBorderPainter(
                progress: _animation.value,
                glowColor1: resolvedGlow1,
                glowColor2: resolvedGlow2,
                borderRadius: widget.borderRadius,
                borderWidth: widget.borderWidth,
                glowSpread: widget.glowSpread,
                glowOpacity: glowOpacity,
              ),
              child: child,
            );
          },
          child: child,
        );
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: resolvedBg,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: widget.child,
      ),
    );
  }
}

class GlowingBorderPainter extends CustomPainter {
  final double progress; // 0.0 → 1.0 (full loop)
  final Color glowColor1;
  final Color glowColor2;
  final double borderRadius;
  final double borderWidth;
  final double glowSpread;
  final double glowOpacity;

  GlowingBorderPainter({
    required this.progress,
    required this.glowColor1,
    required this.glowColor2,
    required this.borderRadius,
    required this.borderWidth,
    required this.glowSpread,
    required this.glowOpacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0 || size.height == 0) return;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics().first;
    final totalLen = metrics.length;

    // ── 1. Draw the dim base border ──────────────────────────────────────────
    final basePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.07)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    canvas.drawRRect(rrect, basePaint);

    // If glow is fully invisible, skip drawing orbs and trails
    if (glowOpacity <= 0) return;

    // ── 2. Draw each orb with its glow trail ─────────────────────────────────
    void drawOrb(double t, Color color) {
      final double normalizedT = t % 1.0;
      final double distance = normalizedT * totalLen;

      // Extract trail path (last ~15% of the perimeter)
      const double trailFraction = 0.15;
      final double trailLen = totalLen * trailFraction;

      final Path trailPath = Path();
      if (distance >= trailLen) {
        trailPath.addPath(
          metrics.extractPath(distance - trailLen, distance),
          Offset.zero,
        );
      } else {
        // Handle wrap around: part from end of path + part from start of path
        trailPath.addPath(
          metrics.extractPath(totalLen - (trailLen - distance), totalLen),
          Offset.zero,
        );
        trailPath.addPath(metrics.extractPath(0, distance), Offset.zero);
      }

      // ── Glow trail layers (Optimized) ──────────────────────────────────────
      // Outer soft glow
      final Paint glowPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = glowSpread * 2.5
        ..strokeCap = StrokeCap.round
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glowSpread * 1.2)
        ..color = color.withValues(alpha: 0.15 * glowOpacity);
      canvas.drawPath(trailPath, glowPaint);

      // Middle vibrant glow
      glowPaint
        ..strokeWidth = glowSpread * 1.2
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glowSpread * 0.5)
        ..color = color.withValues(alpha: 0.4 * glowOpacity);
      canvas.drawPath(trailPath, glowPaint);

      // Core leading line
      glowPaint
        ..strokeWidth = borderWidth * 1.5
        ..maskFilter = null
        ..color = color.withValues(alpha: glowOpacity);
      canvas.drawPath(trailPath, glowPaint);

      // ── Orb Head ───────────────────────────────────────────────────────────
      final tangent = metrics.getTangentForOffset(distance);
      if (tangent != null) {
        final pos = tangent.position;

        // Soft head glow
        final Paint headPaint = Paint()
          ..color = color.withValues(alpha: 0.6 * glowOpacity)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, glowSpread * 0.8);
        canvas.drawCircle(pos, glowSpread, headPaint);

        // White core
        headPaint
          ..color = Colors.white.withValues(alpha: glowOpacity)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 2);
        canvas.drawCircle(pos, borderWidth * 1.5, headPaint);

        // Pure white spike
        canvas.drawCircle(
          pos,
          borderWidth * 0.8,
          Paint()..color = Colors.white.withValues(alpha: glowOpacity),
        );
      }
    }

    // Orb 1: starts halfway (bottom-right)
    drawOrb(progress + 0.5, glowColor1);

    // Orb 2: starts at beginning (top-left)
    drawOrb(progress, glowColor2);
  }

  @override
  bool shouldRepaint(GlowingBorderPainter old) => old.progress != progress;
}
