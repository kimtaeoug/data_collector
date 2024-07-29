import 'dart:io';

import 'package:data_collector/utils/logger_util.dart';
import 'package:external_path/external_path.dart';

///
/// 미디어 저장 디렉터리 이름, 타입
///
class MediaDetectorUtil {
  static final MediaDetectorUtil _instance = MediaDetectorUtil._();

  MediaDetectorUtil._();

  factory MediaDetectorUtil() => _instance;

  void scanMediaList() async {
    List<String> musicList = detector(Directory(ExternalPath.DIRECTORY_MUSIC));
    List<String> pictureList =
        detector(Directory(ExternalPath.DIRECTORY_PICTURES));
    List<String> movieList = detector(Directory(ExternalPath.DIRECTORY_MOVIES));
    List<String> downloadList =
        detector(Directory(ExternalPath.DIRECTORY_MOVIES));
    List<String> documentList =
        detector(Directory(ExternalPath.DIRECTORY_DOCUMENTS));
    List<String> mediaList =
        (musicList + pictureList + movieList + documentList + downloadList)
            .toSet()
            .toList();
    Log.i('mediaList : $mediaList');
  }

  List<String> detector(Directory directory) {
    List<String> result = [];
    bool existing = directory.existsSync();
    if (existing) {
      for (FileSystemEntity element in directory.listSync(recursive: true)) {
        result.add(element.path);
      }
      return result;
    } else {
      Log.e('Error : ${directory.path} is not existing');
      return [];
    }
  }
}
