import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:csi_app/utils/config/google_api_cred.dart';
import 'package:file_picker/file_picker.dart';
import 'package:googleapis/drive/v3.dart' as drive;
// import 'package:googleapis/drive/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class DriveAPI {
  static final _scopes = [drive.DriveApi.driveFileScope]; // Scopes required for file upload

  static Future<Map<String, String>?> uploadFile() async {
    // Load credentials from your credential file
    final _credentials = ServiceAccountCredentials.fromJson(credentials);

    // Authenticate with Google Drive API
    final httpClient = await clientViaServiceAccount(_credentials, _scopes);
    final driveApi = drive.DriveApi(httpClient);

    // Pick a file from device
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: allowedAttachmentExtensions);
    if (result != null) {
      try {
        File file = File(result.files.single.path!); // Get the picked file

        // File metadata
        final drive.File fileToUpload = drive.File();
        fileToUpload.name = path.basename(file.path);
        fileToUpload.parents = attachmentParentFolderIDs;

        // Upload file
        final response = await driveApi.files.create(fileToUpload, uploadMedia: drive.Media(file.openRead(), file.lengthSync()));

        final downloadUrl = "https://drive.usercontent.google.com/u/0/uc?id=${response.id}&export=download";
        print('#File uploaded! File download url: ${downloadUrl}');
        return {"File uploaded": downloadUrl};
      } catch (error, stackTrace) {
        print("#error-file-upload: $error \n $stackTrace");
        return {"Error": "Something went wrong retry again later"};
      }
    } else {
      // User canceled the picker
      print('#Error: User canceled the file picking');
      return {"Error": "You cancelled file selection"};
    }
  }

  static Future<Map<String, String>> uploadImage() async {
    // Load credentials from your credential file
    final _credentials = ServiceAccountCredentials.fromJson(credentials);

    // Authenticate with Google Drive API
    final httpClient = await clientViaServiceAccount(_credentials, _scopes);
    final driveApi = drive.DriveApi(httpClient);

    // Pick a file from device
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: allowedImageExtensions);
    if (result != null) {
      try {
        File file = File(result.files.single.path!); // Get the picked file

        // File metadata
        final drive.File fileToUpload = drive.File();
        fileToUpload.name = path.basename(file.path);
        fileToUpload.parents = profileImageParentFolderIDs;

        // Upload file
        final response = await driveApi.files.create(fileToUpload, uploadMedia: drive.Media(file.openRead(), file.lengthSync()));

        final downloadUrl = "https://drive.usercontent.google.com/u/0/uc?id=${response.id}&export=download";
        print('#Image uploaded! Image download url: ${downloadUrl}');
        return {"Image uploaded": downloadUrl};
      } catch (error, stackTrace) {
        print("#error-image-upload: $error \n $stackTrace");
        return {"Error": "Something went wrong retry again later"};
      }
    } else {
      // User canceled the picker
      print('#Error: User canceled the Image picking');
      return {"Error": "You cancelled Image selection"};
    }
  }

  static Future<Uint8List> fetchImage(String? url) async {
    if (url == null || url == "") throw Exception("url null");

    final _credentials = ServiceAccountCredentials.fromJson(credentials);

    // Authenticate with Google Drive API
    final httpClient = await clientViaServiceAccount(_credentials, _scopes);
    final driveApi = drive.DriveApi(httpClient);


    try {

      drive.Media file = await driveApi.files.get(extractIdFromUrl(url), downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;

      final List<int> chunks = [];
      await for (var chunk in file.stream) {
        chunks.addAll(chunk);
      }
      final Uint8List imageData = Uint8List.fromList(chunks);
      return imageData;

    } catch (e) {
      log('Error retrieving file: $e');
      throw Exception(e);

    } finally {
      httpClient.close();
    }
  }



  static Future<bool> deleteFileFromDrive(String? url) async {
    if (url == null) return false;

    final _credentials = ServiceAccountCredentials.fromJson(credentials);

    // Authenticate using service account credentials
    final httpClient = await clientViaServiceAccount(_credentials, _scopes);

    // Instantiate the Drive API
    final driveApi = drive.DriveApi(httpClient);

    try {
      // Delete the file
      await driveApi.files.delete(extractIdFromUrl(url));

      print('File deleted successfully.');
      return true;
    } catch (e) {
      print('Error deleting file: $e');
      return false;
    } finally {
      // Close the HTTP client to release resources
      httpClient.close();
    }
  }

  static String extractIdFromUrl(String url) {
    RegExp regExp = RegExp(r'id=([^&]+)');
    Match? match = regExp.firstMatch(url);
    if (match != null) {
      return match.group(1)!;
    } else {
      return ''; // Return empty string if ID not found
    }
  }

}
