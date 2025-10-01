import 'package:flutter/material.dart';
import 'package:mobile1/theme/app_colors.dart';

enum SnackbarType { info, success, warning, danger }

class AnimatedSnackbar {
  static void show(
    BuildContext context,
    String message, {
    SnackbarType type = SnackbarType.info,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    final controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: Navigator.of(context).overlay!,
    );

    final animation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    Color bgColor;
    IconData icon;
    switch (type) {
      case SnackbarType.success:
        bgColor = AppColors.success;
        icon = Icons.check_circle_rounded;
        break;
      case SnackbarType.warning:
        bgColor = AppColors.warning;
        icon = Icons.warning_rounded;
        break;
      case SnackbarType.danger:
        bgColor = AppColors.danger;
        icon = Icons.dangerous_rounded;
        break;
      case SnackbarType.info:
      default:
        bgColor = AppColors.info;
        icon = Icons.info_rounded;
    }

    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: 20,
        right: 20,
        child: SlideTransition(
          position: animation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  // Icon(icon, color: Colors.white),
                  // const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      message,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                    onPressed: () async {
                      await controller.reverse();
                      entry.remove();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    controller.forward();

    Future.delayed(const Duration(seconds: 3), () async {
      await controller.reverse();
      entry.remove();
    });
  }
}
