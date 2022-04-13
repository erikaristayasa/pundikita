part of 'category_filter_bloc.dart';

abstract class CategoryFilterEvent extends Equatable {
  const CategoryFilterEvent();

  @override
  List<Object> get props => [];
}

class GetCategories extends CategoryFilterEvent {}

class OnSelectCategory extends CategoryFilterEvent {
  final CampaignCategory category;

  const OnSelectCategory({required this.category});

  @override
  List<Object> get props => [category];
}
