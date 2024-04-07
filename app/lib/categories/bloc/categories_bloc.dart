import "dart:async";

import "package:collection/collection.dart";
import "package:equatable/equatable.dart";
import "package:feed_repository/feed_repository.dart";
import "package:hydrated_bloc/hydrated_bloc.dart";
import "package:json_annotation/json_annotation.dart";

part "categories_bloc.g.dart";
part "categories_event.dart";
part "categories_state.dart";

class CategoriesBloc extends HydratedBloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc({
    required FeedRepository feedRepository,
  })  : _feedRepository = feedRepository,
        super(const CategoriesState.initial()) {
    on<CategoriesRequested>(_onCategoriesRequested);
    on<CategorySelected>(_onCategorySelected);
  }

  final FeedRepository _feedRepository;

  FutureOr<void> _onCategoriesRequested(
    CategoriesRequested event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(state.copyWith(status: CategoriesStatus.loading));
    try {
      final response = await _feedRepository.getCategories();

      emit(
        state.copyWith(
          status: CategoriesStatus.populated,
          categories: response.categories,
          selectedCategory: response.categories.firstOrNull,
        ),
      );
    } catch (error, stackTrace) {
      emit(state.copyWith(status: CategoriesStatus.failure));
      addError(error, stackTrace);
    }
  }

  void _onCategorySelected(
    CategorySelected event,
    Emitter<CategoriesState> emit,
  ) =>
      emit(state.copyWith(selectedCategory: event.category));

  @override
  CategoriesState? fromJson(Map<String, dynamic> json) =>
      CategoriesState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(CategoriesState state) => state.toJson();
}
