import 'package:equatable/equatable.dart';
import 'package:pundi_kita/core/domain/entities/campaign_entity.dart';
import 'package:pundi_kita/core/domain/entities/user_entity.dart';

import '../../static/enums.dart';

class Donation extends Equatable {
  final int id;
  final int userId;
  final int campaignId;
  final num amountOfFunds;
  final String? pray;
  final int? paymentTransactionId;
  final PaymentMethod paymentMethod;
  final PaymentChannel paymentChannel;
  final String? paymentNumber;
  final String? paymentName;
  final num paymentTotal;
  final num paymentFee;
  final DateTime? paymentExpired;
  final String? paymentQRImage;
  final DonationPayStatus status;
  final bool likeStatus;
  final DateTime? createdAt;
  final List<Like> likes;
  final Campaign? campaign;
  final User? user;

  const Donation({
    required this.id,
    required this.userId,
    required this.campaignId,
    required this.amountOfFunds,
    required this.pray,
    required this.paymentTransactionId,
    required this.paymentMethod,
    required this.paymentChannel,
    required this.paymentNumber,
    required this.paymentName,
    required this.paymentTotal,
    required this.paymentFee,
    required this.paymentExpired,
    required this.paymentQRImage,
    required this.status,
    required this.likeStatus,
    required this.createdAt,
    required this.likes,
    required this.campaign,
    required this.user,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        campaignId,
        amountOfFunds,
        pray,
        paymentTransactionId,
        paymentMethod,
        paymentChannel,
        paymentNumber,
        paymentName,
        paymentTotal,
        paymentFee,
        paymentExpired,
        paymentQRImage,
        status,
        likeStatus,
        createdAt,
        likes,
        campaign,
        user,
      ];
}

class Like extends Equatable {
  final int id, userId;

  const Like({
    required this.id,
    required this.userId,
  });

  @override
  List<Object?> get props => [id, userId];
}
