part of 'category_filter_bloc.dart';

abstract class CategoryFilterState extends Equatable {
  const CategoryFilterState();

  @override
  List<Object> get props => [];
}

class CategoryFilterInitial extends CategoryFilterState {}

class CategoryFilterLoading extends CategoryFilterState {}

class CategoryFilterLoaded extends CategoryFilterState {
  final List<CampaignCategory> data;
  final CampaignCategory? selectedData;

  const CategoryFilterLoaded({required this.data, this.selectedData});

  @override
  List<Object> get props => [data, selectedData ?? const CampaignCategory(id: 0, icon: '', categoryName: '')];
}

class CategoryFilterFailure extends CategoryFilterState {}
