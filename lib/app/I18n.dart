import 'package:patta/app/log.dart';
import 'package:patta/app/preferences.dart';
import 'package:patta/model/Language.dart';

class I18n {
  static var _selectedLanguage;

  static Future<Language> init() async {
    _selectedLanguage = Preferences.getLanguage(Language.SETTINGS_KEY);
    log2("I18n.init selected language: $_selectedLanguage");
    return _selectedLanguage;
  }

  static void initFirstRun() {
    Preferences.setLanguage(Language.SETTINGS_KEY, Language.eng);
  }

  static void set(Language language) {
    _selectedLanguage = language;
    log2("I18n.set selected language: $_selectedLanguage");
  }

  static String get(String key) {
    var value = strings[_selectedLanguage]![key];
    return validString(value) ? value : strings[Language.eng]![key];
  }

  static bool validString(value) => value != null && value != "";

  static String getForced(Language lang, String key) {
    log2("I18n.getForced selected language: $lang");
    return strings[lang]![key];
  }

  static const Map<Language, Map<String, String>> strings = {
    Language.eng: {
      "about_pariyatti": "About Pariyatti",
      "account": "Account",
      "app_name": "Pariyatti",
      "bookmarks": "Bookmarks",
      "contact_pariyatti": "Contact Pariyatti",
      "could_not_launch": "Could not launch",
      "dark_theme": "Dark Theme",
      "dhamma_verse": "Daily Dhamma Verse from S.N. Goenka",
      "dhamma_verse_short": "Daily Dhamma Verse",
      "donate": "Donate",
      "donate_preamble": "Pariyatti is an independent USA 501(c)(3) non-profit organization and is not part of the Vipassana organization. Pariyatti relies on a combination of sales revenue and donations to offer its services. All donations are tax-deductible in accordance with US tax law.\n\nIf you would like to have your donation be matched by your employer, request it for Pariyatti (EIN 80-0038336).",
      "donate_time": "Donate Time",
      "donate_time_preamble": "Pariyatti relies on the vibrant participation of our supporters to continue our service programs. Volunteers are welcome to contribute to the Pariyatti mobile app or a variety of other Pariyatti projects.\n\nThe mobile app team is currently seeking non-technical volunteers with skills in translation from English and Pāli. We are also seeking technical volunteers with skills in Flutter, Clojure, Rails, Docker, and Terraform.\n\nTo learn about Pariyatti's other volunteer needs, please click the button below.",
      "empty_card": "Empty Card",
      "error": "Error",
      "feeds": "Feeds",
      "inspiration": "Inspiration",
      "language": "Language",
      "language_alternate": "Alternate",
      "languages": "Languages",
      "light_theme": "Light Theme",
      "logs": "Logs",
      "logs_empty": "No logs available",
      "logs_clear": "Clear Logs",
      "nothing_bookmarked": "You haven't bookmarked anything yet",
      "only_english": "Only English is available as an Alternate Language at this time.",
      "pali_word": "Pāli Word",
      "pali_word_of_the_day": "Pāli Word of the Day",
      "security_and_privacy": "Security and Privacy",
      "settings": "Settings",
      "share_dhamma_verse": "Share Dhamma Verse",
      "share_inspiration": "Share Inspiration",
      "share_pali_word": "Share Pāli Word",
      "share_words_of_buddha": "Share Words of the Buddha",
      "subscribe_to_newsletter": "Subscribe to Newsletter",
      "system_default": "System Default",
      "theme": "Theme",
      "today": "Today",
      "translation": "Translation",
      "try_again_later": "An error occurred. Please try again later.",
      "was_empty": "was empty",
      "words_of_the_buddha": "Daily Words of the Buddha",
    },
  };
} 