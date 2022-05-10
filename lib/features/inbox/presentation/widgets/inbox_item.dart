import 'package:flutter/material.dart';
import 'package:pundi_kita/core/static/extensions.dart';

import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/static/assets.dart';
import '../../domain/entities/inbox.dart';

class InboxItem extends StatelessWidget {
  final Inbox inbox;
  const InboxItem({Key? key, required this.inbox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: ListTile(
        leading: Image.asset(
          Assets.BELL,
          width: 24.0,
          alignment: Alignment.center,
        ),
        title: Text(
          inbox.title ?? '',
          style: context.textTheme().titleSmall,
        ),
        subtitle: Text(
          inbox.description ?? '',
          maxLines: 10,
        ),
      ),
    );
  }
}
