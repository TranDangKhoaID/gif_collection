import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif_collection/common/share_colors.dart';

class DialogHelper {
  static bool _isOpened = false;
  static bool get isOpened => _isOpened == true;
  static const double _dialogWidth = 400;
  static openDialog() {
    _isOpened = true;
  }

  static closeDialog() {
    _isOpened = false;
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget dialog,
    bool barrierDismissible = true,
  }) async {
    try {
      T? value = await showGeneralDialog<T?>(
        context: context,
        transitionDuration: const Duration(milliseconds: 200),
        transitionBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          final Animation<Offset> slideAnimation = Tween<Offset>(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation);
          final Animation<double> opacityAnimation =
              Tween<double>(begin: 0, end: 1).animate(animation);

          return FractionalTranslation(
            translation: Offset(0, slideAnimation.value.dy),
            child: Opacity(
              opacity: opacityAnimation.value,
              child: child,
            ),
          );
        },
        barrierColor: Colors.black.withOpacity(0.5),
        barrierDismissible: true,
        barrierLabel: 'Dialog',
        pageBuilder: (BuildContext contextDialog, animation1, animation2) {
          return dialog;
        },
      );

      return value;
    } catch (e) {}
    return null;
  }

  static showWidgetDialog({
    required BuildContext context,
    required void Function() onPressConfirm,
    void Function()? onPressCancel,
    required Widget body,
    String? cancelText,
    String? confirmText,
  }) async {
    if (isOpened) return;
    openDialog();
    AwesomeDialog dialog = AwesomeDialog(
      width: _dialogWidth,
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,

      btnOkText: confirmText ?? 'confirm'.tr,
      btnCancelText: cancelText ?? 'close'.tr,
      btnOkColor: ShareColors.kPrimaryColor,
      btnCancelOnPress: () {
        onPressCancel?.call();
      },
      body: body,
      btnOkOnPress: () {
        onPressConfirm.call();
      },
      // btnOkColor: Theme.of(context).primaryColor,
      btnCancelColor: Colors.grey,
    );
    await dialog.show();
    closeDialog();
  }

  static showConfirmDialog({
    required BuildContext context,
    required void Function() onPressConfirm,
    void Function()? onPressCancel,
    required String message,
    String? title,
    String? cancelText,
    String? confirmText,
  }) async {
    if (isOpened) return;
    openDialog();
    AwesomeDialog dialog = AwesomeDialog(
      width: _dialogWidth,
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      title: title ?? "Thông báo",
      titleTextStyle: Theme.of(context).textTheme.headlineMedium,
      descTextStyle: Theme.of(context).textTheme.bodyMedium,
      desc: message,
      btnOkText: confirmText ?? 'confirm'.tr,
      btnCancelText: cancelText ?? 'close'.tr,
      btnOkColor: ShareColors.kPrimaryColor,
      btnCancelOnPress: () {
        onPressCancel?.call();
      },

      btnOkOnPress: () {
        onPressConfirm.call();
      },
      // btnOkColor: Theme.of(context).primaryColor,
      btnCancelColor: Colors.grey,
    );
    await dialog.show();
    closeDialog();
  }

  static void showWidgetOkDialog({
    required Widget body,
    required BuildContext context,
    String? title,
    String? closeBtnText,
    VoidCallback? onConfirmPress,
  }) async {
    if (isOpened) return;

    openDialog();
    AwesomeDialog dialog = AwesomeDialog(
      width: _dialogWidth,
      context: context,
      titleTextStyle: Theme.of(context).textTheme.headlineMedium,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      title: title ?? "Thông báo",
      btnOkText: closeBtnText ?? "Đồng ý",
      btnOkOnPress: () {
        onConfirmPress?.call();
      },
      body: body,
    );
    await dialog.show();
    closeDialog();
  }

  static void showMessageDialog(
    String message, {
    required BuildContext context,
    String? title,
    String? closeBtnText,
    VoidCallback? onConfirmPress,
  }) async {
    if (isOpened) return;

    openDialog();
    AwesomeDialog dialog = AwesomeDialog(
      width: _dialogWidth,
      context: context,
      titleTextStyle: Theme.of(context).textTheme.headlineMedium,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      title: title ?? "Thông báo",
      desc: message,
      btnOkText: closeBtnText ?? "Đồng ý",
      btnOkOnPress: () {
        onConfirmPress?.call();
      },
    );
    await dialog.show();
    closeDialog();
  }

  static void showErrorDialog(
    String message, {
    required BuildContext context,
    String? title,
    String? closeBtnText,
  }) async {
    if (isOpened) return;
    openDialog();
    AwesomeDialog dialog = AwesomeDialog(
      width: _dialogWidth,
      titleTextStyle: Theme.of(context).textTheme.headlineMedium,
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: title ?? "Thông báo",
      desc: message,
      btnOkText: closeBtnText ?? "Đồng ý",
      btnOkColor: Colors.red,
      btnOkOnPress: () {},
    );
    await dialog.show();
    closeDialog();
  }

  static Future<void> showSuccessDialog(
    String message, {
    required BuildContext context,
    String? title,
    String? closeBtnText,
    VoidCallback? onConfirmPress,
  }) async {
    if (isOpened) return;
    openDialog();
    AwesomeDialog dialog = AwesomeDialog(
      width: _dialogWidth,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      title: title ?? "Thông báo",
      desc: message,
      btnOkText: closeBtnText ?? "Đồng ý",
      btnOkOnPress: () {
        onConfirmPress?.call();
      },
    );
    await dialog.show();
    closeDialog();
  }
}
