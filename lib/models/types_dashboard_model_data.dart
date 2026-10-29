class TypesdahboardModeldata {
  final int totalTypes;
  final int totalActiveTypes;
  final int totalInactiveTypes;

  const TypesdahboardModeldata({
    required this.totalTypes,
    required this.totalActiveTypes,
    required this.totalInactiveTypes,
  });

  factory TypesdahboardModeldata.empty() {
    return TypesdahboardModeldata(
      totalTypes: 0,
      totalActiveTypes: 0,
      totalInactiveTypes: 0,
    );
  }
}
