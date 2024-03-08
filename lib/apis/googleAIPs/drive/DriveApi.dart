import 'dart:io';
import 'package:csi_app/utils/config/google_api_cred.dart';
import 'package:file_picker/file_picker.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';
import 'package:path/path.dart' as path;

class DriveAPI {
  static final _scopes = [drive.DriveApi.driveFileScope]; // Scopes required for file upload

  static Future<Map<String, String>?> uploadFile() async {
    // Load credentials from your credential file
    final _credentials = ServiceAccountCredentials.fromJson(credentials);

    // Authenticate with Google Drive API
    final httpClient = await clientViaServiceAccount(_credentials, _scopes);
    final driveApi = drive.DriveApi(httpClient);

    // Pick a file from device
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowedExtensions: allowedExtensions);
    if (result != null) {
      File file = File(result.files.single.path!); // Get the picked file
      // File metadata
      final drive.File fileToUpload = drive.File();
      fileToUpload.name = path.basename(file.path);
      fileToUpload.parents = parentFolderIDs;

      // Upload file
      final response = driveApi.files.create(fileToUpload, uploadMedia: drive.Media(file.openRead(), file.lengthSync()));


      response.then((value) {
        final downloadUrl = "https://drive.usercontent.google.com/u/0/uc?id=${value.id}&export=download";
        print('#File uploaded! File download url: ${downloadUrl}');
        return {"File uploaded": downloadUrl};

      }).onError((error, stackTrace) {
        print("#error-file-upload: $error \n $stackTrace");

        return {"Error": "Something went wrong retry again later"};
      });

    } else {
      // User canceled the picker
      print('#Error: User canceled the file picking');
      return {"Error": "You cancelled file selection"};
    }
    return null;
  }
}
