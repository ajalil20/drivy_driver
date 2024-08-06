import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart' as thumbnail;

class ImageController extends GetxController {
  Rx<File> imageProfile = File("").obs;
  RxList<File> mediaFiles = List<File>.empty().obs;
  RxList<File> tempMediaFiles = List<File>.empty().obs;
  Rx<File> imagePick = File("").obs;
  static ImageController get instance => Get.find();

  Future filesFromGallery({bool? onlyImage, onlyVideo, otherTypes}) async {
    // mediaFiles = List<File>.empty().obs;
    print("Enter in picked files");
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: onlyImage == true
            ? FileType.image
            : onlyVideo == true
                ? FileType.video
                : FileType.custom,
        allowedExtensions: onlyImage == true
            ? null
            : onlyVideo == true
                ? null
                : otherTypes == true
                    ? [
                        'pdf',
                        'jpg',
                        'jpeg',
                        'png',
                        // 'word',
                        // 'doc',
                        // 'docx',
                        // 'txt',
                      ]
                    : [
                        'jpg',
                        'jpeg',
                        'png',
                        'mp4',
                        'mov',
                        'heif',
                        'hevc',
                        'tiff',
                        'tif',
                        'gif',
                        'video',
                      ],
        allowMultiple: false);

    if (result != null) {
      List<File> files = [];
      tempMediaFiles.value = [];
      // mediaFiles.value = result.paths.map((path) => File(path!)).toList();
      files = result.paths.map((path) => File(path!)).toList();
      mediaFiles.value.addAll(files); // = List.from(files);

      // tempMediaFiles.value = result.paths.map((path) => File(path!)).toList();
      print("Picked Filesss : ");
      for (int i = 0; i < mediaFiles.value.length; i++) {
        if (mediaFiles.value[i].path.contains('mp4')) {
          tempMediaFiles.value
              .add(File(await getThumbnail(mediaFiles.value[i].path)));
          // mediaFiles.removeAt(i);
          mediaFiles.refresh();
        } else {
          tempMediaFiles.value.add(mediaFiles.value[i]);
        }
        imageProfile.value = File(mediaFiles.value[i].path);
        tempMediaFiles.refresh();
      }
      return tempMediaFiles;
    } else {
      print("Picked Not picked");
    }
  }

  getThumbnail(String path) async {
    print("thumnail ma aya");
    print(path);
    var fileName = await thumbnail.VideoThumbnail.thumbnailFile(
      video: path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: thumbnail.ImageFormat.PNG,
      quality: 100,
    );
    print("thumnail ma ghussa");
    print(fileName);
    print(fileName.runtimeType);
    return fileName;
  }

  Future<File> imgFromCamera() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 20);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      imageProfile.value = File(pickedFile.path);
      // homeController.media.value.add(file) ;
      // homeController.media.refresh();
      mediaFiles.add(file);
      tempMediaFiles.add(file);
      tempMediaFiles.refresh();
      return file;
    } else {
      return File("");
    }
  }

  Future imgFromGallery() async {
    mediaFiles = List<File>.empty().obs;
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 20);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      imageProfile.value = File(pickedFile.path);
      return file;
    } else {
      return File("");
    }
  }

  ///Pick FIles
  ///

  Future<List<File>> pickFilesOnly({
    required List<String> types,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: types, allowMultiple: true);

    if (result != null) {
      List<File> files = [];
      files = result.paths.map((path) => File(path!)).toList();
      return files;
    } else {
      return [];
    }
  }
}
