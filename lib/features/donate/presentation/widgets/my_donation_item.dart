import 'package:flutter/material.dart';
import 'package:pundi_kita/core/domain/entities/donation_entity.dart';
import 'package:pundi_kita/core/presentation/widgets/rounded_container.dart';
import 'package:pundi_kita/core/utility/helper.dart';

class MyDonationItem extends StatelessWidget {
  final Donation donation;
  const MyDonationItem({Key? key, required this.donation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: ListTile(
        title: Text(
          getFormattedPrice(donation.amountOfFunds.toInt()),
        ),
        subtitle: Text(donation.pray ?? ''),
      ),
    );
  }
}
