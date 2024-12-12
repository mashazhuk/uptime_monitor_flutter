class AllSite {
  String? name, domain, lastCheck, lastStatusResponse, uptime;
  int? percentage, lastStatusCode, id;
  bool? isChecked;
  Map<DateTime, double>? responseTimes;

  AllSite({
    this.id,
    this.name,
    this.domain,
    this.lastCheck,
    this.lastStatusCode,
    this.lastStatusResponse,
    this.uptime,
    this.percentage,
    this.isChecked,
    this.responseTimes,
  });

  AllSite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    domain = json['domain'];

    var latestCheck = json['root_endpoint']?['latest_check'];
    lastCheck = latestCheck?['created_at']?['date_time'];
    lastStatusCode = latestCheck?['response_code'];
    lastStatusResponse = latestCheck?['status_text'];
    percentage = json['root_endpoint']?['uptime_percentage_1day'];
    uptime = "100%";
    isChecked = latestCheck?['is_successful'] ?? false;
  }
}
