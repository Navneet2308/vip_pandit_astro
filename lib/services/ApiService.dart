import 'dart:convert';
import 'dart:io';
import 'package:astrologeradmin/services/api_path.dart';
import 'package:astrologeradmin/services/user_prefences.dart';
import 'package:http/http.dart' as http;

class ApiService {


  Future<Map<String, dynamic>> get(String endpoint, Map<String, String> queryParams) async {
    final url = Uri.parse(""+ApiPath.baseUrl+""+endpoint).replace(queryParameters: queryParams);

    // Log the URL and query parameters
    print('Request URL: ${url.toString()}');
    print('Query Parameters: $queryParams');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      // Log the response
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      // if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } catch (e) {
        throw Exception('Failed to parse JSON: $e');
      }
      // } else {
      //   throw Exception('HTTP ${response.statusCode}: ${response.body}');
      // }
    } catch (e) {
      // Log the error
      print('Error occurred: $e');
      throw Exception('Network error: $e');
    }}


  Future<Map<String, dynamic>> getAuth(String endpoint, Map<String, String> queryParams) async {
    final url = Uri.parse(""+ApiPath.baseUrl+""+endpoint).replace(queryParameters: queryParams);

   String token = await PreferencesServices.getPreferencesData(PreferencesServices.apiToken);
    // Log the URL and query parameters
    print("Auth : ${token}");
    print('Request URL: ${url.toString()}');
    print('Query Parameters: $queryParams');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Add Authorization header
        },
      );

      // Log the response
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      // if (response.statusCode == 200) {
        try {
          return jsonDecode(response.body) as Map<String, dynamic>;
        } catch (e) {
          throw Exception('Failed to parse JSON: $e');
        }
      // } else {
      //   throw Exception('HTTP ${response.statusCode}: ${response.body}');
      // }
    } catch (e) {
      // Log the error
      print('Error occurred: $e');
      throw Exception('Network error: $e');
    }}

  Future<Map<String, dynamic>> update_profile(
      String endpoint,
      Map<String, dynamic> body,
      File? profile_image,
      ) async {
    final url = Uri.parse("${ApiPath.baseUrl}$endpoint");

    // Log the request URL and body
    print('Request URL: ${url.toString()}');
    print('Request Body: $body');

    // Get the token from preferences
    String token = await PreferencesServices.getPreferencesData(PreferencesServices.apiToken);

    try {
      // Create a multipart request
      var request = http.MultipartRequest('POST', url);

      // Add the Authorization token to headers
      request.headers['Authorization'] = 'Bearer $token';

      // Add other fields to the request
      body.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Attach profile image if provided
      if (profile_image != null) {
        var imageBytes = await profile_image.readAsBytes();
        var imageName = profile_image.uri.pathSegments.last;
        request.files.add(http.MultipartFile.fromBytes(
          'profile_photo', // Field name expected by the server
          imageBytes,
          filename: imageName,
        ));
      }

      // Send the request
      final response = await request.send();

      // Log the response details
      final responseBody = await response.stream.bytesToString();
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: $responseBody');

      if (response.statusCode == 200) {
        try {
          return jsonDecode(responseBody);
        } catch (e) {
          throw Exception('Failed to parse JSON: $e');
        }
      } else {
        throw Exception('HTTP ${response.statusCode}: $responseBody');
      }
    } catch (e) {
      // Log the error
      print('Error occurred: $e');
      throw Exception('Network error: $e');
    }
  }

  Future<Map<String, dynamic>> post_auth(
      String endpoint,
      Map<String, dynamic> body) async {
    final url = Uri.parse("${ApiPath.baseUrl}$endpoint");

    // Log the request URL and body
    print('Request URL: ${url.toString()}');
    print('Request Body: $body');

    // Get the token from preferences
    String token = await PreferencesServices.getPreferencesData(PreferencesServices.apiToken);

    try {
      // Create a multipart request
      var request = http.MultipartRequest('POST', url);

      // Add the Authorization token to headers
      request.headers['Authorization'] = 'Bearer $token';

      // Add other fields to the request
      body.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Send the request
      final response = await request.send();

      // Log the response details
      final responseBody = await response.stream.bytesToString();
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: $responseBody');

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          return jsonDecode(responseBody);
        } catch (e) {
          throw Exception('Failed to parse JSON: $e');
        }
      } else {
        throw Exception('HTTP ${response.statusCode}: $responseBody');
      }
    } catch (e) {
      // Log the error
      print('Error occurred: $e');
      throw Exception('Network error: $e');
    }
  }



  Future<Map<String, dynamic>> register_post(
      String endpoint,
      Map<String, dynamic> body,
      File? profile_image,
      File? adhar_front,
      File? adhar_back) async {
    final url = Uri.parse(""+ApiPath.baseUrl+'$endpoint');

    // Log the request URL and body
    print('Request URL: ${url.toString()}');
    print('Request Body: $body');

    try {
      // Create a multipart request
      var request = http.MultipartRequest('POST', url);

      // Add other fields to the request
      body.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Attach profile image if provided
      if (profile_image != null) {
        var imageBytes = await profile_image.readAsBytes();
        var imageName = profile_image.uri.pathSegments.last;
        request.files.add(http.MultipartFile.fromBytes(
          'profile_photo', // Field name expected by the server
          imageBytes,
          filename: imageName,
        ));
      }

      // Attach Aadhar front image if provided
      if (adhar_front != null) {
        var adharFrontBytes = await adhar_front.readAsBytes();
        var adharFrontName = adhar_front.uri.pathSegments.last;
        request.files.add(http.MultipartFile.fromBytes(
          'adhar_photo_front', // Field name expected by the server
          adharFrontBytes,
          filename: adharFrontName,
        ));
      }

      // Attach Aadhar back image if provided
      if (adhar_back != null) {
        var adharBackBytes = await adhar_back.readAsBytes();
        var adharBackName = adhar_back.uri.pathSegments.last;
        request.files.add(http.MultipartFile.fromBytes(
          'adhar_photo_back', // Field name expected by the server
          adharBackBytes,
          filename: adharBackName,
        ));
      }

      // Send the request
      final response = await request.send();

      // Log the response details
      final responseBody = await response.stream.bytesToString();
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: $responseBody');

      if (response.statusCode == 201) {
        try {
          return jsonDecode(responseBody);
        } catch (e) {
          throw Exception('Failed to parse JSON: $e');
        }
      }
      if (response.statusCode == 422) {
        try {
          return jsonDecode(responseBody);
        } catch (e) {
          throw Exception('Failed to parse JSON: $e');
        }
      }

      else {
        throw Exception('HTTP ${response.statusCode}: $responseBody');
      }
    } catch (e) {
      // Log the error
      print('Error occurred: $e');
      throw Exception('Network error: $e');
    }
  }


  Future<Map<String, dynamic>> post(
      String endpoint,
      Map<String, dynamic> body,
      ) async {
    final url = Uri.parse(""+ApiPath.baseUrl+'$endpoint');

    // Log the request URL and body
    print('Request URL: ${url.toString()}');
    print('Request Body: $body');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      // Log the response details
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');


        try {
          return jsonDecode(response.body);
        } catch (e) {
          throw Exception('Failed to parse JSON: $e');
        }

    } catch (e) {
      // Log the error
      print('Error occurred: $e');
      throw Exception('Network error: $e');
    }
  }

}
