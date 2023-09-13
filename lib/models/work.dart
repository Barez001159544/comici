class Work {
  late String? occupation;
  late String? base;

  Work(
      this.occupation,
    this.base,
  );

  Work.fromJson(Map<String, dynamic> json) {
    occupation = json["occupation"];
    base = json["base"];
  }

}