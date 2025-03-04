import 'dart:convert';
import 'package:astrologeradmin/constance/apiConnectorConstants.dart';
import 'package:astrologeradmin/services/api_path.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:http_parser/http_parser.dart';

class HttpServices {


  // Utility function to convert model to Map if it's not already a Map
  Map<String, dynamic> _toMap(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    } else  {
      return data.toJson(); // Assuming `ModelRequest` has a `toJson()` method
    }
  }

  // GET Request
   Future<dynamic> get(String endpoint) async {
     debugPrint("url....${ApiPath.baseUrl}$endpoint");
    try {
      var headers = {
        "Accept": "application/json",
       // "X-CLIENT": ApiConnectorConstants.apiKey
      };

      // if (language.isNotEmpty) {
      //   headers.addAll({"Accept-Language": language});
      // }

      if (ApiConnectorConstants.accessToken.isNotEmpty) {
        headers.addAll({"Authorization": "Bearer ${ApiConnectorConstants.accessToken}"});
      }

      var response =
      await http.get(Uri.parse('${ApiPath.baseUrl}$endpoint'), headers: headers);
      debugPrint("test${response.body}");
     // load ? AllDialogs.progressLoadingDialog(context, false) : null;
      if (response.statusCode == 200) {

        return json.decode(response.body);
      } else{
      //  Utility.userNotExit(context,jsonResponse['message'].toString());
      }
    } on SocketException catch (e) {
      throw Exception(e);
    }
    return;
  }

  // POST Request (Handles both Map and ModelRequest)
  Future<Map<String, dynamic>> post(String endpoint, dynamic data) async {
    final requestData = _toMap(data); // Convert data to Map if it's a model

    final response = await http.post(
      Uri.parse('${ApiPath.baseUrl}$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(requestData),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }

  // DELETE Request
  Future<void> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('${ApiPath.baseUrl}$endpoint'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete data');
    }
  }

  // Multipart POST Request (for file uploads, handles both Map and ModelRequest)
  Future<Map<String, dynamic>> postMultipart(
      String endpoint, dynamic data, File file, String fileKey) async {
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}$endpoint'));

    // Convert data to Map if it's a model
    var requestData = _toMap(data);

    // Adding data to request
    requestData.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    // Adding file to request
    var fileStream = http.MultipartFile(
      fileKey,
      file.readAsBytes().asStream(),
      file.lengthSync(),
      filename: file.uri.pathSegments.last,
      contentType: MediaType('image', 'jpeg'), // Adjust content type based on file
    );
    request.files.add(fileStream);

    // Sending request
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return json.decode(responseBody);
    } else {
      throw Exception('Failed to upload file');
    }
  }
}
