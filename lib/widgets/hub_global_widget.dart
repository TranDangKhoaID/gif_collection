import 'package:gif_collection/common/share_colors.dart';
import 'package:gif_collection/common/share_obs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class HudGlobalWidget extends StatefulWidget {
  /// MARK: - Initials;
  final Widget child;

  const HudGlobalWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<HudGlobalWidget> createState() => _HudGlobalWidgetState();
}

class _HudGlobalWidgetState extends State<HudGlobalWidget> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          widget.child,

          /// Ignore Pointer
          _buildIgnorePointer(),

          /// Hud Widget
          _buildHudViewWidget(),
        ],
      ),
    );
  }

  Widget _buildIgnorePointer() {
    if (!mounted) {
      return const SizedBox.shrink();
    }
    return Obx(() {
      final isEnable = ShareObs.isEnableGesture.value;
      return IgnorePointer(
        ignoring: isEnable,
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    });
  }

  Widget _buildHudViewWidget() {
    if (!mounted) {
      return const SizedBox.shrink();
    }
    return Obx(
      () {
        return ShareObs.isShowHUDGlobal.value
            ? Positioned.fill(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.2),
                  alignment: Alignment.center,
                  child: Container(
                    width: Get.width / 3,
                    height: Get.width / 3,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                    ),
                    alignment: Alignment.center,
                    child: SpinKitWave(
                      size: 25,
                      color: ShareColors.kPrimaryColor,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}

class HudGlobalManager {
  /// Show
  static void showHud() {
    ShareObs.isShowHUDGlobal.value = true;
  }

  /// Hide
  static void dismissHud() {
    ShareObs.isShowHUDGlobal.value = false;
  }

  /// Enable gesture
  static void enableGesture() {
    ShareObs.isEnableGesture.value = true;
  }

  /// Disable gesture
  static void disableGesture() {
    ShareObs.isEnableGesture.value = false;
  }
}
