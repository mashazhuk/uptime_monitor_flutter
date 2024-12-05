class AllSite {
  String? name, domain, lastCheck, lastStatusResponse, uptime;
  int? precentage, lastStatusCode;
  bool? isChecked;

  AllSite({this.name, this.domain, this.lastCheck, this.lastStatusCode, this.lastStatusResponse, this.uptime, this.precentage, this.isChecked});

  AllSite.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    domain = json['domain'];
    var latestCheck = json['root_endpoint']?['latest_check'];
    lastCheck = latestCheck?['created_at']?['date_time'];
    lastStatusCode = latestCheck?['response_code'];
    lastStatusResponse = latestCheck?['status_text'];
    precentage = json['root_endpoint']?['uptime_percentage_1day'];
    uptime = "100%";
    isChecked = latestCheck?['is_successful'] ?? false;
  }
}