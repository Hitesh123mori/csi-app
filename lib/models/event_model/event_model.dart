class CSIEvent {
  final String eventName;
  final String description;
  final DateTime startTime;
  final DateTime endTime;

  CSIEvent({
    required this.eventName,
    required this.description,
    required this.startTime,
    required this.endTime,
  });
}
