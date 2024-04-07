part of "analytics_bloc.dart";

/// {@template analytics_state}
/// The base class for all states related to analytics.
/// {@endtemplate}
abstract class AnalyticsState extends Equatable {
    /// {@macro analytics_state}
    const AnalyticsState();
}

/// {@template analytics_initial}
/// The initial state for the analytics bloc.
/// {@endtemplate}
class AnalyticsInitial extends AnalyticsState {
  @override
  List<Object> get props => [];
}
