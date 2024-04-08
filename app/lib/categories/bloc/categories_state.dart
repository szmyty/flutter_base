part of "categories_bloc.dart";

/// Represents the status of the categories bloc.
///
/// This enumeration defines various states that the categories bloc can be
/// in during its lifecycle. These states include initial state, loading state,
/// populated state, and failure state.
enum CategoriesStatus {
    /// Represents the initial state of the categories bloc.
    initial,

    /// Represents the loading state of the categories bloc.
    loading,

    /// Represents the state where categories data is successfully populated.
    populated,

    /// Represents the state where an error occurred while fetching categories
    /// data.
    failure,
}

/// Represents the state of the categories bloc.
///
/// This class encapsulates the state of the categories bloc, including the
/// current status, list of categories, and the selected category. Instances of
/// this class are immutable, and changes to the state are performed through the
/// [copyWith] method.
@JsonSerializable()
class CategoriesState extends Equatable {

  /// Constructs a [CategoriesState] instance.
  ///
  /// This constructor initializes a new [CategoriesState] object with the
  /// provided [status], [categories], and [selectedCategory].
  const CategoriesState({
    required this.status,
    this.categories,
    this.selectedCategory,
  });

  /// Constructs an initial [CategoriesState] instance.
  ///
  /// This factory constructor creates a new [CategoriesState] object in the
  /// initial state.
  const CategoriesState.initial()
      : this(
          status: CategoriesStatus.initial,
        );

  /// Constructs a [CategoriesState] instance from a JSON map.
  ///
  /// This factory constructor creates a new [CategoriesState] object from a
  /// JSON map representation. It is typically used to deserialize JSON data
  /// retrieved from an external source.
  factory CategoriesState.fromJson(Map<String, dynamic> json) =>
      _$CategoriesStateFromJson(json);

  /// Represents the current status of the categories bloc.
  final CategoriesStatus status;

  /// Represents the list of categories.
  final List<Category>? categories;

  /// Represents the selected category.
  final Category? selectedCategory;

  @override
  List<Object?> get props => [
        status,
        categories,
        selectedCategory,
      ];

  /// Creates a copy of this state with the provided properties.
  ///
  /// This method returns a new [CategoriesState] instance with the provided
  /// properties. Any property not explicitly provided will remain unchanged.
  CategoriesState copyWith({
    CategoriesStatus? status,
    List<Category>? categories,
    Category? selectedCategory,
  }) {
    return CategoriesState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  /// Converts this state to a JSON map.
  ///
  /// This method converts the current state to a JSON map representation, which
  /// can be serialized and stored or transmitted as needed.
  Map<String, dynamic> toJson() => _$CategoriesStateToJson(this);
}
