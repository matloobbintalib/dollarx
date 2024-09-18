part of 'image_picker_cubit.dart';

class ImagePickerState {
  final File? file;
  final bool hasImage;
  final File? backImageFile;
  final File? frontImageFile;

  const ImagePickerState({
    required this.file,
    required this.hasImage,
    required this.backImageFile,
    required this.frontImageFile,
  });

  factory ImagePickerState.initial() {
    return ImagePickerState(
      file: null,
      hasImage: false,
      backImageFile: null,
      frontImageFile: null,
    );
  }

  ImagePickerState copyWith({
    File? file,
    bool? hasImage,
    File? backImageFile,
    File? frontImageFile
  }) {
    return ImagePickerState(
      file: file?? this.file,
      hasImage: hasImage?? this.hasImage,
      backImageFile: backImageFile?? this.backImageFile,
      frontImageFile: frontImageFile?? this.frontImageFile,
    );
  }
}
