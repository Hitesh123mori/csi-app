class CSIEvent {
   String? eventName;
   String? registerUrl;
   String? participantsCount;
   String? notificationDuration;
   String? startDate;
   String? endDate;
   String? startTime;
   String? endTime;

  CSIEvent({
     this.eventName,
     this.registerUrl,
     this.startTime,
     this.participantsCount,
     this.endTime,
      this.startDate,
    this.endDate,
     this.notificationDuration,
  });

  CSIEvent.fromJson(dynamic json) {
    eventName = json['eventName'];
    registerUrl = json['registerUrl'];
    participantsCount = json['participantsCount'];
    notificationDuration = json['notificationDuration'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventName'] = eventName;
    data['registerUrl'] = registerUrl;
    data['startTime'] = startTime;
    data['participantsCount'] = participantsCount;
    data['startDate'] = startDate;
    data['endDate'] = endDate ;
    data['endTime'] = endTime;
    data['notificationDuration'] = notificationDuration;
    return data;
  }
}
