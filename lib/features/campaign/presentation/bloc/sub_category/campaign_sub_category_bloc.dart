import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/domain/entities/campaign_entity.dart';
import '../../../../../core/domain/usecases/get_campaign_sub_categories.dart';
import '../../../../../core/errors/failure.dart';

part 'campaign_sub_category_event.dart';
part 'campaign_sub_category_state.dart';

class CampaignSubCategoryBloc extends Bloc<CampaignSubCategoryEvent, CampaignSubCategoryState> {
  final GetCampaignSubCategories getCampaignSubCategories;
  CampaignSubCategoryBloc({required this.getCampaignSubCategories}) : super(CampaignSubCategoryInitial()) {
    on<GetData>((event, emit) async {
      emit(CampaignSubCategoryLoading());

      await Future.delayed(const Duration(milliseconds: 500), () async {
        final result = await getCampaignSubCategories(event.id);
        result.fold(
          (failure) => emit(CampaignSubCategoryFailure(failure: failure)),
          (data) => emit(CampaignSubCategoryLoaded(data: data)),
        );
      });
    });
  }
}
