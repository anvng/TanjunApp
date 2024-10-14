import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:tanjun_app/core/utils/task_strings.dart';

String lottieURL = 'assets/lottie/check.json';

// Generic function to show FToast messages
void showToast(BuildContext context, String message, String subMessage,
    {int duration = 3000}) {
  FToast.toast(
    context,
    msg: message,
    subMsg: subMessage,
    corner: 20,
    duration: duration,
    padding: const EdgeInsets.all(20),
  );
}

// Warning for empty title or description textField
void showEmptyWarning(BuildContext context) {
  showToast(
    context,
    TaskStrings.oopsMessage,
    TaskStrings.mustFillAllFieldsMessage,
  );
}

// Warning when nothing is entered upon clicking the add button
void showUpdateTaskWarning(BuildContext context) {
  showToast(
    context,
    TaskStrings.oopsMessage,
    TaskStrings.updateTaskMessage,
    duration: 4000,
  );
}

// Warning dialog for deleting tasks when none exist
void showNothingTaskWarning(BuildContext context) {
  PanaraInfoDialog.showAnimatedGrow(
    context,
    message: TaskStrings.nothingTaskMessage,
    buttonText: "OK",
    onTapDismiss: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.warning,
  );
}

// Confirmation dialog for deleting all tasks
Future<bool?> showDeleteAllTasksWarning(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
    title: TaskStrings.confirmationMessage,
    message: TaskStrings.deleteAllTasks,
    confirmButtonText: "Yes",
    cancelButtonText: "No",
    onTapConfirm: () {
      Navigator.pop(context, true);
    },
    onTapCancel: () {
      Navigator.pop(context, false);
    },
    panaraDialogType: PanaraDialogType.error,
    barrierDismissible: false,
  );
}
