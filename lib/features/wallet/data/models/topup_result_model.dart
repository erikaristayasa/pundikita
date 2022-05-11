import '../../../../core/static/enums.dart';
import '../../../../core/static/extensions.dart';
import '../../domain/entities/topup_result_entity.dart';

class TopUpResultModel extends TopUpResult {
  const TopUpResultModel({
    required int id,
    required int userId,
    required num amount,
    required int? paymentTransactionId,
    required PaymentMethod paymentMethod,
    required PaymentChannel paymentChannel,
    required String? paymentNumber,
    required String? paymentName,
    required num paymentTotal,
    required num paymentFee,
    required DateTime? paymentExpired,
    required String? paymentQRImage,
    required WalletTopUpPayStatus status,
    required DateTime? createdAt,
  }) : super(
          id: id,
          userId: userId,
          amount: amount,
          paymentTransactionId: paymentTransactionId,
          paymentMethod: paymentMethod,
          paymentChannel: paymentChannel,
          paymentNumber: paymentNumber,
          paymentName: paymentName,
          paymentTotal: paymentTotal,
          paymentFee: paymentFee,
          paymentExpired: paymentExpired,
          paymentQRImage: paymentQRImage,
          status: status,
          createdAt: createdAt,
        );
  factory TopUpResultModel.fromJson(Map<String, dynamic> json) => TopUpResultModel(
        id: json['id'],
        userId: json['user_id'],
        amount: json['jumlah'],
        paymentTransactionId: json['payment_transaction_id'],
        paymentMethod: PaymentMethod.values.firstWhere((element) => element.name == json['payment_method']),
        paymentChannel: PaymentChannel.values.firstWhere((element) => element.name == json['payment_channel']),
        paymentNumber: json['payment_no'],
        paymentName: json['payment_name'],
        paymentTotal: json['payment_total'],
        paymentFee: json['payment_fee'],
        paymentExpired: (json['payment_expired'] as String).toDate(format: "yyyy-MM-dd HH:mm:ss"),
        paymentQRImage: json['payment_qr_image'],
        status: (json['status'] as num).walletTopUpPayStatus(),
        createdAt: (json['created_at'] as String).toDate(),
      );
}
