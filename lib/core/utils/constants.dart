// lottie url
import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:tanjun_app/core/utils/task_strings.dart';

String lottieURL = 'assets/lottie/check.json';
// empty title or description textField warning
emptyWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: TaskStrings.oopsMessage,
    subMsg: TaskStrings.mustFillAllFieldsMessage,
    corner: 20,
    duration: 3000,
    padding: const EdgeInsets.all(20),
  );
}

// nothing entered when user clicks on add button
dynamic updateTaskWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: TaskStrings.oopsMessage,
    subMsg: TaskStrings.updateTaskMessage,
    corner: 20,
    duration: 4000,
    padding: const EdgeInsets.all(20),
  );
}

// no task warning dialog for deleting
dynamic nothingTaskWarning(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(context,
      message: TaskStrings.nothingTaskMessage,
      buttonText: "Yes", onTapDismiss: () {
    Navigator.pop(context);
  }, panaraDialogType: PanaraDialogType.warning);
}

// delete all tasks
dynamic deleteAllTasksWarning(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
    title: TaskStrings.confirmationMessage,
    message: TaskStrings.deleteAllTasks,
    confirmButtonText: "Yes",
    cancelButtonText: "No",
    onTapConfirm: () {
      Navigator.pop(context);
    },
    onTapCancel: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.error,
    barrierDismissible: false,
  );
}
