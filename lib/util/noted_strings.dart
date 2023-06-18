enum NotedStringDomain {
  settings,
  common,
}

// TODO: update this to use i18n.
class NotedStrings {
  static const String _unknown = 'unknown';

  static final Map<String, String> _common = {
    'confirm': 'confirm',
    'cancel': 'cancel',
  };

  static final Map<String, String> _settings = {
    'colorTitle': 'colors',
    'NotedColorSchemeName.blue': 'blue',
    'NotedColorSchemeName.green': 'green',
    'NotedColorSchemeName.dark': 'dark',
    'NotedColorSchemeName.oled': 'oled',
    'NotedColorSchemeName.light': 'light',
    'NotedColorSchemeName.custom': 'custom',
    'colorDefault': 'default color',
    'fontTitle': 'fonts',
    'NotedTextThemeName.poppins': 'poppins',
    'NotedTextThemeName.roboto': 'roboto',
    'NotedTextThemeName.lora': 'lora',
    'NotedTextThemeName.vollkorn': 'vollkorn',
  };

  static String getString(NotedStringDomain domain, String key) {
    return switch (domain) {
      NotedStringDomain.common => _common[key] ?? _unknown,
      NotedStringDomain.settings => _settings[key] ?? _unknown,
    };
  }
}
