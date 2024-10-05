import 'package:flutter_application_1/models/Comment_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final commentsProvider = FutureProvider<List<CommentModel>>((ref) async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((e) => CommentModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load comments');
  }
});
