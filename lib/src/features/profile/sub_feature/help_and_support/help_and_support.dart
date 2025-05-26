import 'package:e_learning_app/src/features/message/presentation/inbox_screen/inbox_screen.dart';
import 'package:flutter/cupertino.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return InboxScreen(
      image:
          'https://yt3.googleusercontent.com/K8WVrQAQHTTwsHEtisMYcNai7p7XIlyEAdZg86qYw78ye57r5DRemHQ9Te4PcD_v98HB-ZvQjQ=s900-c-k-c0x00ffffff-no-rj',
      name: 'TrueNote Support',
      userId: '1',
    );
  }
}
