import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../error/failure.dart';

enum DialogType { success, failure }

mixin AlertMixin {
  showSuccessDialog({required String successMessage, required Function buttonAction}) {
    const dialogType = DialogType.success;
    _buildDialog("congrats".tr, successMessage, "ok".tr, () {
      Get.back();
      buttonAction();
    }, dialogType);
  }

  showFailureDialog({required Failure failure, required Function tryAgain}) {
    const dialogType = DialogType.failure;
    if (failure is InternetFailure) {
      _buildDialog("Network Issue", "Please check your internet connection", "Try Again", () {
        Get.back();
        tryAgain();
      }, dialogType);
    } else if (failure is ServerFailure) {
      _buildDialog("Server Error", "We're facing an issue in our server and we're working on it.".tr, "ok".tr,
          () => Get.back(), dialogType);
    } else if (failure is BusinessFailure) {
      _buildDialog("Oops", failure.failureMessage, "ok".tr, () => Get.back(), dialogType);
    }
  }

  _buildDialog(String title, String subtitle, String buttonText, Function onButtonPressed, DialogType dialogType) {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 300,
        padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16, top: 24),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            dialogType == DialogType.success
                ? const Icon(Icons.check_circle, color: Colors.green, size: 48)
                : const Icon(Icons.error, color: Colors.red, size: 48),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 24),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(child: Text(buttonText), onPressed: () => onButtonPressed()))
          ],
        ),
      ),
    ));
  }
}
