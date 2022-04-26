import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:toeic_learning_app/models/blog_model.dart';
import '../config/app_url_config.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class BlogRepository {
  Future<Blog> createNewBlog(title, content, List<File> images) async {
    var uri = Uri.parse(AppUrl.createNewBlog);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields['title'] = title;
    request.fields['content'] = content;
    List<MultipartFile> newList = [];
    for (int i = 0; i < images.length; i++) {
      File imageFile = images[i];
      var stream = http.ByteStream(imageFile.openRead());
      stream.cast();
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile('image', stream, length,
          filename: basename(imageFile.path),
          contentType: MediaType('image', 'png'));

      newList.add(multipartFile);
    }
    request.files.addAll(newList);
    var streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      var response = await http.Response.fromStream(streamedResponse);
      final responseBody = json.decode(response.body);
      final Blog blog = Blog.fromJson(responseBody['blog']);
      return blog;
    } else {
      throw Exception('Failed to load blog from the Internet');
    }
  }

  Future<List<Blog>> getBlogsList() async {
    Response response = await get(
      Uri.parse(AppUrl.getAllBlogs),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['blogs'];
      return jsonResponse.map((blog) => Blog.fromJson(blog)).toList();
    } else {
      throw Exception('Failed to load blogs from the Internet');
    }
  }

  Future<Map<String, dynamic>> deleteBlog(Blog blog) async {
    Map<String, dynamic> result;

    Response response = await delete(
      Uri.parse(AppUrl.deleteBlog + blog.id!),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      result = {
        'status': true,
        'message': json.decode(response.body)['message'],
      };
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['message'],
      };
    }
    return result;
  }

//   Future<Map<String, dynamic>> updateTopic(id, name, File? imageFile) async {
//     Map<String, dynamic> result;
//     if (imageFile != null) {
//       var stream = http.ByteStream(imageFile.openRead());
//       stream.cast();
//       var length = await imageFile.length();
//       var multipartFile = http.MultipartFile('image', stream, length,
//           filename: basename(imageFile.path),
//           contentType: MediaType('image', 'png'));
//       var uri = Uri.parse(AppUrl.updateTopic + id);
//       var request = http.MultipartRequest("PUT", uri);
//       request.files.add(multipartFile);
//       request.fields["name"] = name;
//       var streamedResponse = await request.send();
//       var response = await http.Response.fromStream(streamedResponse);
//       if (response.statusCode == 200) {
//         result = {
//           'status': true,
//           'message': json.decode(response.body)['message'],
//         };
//       } else {
//         result = {
//           'status': false,
//           'message': json.decode(response.body)['message'],
//         };
//       }
//       return result;
//     } else {
//       final Map<String, dynamic> topicData = {
//         'name': name,
//       };

//       Response response = await put(
//         Uri.parse(AppUrl.updateTopic + id),
//         body: json.encode(topicData),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 200) {
//         result = {
//           'status': true,
//           'message': json.decode(response.body)['message'],
//         };
//       } else {
//         result = {'status': false, 'message': 'Lỗi Internet'};
//       }
//       return result;
//     }
//   }

//   Future<File> urlToFile(String imageUrl) async {
// // generate random number.
//     var rng = Random();
// // get temporary directory of device.
//     Directory tempDir = await getTemporaryDirectory();
// // get temporary path from temporary directory.
//     String tempPath = tempDir.path;
// // create a new file in temporary path with random file name.
//     File file = File(tempPath + (rng.nextInt(100)).toString() + '.png');
// // call http.get method and pass imageUrl into it to get response.
//     http.Response response = await http.get(Uri.parse(imageUrl));
// // write bodyBytes received in response to file.
//     await file.writeAsBytes(response.bodyBytes);
// // now return the file which is created with random name in
// // temporary directory and image bytes from response is written to // that file.
//     return file;
//   }
}
