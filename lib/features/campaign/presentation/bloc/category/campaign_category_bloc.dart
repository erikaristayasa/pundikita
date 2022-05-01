import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/domain/entities/campaign_entity.dart';
import '../../../../../core/domain/usecases/get_campaign_categories.dart';
import '../../../../../core/errors/failure.dart';

part 'campaign_category_event.dart';
part 'campaign_category_state.dart';

class CampaignCategoryBloc extends Bloc<CampaignCategoryEvent, CampaignCategoryState> {
  final GetCampaignCategories getCampaignCategories;
  CampaignCategoryBloc({required this.getCampaignCategories}) : super(CampaignCategoryInitial()) {
    on<GetData>((event, emit) async {
      emit(CampaignCategoryLoading());

      await Future.delayed(const Duration(milliseconds: 500), () async {
        final result = await getCampaignCategories();
        result.fold(
          (failure) => emit(CampaignCategoryFailure(failure: failure)),
          (data) => emit(CampaignCategoryLoaded(data: data)),
        );
      });
    });
  }
}
