import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/presentation/Comment_Page.dart';
import 'package:flutter_application_1/features/presentation/login_page.dart';
import 'package:flutter_application_1/features/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class AuthWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          return CommentsPage();  
        } else {
          return LoginPage();  
        }
      },
      loading: () => Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => Scaffold(
        body: Center(child: Text('Error: $error')),
      ),
    );
  }
}
