class AllSite {
  final String? name, domain, lastCheck, lastStatus, uptime;

  AllSite({this.name, this.domain, this.lastCheck, this.lastStatus, this.uptime});
}

List demoAllSites = [
  AllSite(
    name: "svgIcon",
    domain: "www.google.com",
    lastCheck: "01-03-2021",
    lastStatus: "200 Ok",
    uptime: "100%",
  ),
  AllSite(
    name: "laravel.com",
    domain: "https://laravel.com",
    lastCheck: "27-02-2021",
    lastStatus: "500 Error",
    uptime: "90%",
  ),
  AllSite(
    name: "something",
    domain: "www.google.com",
    lastCheck: "23-02-2021",
    lastStatus: "200 Ok",
    uptime: "100%",
  ),
];
