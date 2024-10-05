import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/providers/comment_provider.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/widgets/comment_cart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentsAsyncValue = ref.watch(commentsProvider);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: Text(
          'Comments',
          style: TextStyle(
            fontFamily: 'PoppinsBold',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: commentsAsyncValue.when(
          data: (comments) => ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              final comment = comments[index];
              return CommentCard(data: comment);
            },
          ),
          loading: () => CircularProgressIndicator(),
          error: (error, stackTrace) => Text('Error: ${error.toString()}'),
        ),
      ),
    );
  }
}
