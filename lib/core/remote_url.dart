import 'package:newsapp/utils/k_strings.dart';

class RemoteUrls {

  static const String rootUrl = "https://newsapi.org/";
  static const String baseUrl = "${rootUrl}v2/";

  static const String getHomeData = "${baseUrl}everything?q=*&apiKey=${KStrings.apiKey}";

}