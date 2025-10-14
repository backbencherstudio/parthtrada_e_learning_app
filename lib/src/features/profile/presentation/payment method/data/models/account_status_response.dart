class AccountStatusResponse {
  bool? isOnboarded;
  String? accountId;
  Requirements? requirements;

  AccountStatusResponse({
    this.isOnboarded,
    this.accountId,
    this.requirements,
  });

  AccountStatusResponse.fromJson(Map<String, dynamic> json) {
    isOnboarded = json['isOnboarded'];
    accountId = json['accountId'];
    requirements = json['requirements'] != null
        ? Requirements.fromJson(json['requirements'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isOnboarded'] = isOnboarded;
    data['accountId'] = accountId;
    if (requirements != null) {
      data['requirements'] = requirements!.toJson();
    }
    return data;
  }
}

class Requirements {
  List<dynamic>? alternatives;
  dynamic currentDeadline;
  List<String>? currentlyDue;
  String? disabledReason;
  List<dynamic>? errors;
  List<String>? eventuallyDue;
  List<String>? pastDue;
  List<dynamic>? pendingVerification;

  Requirements({
    this.alternatives,
    this.currentDeadline,
    this.currentlyDue,
    this.disabledReason,
    this.errors,
    this.eventuallyDue,
    this.pastDue,
    this.pendingVerification,
  });

  Requirements.fromJson(Map<String, dynamic> json) {
    alternatives = json['alternatives'] != null
        ? List<dynamic>.from(json['alternatives'])
        : [];
    currentDeadline = json['current_deadline'];
    currentlyDue = json['currently_due'] != null
        ? List<String>.from(json['currently_due'])
        : [];
    disabledReason = json['disabled_reason'];
    errors = json['errors'] != null ? List<dynamic>.from(json['errors']) : [];
    eventuallyDue = json['eventually_due'] != null
        ? List<String>.from(json['eventually_due'])
        : [];
    pastDue = json['past_due'] != null
        ? List<String>.from(json['past_due'])
        : [];
    pendingVerification = json['pending_verification'] != null
        ? List<dynamic>.from(json['pending_verification'])
        : [];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['alternatives'] = alternatives ?? [];
    data['current_deadline'] = currentDeadline;
    data['currently_due'] = currentlyDue ?? [];
    data['disabled_reason'] = disabledReason;
    data['errors'] = errors ?? [];
    data['eventually_due'] = eventuallyDue ?? [];
    data['past_due'] = pastDue ?? [];
    data['pending_verification'] = pendingVerification ?? [];
    return data;
  }
}
