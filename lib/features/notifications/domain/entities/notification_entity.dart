class NotificationEntity {
  final String title;

  final DateTime timestamp;

  NotificationEntity({required this.title, required this.timestamp});

  NotificationEntity copyWith({String? title, DateTime? timestamp}) {
    return NotificationEntity(
      title: title ?? this.title,

      timestamp: timestamp ?? this.timestamp,
    );
  }
}
