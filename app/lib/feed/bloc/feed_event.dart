part of "feed_bloc.dart";

/// Base class for events related to fetching feed data.
abstract class FeedEvent extends Equatable {
    /// Constructs a [FeedEvent] instance.
  ///
  /// This constructor initializes a new [FeedEvent] object.
  const FeedEvent();
}

/// Event indicating a request to fetch feed data for a specific category.
class FeedRequested extends FeedEvent {
  /// Constructs a [FeedRequested] event with the given [category].
  const FeedRequested({
    required this.category,
  });

  /// The category for which the feed data is requested.
  final Category category;

  @override
  List<Object> get props => [category];
}

/// Event indicating a request to refresh the feed data for a specific category.
class FeedRefreshRequested extends FeedEvent {
  /// Constructs a [FeedRefreshRequested] event with the given [category].
  const FeedRefreshRequested({required this.category});

  /// The category for which the feed data is requested to be refreshed.
  final Category category;

  @override
  List<Object> get props => [category];
}

/// Event indicating that the feed screen has been resumed.
class FeedResumed extends FeedEvent {
  /// Constructs a [FeedResumed] event.
  const FeedResumed();

  @override
  List<Object> get props => [];
}
