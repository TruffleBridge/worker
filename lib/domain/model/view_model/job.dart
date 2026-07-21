import 'package:equatable/equatable.dart';
import 'package:nimora_worker/core/enums/job_badge.dart';
import 'package:nimora_worker/core/enums/job_status.dart';
import 'package:nimora_worker/core/enums/shift_status.dart';

/// A single session entry from the API sessions array.
class JobSession {
  final String startTime;
  final String endTime;
  final String startDate;
  final String endDate;

  const JobSession({
    required this.startTime,
    required this.endTime,
    required this.startDate,
    required this.endDate,
  });

  factory JobSession.fromJson(Map<String, dynamic> json) {
    return JobSession(
      startTime: json['startTime'] as String? ?? '',
      endTime: json['endTime'] as String? ?? '',
      startDate: json['startDate'] as String? ?? '',
      endDate: json['endDate'] as String? ?? '',
    );
  }

  /// Format "09:00:00" → "9:00 AM"
  static String _fmt(String t) {
    try {
      final parts = t.split(':');
      int h = int.parse(parts[0]);
      final m = parts[1];
      final suffix = h >= 12 ? 'PM' : 'AM';
      h = h % 12;
      if (h == 0) h = 12;
      return '$h:$m $suffix';
    } catch (_) {
      return t;
    }
  }

  String get formattedTime => '${_fmt(startTime)} - ${_fmt(endTime)}';

  String get formattedDateRange => '$startDate → $endDate';
}

class Job extends Equatable {
  final String id;

  final String title;

  final String company;

  final String location;

  final double distanceKm;

  final double hourlyRate;

  final int sessionsPerWeek;

  final int hoursPerWeek;

  final String postedAgo;

  final int applicationCount;

  final List<JobBadge> badges;

  final bool isSaved;

  final JobStatus status;

  // Tracker Flow
  final ShiftStatus shiftStatus;

  final bool transportRequired;

  final bool isApplied;

  final bool isCheckedIn;

  final bool isCompleted;

  // Client Details
  final String? clientName;

  final String? clientDescription;

  final String? clientProfilePicture;

  final String? clientEmail;

  final String? clientPhone;

  // Service Details
  final List<String> serviceRequirements;

  // Schedule
  final String scheduleTime;

  final String scheduleDays;

  final List<JobSession> jobSessions;

  const Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.distanceKm,
    required this.hourlyRate,
    required this.sessionsPerWeek,
    required this.hoursPerWeek,
    required this.postedAgo,
    required this.applicationCount,
    required this.badges,

    this.isSaved = false,

    this.status = JobStatus.none,

    this.shiftStatus = ShiftStatus.upcoming,

    this.transportRequired = false,

    this.isApplied = false,

    this.isCheckedIn = false,

    this.isCompleted = false,

    this.clientName,

    this.clientDescription,

    this.clientProfilePicture,

    this.clientEmail,

    this.clientPhone,

    this.serviceRequirements = const [],

    this.scheduleTime = '',

    this.scheduleDays = '',

    this.jobSessions = const [],
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    // ── Badges from category string ─────────────────────────────────────────
    final List<JobBadge> badges = [];
    final category = (json['category'] as String? ?? '').toLowerCase();
    if (category.contains('ndis')) badges.add(JobBadge.ndis);
    if (category.contains('aged') || category.contains('care')) {
      badges.add(JobBadge.agedCare);
    }
    if (category.contains('disab')) badges.add(JobBadge.disability);
    if (category.contains('mental')) badges.add(JobBadge.mentalHealth);
    if ((json['isUrgent'] ?? json['urgent'] ?? false) == true) {
      badges.add(JobBadge.urgent);
    }

    // ── Location object → "City, State" string ──────────────────────────────
    String locationStr = '';
    final locationObj = json['location'];
    if (locationObj is List && locationObj.isNotEmpty) {
      // viewJobDetail returns location as an array — use the first element
      final loc = locationObj.first;
      if (loc is Map) {
        final city = loc['city'] as String? ?? '';
        final state = loc['state'] as String? ?? '';
        locationStr = [city, state].where((s) => s.isNotEmpty).join(', ');
      }
    } else if (locationObj is Map) {
      final city = locationObj['city'] as String? ?? '';
      final state = locationObj['state'] as String? ?? '';
      locationStr = [city, state].where((s) => s.isNotEmpty).join(', ');
    } else if (locationObj is String) {
      locationStr = locationObj;
    }

    // ── Sessions → scheduleTime + scheduleDays ──────────────────────────────
    String scheduleTime = '';
    String scheduleDays = '';
    final sessions = json['sessions'];
    if (sessions is List && sessions.isNotEmpty) {
      final first = sessions.first as Map<String, dynamic>;
      final start = first['startTime'] as String? ?? '';
      final end = first['endTime'] as String? ?? '';
      if (start.isNotEmpty && end.isNotEmpty) {
        scheduleTime = '$start — $end';
      }
      final startDate = first['startDate'] as String? ?? '';
      final endDate = first['endDate'] as String? ?? '';
      if (startDate.isNotEmpty && endDate.isNotEmpty) {
        scheduleDays = '$startDate to $endDate';
      }
    }

