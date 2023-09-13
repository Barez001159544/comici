class Imagee{
  String? url;
  Imagee(
      this.url,
      );

  Imagee.fromJson(Map<String, dynamic> json) {
    url = json["url"];
  }
}