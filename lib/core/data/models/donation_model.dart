import '../../domain/entities/donation_entity.dart';
import '../../static/enums.dart';
import '../../static/extensions.dart';

class DonationModel extends Donation {
  const DonationModel({
    required int id,
    required int userId,
    required int campaignId,
    required num amountOfFunds,
    required String? pray,
    required int? paymentTransactionId,
    required PaymentMethod paymentMethod,
    required PaymentChannel paymentChannel,
    required String? paymentNumber,
    required String? paymentName,
    required num paymentTotal,
    required num paymentFee,
    required DateTime? paymentExpired,
    required String? paymentQRImage,
    required DonationPayStatus status,
    required bool likeStatus,
    required DateTime? createdAt,
    required List<LikeModel> likes,
  }) : super(
          id: id,
          userId: userId,
          campaignId: campaignId,
          amountOfFunds: amountOfFunds,
          pray: pray,
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
          likeStatus: likeStatus,
          createdAt: createdAt,
          likes: likes,
        );
  factory DonationModel.fromJson(Map<String, dynamic> json) => DonationModel(
        id: json['id'],
        userId: json['user_id'],
        campaignId: json['campaign_id'],
        amountOfFunds: json['jumlah_dana'],
        pray: json['doa'],
        paymentTransactionId: json['payment_transaction_id'],
        paymentMethod: PaymentMethod.values.firstWhere((element) => element.name == json['payment_method']),
        paymentChannel: PaymentChannel.values.firstWhere((element) => element.name == json['payment_channel']),
        paymentNumber: json['payment_no'],
        paymentName: json['payment_name'],
        paymentTotal: json['payment_total'],
        paymentFee: json['payment_fee'],
        paymentExpired: (json['payment_expired'] as String).toDate(format: "yyyy-MM-dd HH:mm:ss"),
        paymentQRImage: json['payment_qr_image'],
        status: (json['status'] as num).donationPayStatus(),
        likeStatus: json['like_status'],
        createdAt: (json['created_at'] as String).toDate(),
        likes: json['like'] != null ? json['like'].map((x) => LikeModel.fromJson(x)) : [],
      );
}

class LikeModel extends Like {
  const LikeModel({required int id, required int userId}) : super(id: id, userId: userId);

  factory LikeModel.fromJson(Map<String, dynamic> json) => LikeModel(
        id: json['id'],
        userId: json['user_id'],
      );
}
