import 'package:CIVM/services/app_exceptions.dart';
import 'package:CIVM/utils/dialog_helper.dart';

class BaseController {
  void handleError(error) {
    if (error is BadRequestException) {
      var message = error.message;
      DialogHelper.showErrorDialog(description: message);
    } else if (error is FetchDataException) {
      var message = error.message;
      DialogHelper.showErrorDialog(description: message);
    } else if (error is ApiNotRespondingException) {
      var message = error.message;
      DialogHelper.showErrorDialog(description: message);
    }
  }
}
