import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/campaign_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../static/enums.dart';
import '../../static/extensions.dart';
import 'user_model.dart';

class CampaignModel extends Campaign {
  const CampaignModel({
    required int id,
    required CampaignService campaignService,
    required int? userId,
    required int? campaignTypeId,
    required int? campaignCategoryId,
    required int? campaignSubCategoryid,
    required int? organizer,
    required String? title,
    required DateTime? endDate,
    required num amountOfFunds,
    required num amountOfCollectedFunds,
    required String? phone,
    required String? patientPhone,
    required String? photo,
    required String? story,
    required String? sortInvitation,
    required String? patienIdPhoto,
    required String? medicalCertificatePhoto,
    required String? medicalResultPhoto,
    required String? patientName,
    required String? patientSickness,
    required bool? hospitalizationStatus,
    required String? hospitalName,
    required String? treatmentEfforts,
    required String? treatmentSources,
    required String? ktpName,
    required String? job,
    required String? schoolOrWorkName,
    required String? facebookUrl,
    required String? instagramUrl,
    required String? twitterUrl,
    required String? linkkedInUrl,
    required String? eventName,
    required String? eventGoal,
    required String? eventAddress,
    required String? detailOfUseOfFunds,
    required int status,
    required User? user,
    required CampaignTypeModel? campaignType,
    required CampaignCategoryModel? campaignCategory,
    required CampaignSubCategoryModel? campaignSubCategory,
    required List<CampaignDonationModel> donation,
  }) : super(
          id: id,
          campaignService: campaignService,
          userId: userId,
          campaignTypeId: campaignTypeId,
          campaignCategoryId: campaignCategoryId,
          campaignSubCategoryid: campaignSubCategoryid,
          organizer: organizer,
          title: title,
          endDate: endDate,
          amountOfFunds: amountOfFunds,
          amountOfCollectedFunds: amountOfCollectedFunds,
          phone: phone,
          patientPhone: patientPhone,
          photo: photo,
          story: story,
          sortInvitation: sortInvitation,
          patienIdPhoto: patienIdPhoto,
          medicalCertificatePhoto: medicalCertificatePhoto,
          medicalResultPhoto: medicalResultPhoto,
          patientName: patientName,
          patientSickness: patientSickness,
          hospitalizationStatus: hospitalizationStatus,
          hospitalName: hospitalName,
          treatmentEfforts: treatmentEfforts,
          treatmentSources: treatmentSources,
          ktpName: ktpName,
          job: job,
          schoolOrWorkName: schoolOrWorkName,
          facebookUrl: facebookUrl,
          instagramUrl: instagramUrl,
          twitterUrl: twitterUrl,
          linkkedInUrl: linkkedInUrl,
          eventName: eventName,
          eventGoal: eventGoal,
          eventAddress: eventAddress,
          detailOfUseOfFunds: detailOfUseOfFunds,
          status: status,
          user: user,
          campaignType: campaignType,
          campaignCategory: campaignCategory,
          campaignSubCategory: campaignSubCategory,
          donation: donation,
        );
  factory CampaignModel.fromJson(Map<String, dynamic> json) => CampaignModel(
        id: json['id'],
        campaignService: json['campaign_service'] == 0 ? CampaignService.donasi : CampaignService.zakat,
        userId: json['user_id'],
        campaignTypeId: json['campaign_type_id'],
        campaignCategoryId: json['campaign_category_id'],
        campaignSubCategoryid: json['campaign_sub_category_id'],
        organizer: json['penyelenggara'],
        title: json['judul'],
        endDate: json['tanggal_selesai'] != null ? (json['tanggal_selesai'].toString().toDate()) : null,
        amountOfFunds: (json['jumlah_dana'] is num) ? json['jumlah_dana'] : 0,
        amountOfCollectedFunds: json['jumlah_dana_terkumpul'],
        phone: json['telepon'],
        patientPhone: json['telepon_pasien'],
        photo: json['foto'],
        story: json['cerita'],
        sortInvitation: json['ajakan_singkat'],
        patienIdPhoto: json['foto_surat_identitas_pasien'],
        medicalCertificatePhoto: json['foto_surat_keterangan_medis'],
        medicalResultPhoto: json['foto_surat_hasil_pemeriksaan'],
        patientName: json['nama_pasien'],
        patientSickness: json['nama_penyakit'],
        hospitalizationStatus: json['status_rawat_inap'],
        hospitalName: json['nama_rumah_sakit_rawat_inap'],
        treatmentEfforts: json['upaya_pengobatan'],
        treatmentSources: json['sumber_dana_pengobatan'],
        ktpName: json['nama_ktp'],
        job: json['pekerjaan'],
        schoolOrWorkName: json['nama_sekolah_atau_tempat_kerja'],
        facebookUrl: json['link_akun_facebook'],
        instagramUrl: json['link_akun_instagram'],
        twitterUrl: json['link_akun_twitter'],
        linkkedInUrl: json['link_akun_linkedin'],
        eventName: json['nama_acara'],
        eventGoal: json['tujuan_acara'],
        eventAddress: json['lokasi_acara'],
        detailOfUseOfFunds: json['rincian_penggunaan_dana'],
        status: json['status'],
        user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
        campaignType: json['campaign_type'] != null ? CampaignTypeModel.fromJson(json['campaign_type']) : null,
        campaignCategory: json['campaign_category'] != null ? CampaignCategoryModel.fromJson(json['campaign_category']) : null,
        campaignSubCategory: json['campaign_sub_category'] != null ? CampaignSubCategoryModel.fromJson(json['campaign_sub_category']) : null,
        donation: json['donation'] != null ? List<CampaignDonationModel>.from(json['donation'].map((x) => CampaignDonationModel.fromJson(x))) : [],
      );

