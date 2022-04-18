import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/domain/entities/campaign_entity.dart';
import '../../../../../core/domain/usecases/get_campaign_categories.dart';

part 'category_filter_event.dart';
part 'category_filter_state.dart';

class CategoryFilterBloc extends Bloc<CategoryFilterEvent, CategoryFilterState> {
  final GetCampaignCategories getCampaignCategories;
  CategoryFilterBloc({required this.getCampaignCategories}) : super(CategoryFilterInitial()) {
    on<GetCategories>((event, emit) async {
      emit(CategoryFilterLoading());
      final result = await getCampaignCategories();
      result.fold(
        (_) => emit(CategoryFilterFailure()),
        (data) {
          final _category = [const CampaignCategory(id: 0, icon: '', categoryName: 'Semua')];
          _category.addAll(data);
          emit(CategoryFilterLoaded(data: _category));
        },
      );
    });

    on<OnSelectCategory>((event, emit) {
      emit(CategoryFilterLoaded(data: (state as CategoryFilterLoaded).data, selectedData: event.category));
    });
  }
}
