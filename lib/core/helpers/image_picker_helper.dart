import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../errors/failures.dart';

@injectable
class ImagePickerHelper {
  const ImagePickerHelper(this.imagePicker);

  final ImagePicker imagePicker;

  Future<Either<Failure, File>> chooseOrTakePhoto([
    ImageSource source = ImageSource.camera
  ]) async {
    final XFile? sample = await imagePicker.pickImage(
      source: source,
      imageQuality: 60,
      maxWidth: 1080,
      maxHeight: 720,
    );

    if (sample != null) {
      return Right(File(sample.path));
    } else {
      return const Left(ImagePickerFailure("No se seleccionó ninguna foto."));
    }
  }

  Future<void> deletePhoto({required File photo}) async {
    if (await photo.exists()) {
      await photo.delete();
    }
  }
}