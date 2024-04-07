part of "analytics_bloc.dart";

/// {@template analytics_event}
/// The base class for all events related to analytics.
/// {@endtemplate}
abstract class AnalyticsEvent extends Equatable {
    /// {@macro analytics_event}
    const AnalyticsEvent();
}

/// {@template track_analytics_event}
/// An event to track analytics.
/// {@endtemplate}
class TrackAnalyticsEvent extends AnalyticsEvent {
    /// {@macro track_analytics_event}
    const TrackAnalyticsEvent(this.event);

    /// The analytics event to track.
    final analytics.AnalyticsEvent event;

    @override
    List<Object> get props => [event];
}
