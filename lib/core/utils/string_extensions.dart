String getPostedAgo(String? createdAt) {
  if (createdAt == null || createdAt.isEmpty) {
    return '';
  }

  final postedDate = DateTime.parse(createdAt).toLocal();
  final difference = DateTime.now().difference(postedDate);

  if (difference.inDays > 0) {
    return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
  }

  if (difference.inHours > 0) {
    return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
  }

  if (difference.inMinutes > 0) {
    return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
  }

  return 'Just now';
}