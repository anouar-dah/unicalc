class Course {
  String name;
  double td;
  double exam;
  double coefficient;
  double credit;

  Course({
    required this.name,
    required this.td,
    required this.exam,
    required this.coefficient,
    required this.credit,
  });

  double get weightedNote => ((td * 0.4) + (exam * 0.6)) * coefficient;

  Map<String, dynamic> toJson() => {
        'name': name,
        'td': td,
        'exam': exam,
        'coefficient': coefficient,
        'credit': credit,
      };

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        name: json['name'],
        td: json['td'],
        exam: json['exam'],
        coefficient: json['coefficient'],
        credit: json['credit'],
      );
}