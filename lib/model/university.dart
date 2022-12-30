class University {
  University({
    required this.alphaTwoCode,
    required this.name,
    required this.webPages,
    required this.stateProvince,
    required this.domains,
    required this.country,
  });

  final String alphaTwoCode;
  final String name;
  final List<String> webPages;
  final dynamic stateProvince;
  final List<String> domains;
  final String country;

  factory University.fromMap(Map<String, dynamic> json) => University(
    alphaTwoCode: json["alpha_two_code"] ?? '',
    name: json["name"] ?? '',
    webPages: json["web_pages"]!=null ? List<String>.from(json["web_pages"].map((x) => x)) : [],
    stateProvince: json["state-province"] ?? '',
    domains: json["domains"]!=null ? List<String>.from(json["domains"].map((x) => x)) : [],
    country: json["country"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "alpha_two_code": alphaTwoCode,
    "name": name,
    "web_pages": List<dynamic>.from(webPages.map((x) => x)),
    "state-province": stateProvince,
    "domains": List<dynamic>.from(domains.map((x) => x)),
    "country": country,
  };
}
