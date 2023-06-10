import 'package:fleather/fleather.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_controller.dart';

class FleatherRichTextController extends NotedRichTextController {
  FleatherController controller = FleatherController();

  @override
  void dispose() {
    controller.dispose();
  }
}
