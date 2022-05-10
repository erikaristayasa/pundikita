import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/campaign_entity.dart';
import '../../domain/repositories/campaign_repository.dart';
import '../../errors/failure.dart';
import '../../static/enums.dart' as e;
import '../datasources/campaign_data_source.dart';
import '../models/common_response.model.dart';

class CampaignRepositoryImplementation implements CampaignRepository {
  final CampaignDataSource dataSource;

  CampaignRepositoryImplementation({required this.dataSource});

  @override
  Future<Either<Failure, List<Campaign>>> getAllCampaignList(e.CampaignService service, {bool auth = false, CampaignCategory? category, bool? sort, String? keyword}) async {
    try {
      final result = await dataSource.getCampaignList(service, auth: auth, category: category, sort: sort, keyword: keyword);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Campaign>> getCampaignDetail(int id, {required e.CampaignService service}) async {
    try {
      final result = await dataSource.getCampaignDetail(id, service: service);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CampaignCategory>>> getCampaignCategories() async {
    try {
      final result = await dataSource.getCategories();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CampaignSubCategory>>> getCampaignSubCategories(int id) async {
    try {
      final result = await dataSource.getSubCategories(id);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CampaignType>>> getCampaignTypes() async {
    try {
      final result = await dataSource.getTypes();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> createCampaign(Map<String, dynamic> body) async {
    try {
      final result = await dataSource.createCampaign(body);
      return Right(result);
    } on DioError catch (e) {
      try {
        final errorModel = CommonResponseModel.fromJson(e.response?.data);
        return Left(RequestFailure(message: errorModel.data ?? ''));
      } catch (e) {
        return Left(ServerFailure());
      }
    }
  }
}
