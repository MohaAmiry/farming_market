import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../ExceptionHandler/MessageEmitter.dart';

part 'ImagePickerNotifier.g.dart';

@riverpod
class ImagePickerNotifier extends _$ImagePickerNotifier {
  @override
  List<XFile> build() {
    return [];
  }

  Future<List<String>> pickImages() async {
    AsyncValue<List<XFile>> result = await AsyncValue.guard(() async {
      return await ImagePicker().pickMultiImage();
    });
    if (result.hasError) {
      ref
          .read(messageEmitterProvider.notifier)
          .setFailed(message: Exception(result.error.toString()));
      return [];
    }
    state = result.requireValue;

    return result.requireValue.map((e) async => e.path).wait;
  }
}