  Future<FormData> createBody({
    required XFile photoFile,
    required XFile patienIdPhotoFile,
    required XFile medicalCertificatePhotoFile,
    required XFile medicalResultPhotoFile,
    String? patientPhone,
  }) async {
    var map = {
      'campaign_type_id': campaignTypeId,
      'campaign_category_id': campaignCategoryId,
      'campaign_sub_category_id': campaignSubCategoryid,
      'telepon': phone,
      'nama_pasien': patientName,
      'nama_penyakit': patientSickness,
      'status_rawat_inap': hospitalizationStatus,
      'nama_rumah_sakit_rawat_inap': hospitalName,
      'upaya_pengobatan': treatmentEfforts,
      'sumber_dana_pengobatan': treatmentSources,
      'jumlah_dana': amountOfFunds,
      'tanggal_selesai': endDate.toText(),
      'rincian_penggunaan_dana': detailOfUseOfFunds,
      'judul': title,
      'cerita': story,
      'ajakan_singkat': sortInvitation,
      if (patientPhone != null) 'telepon_pasien': patientPhone
    };
    map['foto'] = await MultipartFile.fromFile(photoFile.path, filename: photoFile.name);
    map['foto_surat_identitas_pasien'] = await MultipartFile.fromFile(patienIdPhotoFile.path, filename: patienIdPhotoFile.name);
    map['foto_surat_keterangan_medis'] = await MultipartFile.fromFile(medicalCertificatePhotoFile.path, filename: medicalCertificatePhotoFile.name);
    map['foto_surat_hasil_pemeriksaan'] = await MultipartFile.fromFile(medicalResultPhotoFile.path, filename: medicalResultPhotoFile.name);
    return FormData.fromMap(map);
  }
}

class CampaignTypeModel extends CampaignType {
  const CampaignTypeModel({
    required int id,
    required String icon,
    required String? title,
    required String? description,
  }) : super(
          id: id,
          icon: icon,
          title: title,
          description: description,
        );
  factory CampaignTypeModel.fromJson(Map<String, dynamic> json) => CampaignTypeModel(
        id: json['id'],
        icon: json['icon'],
        title: json['judul'],
        description: json['deskripsi'],
      );
}

class CampaignCategoryModel extends CampaignCategory {
  const CampaignCategoryModel({
    required int id,
    required String? icon,
    required String? categoryName,
  }) : super(
          id: id,
          icon: icon,
          categoryName: categoryName,
        );

  factory CampaignCategoryModel.fromJson(Map<String, dynamic> json) => CampaignCategoryModel(
        id: json['id'],
        icon: json['icon'],
        categoryName: json['nama_kategori'],
      );
}

class CampaignSubCategoryModel extends CampaignSubCategory {
  const CampaignSubCategoryModel({
    required int id,
    required int campaignCategoryId,
    required String? title,
    required String? description,
  }) : super(
          id: id,
          campaignCategoryId: campaignCategoryId,
          title: title,
          description: description,
        );
  factory CampaignSubCategoryModel.fromJson(Map<String, dynamic> json) => CampaignSubCategoryModel(
        id: json['id'],
        campaignCategoryId: json['campaign_category_id'],
        title: json['judul'],
        description: json['deskripsi'],
      );
}

class CampaignDonationModel extends CampaignDonation {
  const CampaignDonationModel({
    required int id,
    required int userId,
    required int campaignId,
    required num amountOfFunds,
    required String? pray,
    required int paymentTransactionId,
    required PaymentMethod paymentMethod,
    required PaymentChannel paymentChannel,
    required String paymentNumber,
    required String paymentName,
    required num paymentTotal,
    required num paymentFee,
    required DateTime? paymentExpired,
    required String? paymentQRImage,
    required int status,
    required bool likeStatus,
    required DateTime? createdAt,
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
        );
  factory CampaignDonationModel.fromJson(Map<String, dynamic> json) => CampaignDonationModel(
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
        paymentExpired: (json['payment_expired'] as String).toDate(),
        paymentQRImage: json['payment_qr_image'],
        status: json['status'],
        likeStatus: json['like_status'],
        createdAt: (json['created_at'] as String).toDate(),
      );
}
