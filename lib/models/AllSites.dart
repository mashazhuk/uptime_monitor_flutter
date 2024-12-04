class AllSite {
  String? name, domain, lastCheck, lastStatusResponse, uptime;
  int? precentage,lastStatusCode;

  AllSite({this.name, this.domain, this.lastCheck, this.lastStatusCode, this.lastStatusResponse, this.uptime, this.precentage});

  AllSite.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    domain = json['domain'];
    lastCheck = json['root_endpoint.latest_check.created_at.date_time'];
    lastStatusCode = json['root_endpoint.latest_check.response_code'];
    lastStatusResponse = json['root_endpoint.latest_check.status_text'];
    precentage = json['root_endpoint.uptime_percentage_1day'];
    uptime = "100%";
  }
}
//
//
// List demoAllSites = [
//   AllSite(
//     name: "svgIcon",
//     domain: "www.google.com",
//     lastCheck: "01-03-2021",
//     lastStatus: "200 Ok",
//     uptime: "100%",
//     precentage: 100,
//   ),
//   AllSite(
//     name: "laravel.com",
//     domain: "https://laravel.com",
//     lastCheck: "27-02-2021",
//     lastStatus: "500 Error",
//     uptime: "90%",
//     precentage: 90
//   ),
//   AllSite(
//     name: "something",
//     domain: "www.google.com",
//     lastCheck: "23-02-2021",
//     lastStatus: "200 Ok",
//     uptime: "100%",
//       precentage: 80
//   ),
//   AllSite(
//     name: "something",
//     domain: "www.google.com",
//     lastCheck: "23-02-2021",
//     lastStatus: "200 Ok",
//     uptime: "100%",
//       precentage: 90
//   ),
// ];
