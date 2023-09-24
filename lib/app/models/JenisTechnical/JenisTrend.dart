class JenisTrend {
  final String value;
  final String label;

  JenisTrend({required this.value, required this.label});

  List<JenisTrend> JenisTrends = [
    JenisTrend(value: '>', label: 'More Than'),
    JenisTrend(value: '<', label: 'Less Than'),
  ];
}