    // ── serviceRequirements from jobServiceCategories ───────────────────────
    final List<String> serviceRequirements = [];
    // Add the top-level serviceRequirement string if present
    final topReq = json['serviceRequirement'] as String?;
    if (topReq != null && topReq.isNotEmpty) serviceRequirements.add(topReq);
    // Add service names from jobServiceCategories
    final cats = json['jobServiceCategories'];
    if (cats is List) {
      for (final cat in cats) {
        if (cat is Map) {
          final svc = cat['service'];
          if (svc is Map) {
            final name = svc['name'] as String?;
            if (name != null && name.isNotEmpty) serviceRequirements.add(name);
          }
          final svcCat = cat['serviceCategory'];
          if (svcCat is Map) {
            final name = svcCat['name'] as String?;
            if (name != null &&
                name.isNotEmpty &&
                !serviceRequirements.contains(name)) {
              serviceRequirements.add(name);
            }
          }
        }
      }
    }

    // ── postedAgo from createdAt ────────────────────────────────────────────
    String postedAgo = '';
    final createdAt = json['createdAt'] as String?;
    if (createdAt != null) {
      try {
        final dt = DateTime.parse(createdAt).toLocal();
        final diff = DateTime.now().difference(dt);
        if (diff.inDays >= 1) {
          postedAgo = '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
        } else if (diff.inHours >= 1) {
          postedAgo = '${diff.inHours} hr${diff.inHours == 1 ? '' : 's'} ago';
        } else {
          postedAgo = 'Just now';
        }
      } catch (_) {
        postedAgo = createdAt;
      }
    }

    // ── sessionsPerWeek from sessions count ─────────────────────────────────
    final sessionsCount = sessions is List ? sessions.length : 0;

    // ── Parse full sessions list ────────────────────────────────────────────
    final List<JobSession> jobSessions = sessions is List
        ? sessions
        .whereType<Map<String, dynamic>>()
        .map(JobSession.fromJson)
        .toList()
        : [];

    // ── hoursPerWeek from hoursPerDay ───────────────────────────────────────
    final hoursPerDay = _toDouble(json['hoursPerDay'] ?? 0);

    final jobJson = json['job'];
    return Job(
      id: (json['id'] ?? jobJson?['id'] ?? json['_id'] ?? '').toString(),
      title: json['title'] as String? ?? 'Untitled',
      company: json['company'] as String? ?? 'Nimora',
      location: locationStr,
      distanceKm: _toDouble(json['distanceKm'] ?? 0),
      hourlyRate: _toDouble(json['hourlyRate'] ?? 0),
      sessionsPerWeek: sessionsCount,
      hoursPerWeek: hoursPerDay.toInt(),
      postedAgo: postedAgo,
      applicationCount: _toInt(json['applicationCount'] ?? 0),
      badges: badges,
      clientDescription: json['description'] as String?,
      clientProfilePicture: json['clientProfilePicture'] as String?,
      clientEmail: json['clientEmail'] as String?,
      clientPhone: json['clientPhone'] as String?,
      serviceRequirements: serviceRequirements,
      scheduleTime: scheduleTime,
      scheduleDays: scheduleDays,
      jobSessions: jobSessions,
    );
  }

  static double _toDouble(dynamic v) {
    if (v is double) return v;
    if (v is int) return v.toDouble();
    if (v is String) return double.tryParse(v) ?? 0.0;
    return 0.0;
  }

  static int _toInt(dynamic v) {
    if (v is int) return v;
    if (v is double) return v.toInt();
    if (v is String) return int.tryParse(v) ?? 0;
    return 0;
  }

  Job copyWith({
    bool? isSaved,
    JobStatus? status,
    ShiftStatus? shiftStatus,
    bool? transportRequired,
    bool? isApplied,
    bool? isCheckedIn,
    bool? isCompleted,
  }) {
    return Job(
      id: id,
      title: title,
      company: company,
      location: location,
      distanceKm: distanceKm,
      hourlyRate: hourlyRate,
      sessionsPerWeek: sessionsPerWeek,
      hoursPerWeek: hoursPerWeek,
      postedAgo: postedAgo,
      applicationCount: applicationCount,
      badges: badges,
      isSaved: isSaved ?? this.isSaved,
      status: status ?? this.status,
      shiftStatus: shiftStatus ?? this.shiftStatus,
      transportRequired: transportRequired ?? this.transportRequired,
      isApplied: isApplied ?? this.isApplied,
      isCheckedIn: isCheckedIn ?? this.isCheckedIn,
      isCompleted: isCompleted ?? this.isCompleted,
      clientName: clientName,
      clientDescription: clientDescription,
      clientProfilePicture: clientProfilePicture,
      clientEmail: clientEmail,
      clientPhone: clientPhone,
      serviceRequirements: serviceRequirements,
      scheduleTime: scheduleTime,
      scheduleDays: scheduleDays,
      jobSessions: jobSessions,
    );
  }

  @override
  List<Object?> get props => [
    id,
    isSaved,
    status,
    shiftStatus,
    transportRequired,
    isApplied,
    isCheckedIn,
    isCompleted,
  ];
}
