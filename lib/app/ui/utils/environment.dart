import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
//   static String get fileName => kReleaseMode ? '.env.production' : '.env.development';
  static String get fileName => '.env.production';
  // static String get fileName => '.env.development';

  static String get domainName => dotenv.env['DOMAIN_NAME']!;
  static String get apiURL => dotenv.env['API_URL']!;
}
