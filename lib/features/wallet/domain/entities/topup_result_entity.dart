import 'package:equatable/equatable.dart';

import '../../../../core/static/enums.dart';

class TopUpResult extends Equatable {
  final int id;
  final int userId;
  final num amount;
  final int? paymentTransactionId;
  final PaymentMethod paymentMethod;
  final PaymentChannel paymentChannel;
  final String? paymentNumber;
  final String? paymentName;
  final num paymentTotal;
  final num paymentFee;
  final DateTime? paymentExpired;
  final String? paymentQRImage;
  final WalletTopUpPayStatus status;
  final DateTime? createdAt;

  const TopUpResult({
    required this.id,
    required this.userId,
    required this.amount,
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
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        amount,
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
        createdAt,
      ];
}
