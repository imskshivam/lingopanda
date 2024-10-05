import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/providers/remote_config_provider.dart';
import 'package:flutter_application_1/models/Comment_model.dart';

import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentCard extends ConsumerWidget {
  final CommentModel data;

  const CommentCard({Key? key, required this.data}) : super(key: key);

  String formatEmail(String email, bool mask) {
    if (mask) {
      final parts = email.split('@');
      if (parts.length > 1) {
        final maskedPart = parts[0].substring(0, 3) + '****';
        return '$maskedPart@${parts[1]}';
      }
      return email;
    }
    return email;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remoteConfigAsyncValue = ref.watch(remoteConfigProvider);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 228, 232, 238),
            blurRadius: 10.0,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.greyAccent,
                child: Text(
                  data.name?.substring(0, 1).toUpperCase() ?? 'A',
                  style:
                      TextStyle(color: Colors.black, fontFamily: 'PoppinsBold'),
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Name: ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              color: AppColors.greyAccent,
                            ),
                          ),
                          TextSpan(
                            text: data.name ?? 'N/A',
                            style: TextStyle(
                              fontFamily: 'PoppinsBold',
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    remoteConfigAsyncValue.when(
                      data: (config) {
                        final bool maskEmail = config['mask_email'] ?? false;
                        return RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Email: ',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: AppColors.greyAccent,
                                ),
                              ),
                              TextSpan(
                                text:
                                    formatEmail(data.email ?? 'N/A', maskEmail),
                                style: TextStyle(
                                  fontFamily: 'PoppinsBold',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                        );
                      },
                      loading: () => CircularProgressIndicator(),
                      error: (error, stackTrace) =>
                          Text('Error loading config'),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      data.body ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
