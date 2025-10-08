class NotificationsResponse {
  final bool success;
  final String message;
  final List<NotificationItem> data;
  final Pagination pagination;

  NotificationsResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    return NotificationsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination:
      Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data.map((e) => e.toJson()).toList(),
    'pagination': pagination.toJson(),
  };
}

class NotificationItem {
  final String id;
  final String? img;
  final String title;
  final String description;
  final List<ActionItem> actions;
  final Meta meta;

  NotificationItem({
    required this.id,
    this.img,
    required this.title,
    required this.description,
    required this.actions,
    required this.meta,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'] ?? '',
      img: json['img'] as String?,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      actions: (json['actions'] as List<dynamic>? ?? [])
          .map((e) => ActionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'img': img,
    'title': title,
    'description': description,
    'actions': actions.map((e) => e.toJson()).toList(),
    'meta': meta.toJson(),
  };
}

class ActionItem {
  final bool bgPrimary;
  final String text;
  final String url;
  final String reqMethod;
  final bool disabled;

  ActionItem({
    required this.bgPrimary,
    required this.text,
    required this.url,
    required this.reqMethod,
    required this.disabled,
  });

  factory ActionItem.fromJson(Map<String, dynamic> json) {
    return ActionItem(
      bgPrimary: json['bg_primary'] ?? false,
      text: json['text'] ?? '',
      url: json['url'] ?? '',
      reqMethod: json['req_method'] ?? '',
      disabled: json['disabled'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'bg_primary': bgPrimary,
    'text': text,
    'url': url,
    'req_method': reqMethod,
    'disabled': disabled,
  };
}

class Meta {
  final String sessionDetails;

  Meta({required this.sessionDetails});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      sessionDetails: json['sessionDetails'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'sessionDetails': sessionDetails,
  };
}

class Pagination {
  final int total;
  final int page;
  final int perPage;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPrevPage;

  Pagination({
    required this.total,
    required this.page,
    required this.perPage,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPrevPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      perPage: json['perPage'] ?? 10,
      totalPages: json['totalPages'] ?? 1,
      hasNextPage: json['hasNextPage'] ?? false,
      hasPrevPage: json['hasPrevPage'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'total': total,
    'page': page,
    'perPage': perPage,
    'totalPages': totalPages,
    'hasNextPage': hasNextPage,
    'hasPrevPage': hasPrevPage,
  };
}
