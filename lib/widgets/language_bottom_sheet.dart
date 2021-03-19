import 'package:flutter/material.dart';
import 'package:sudoku_solver/utils/utils.dart';
import 'package:sudoku_solver/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).primaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.change_language.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.transparent,
                        Colors.white,
                      ],
                      stops: [0, 0.35],
                    ).createShader(bounds);
                  },
                  child: ListView(
                    children: [
                      /// emojis from: https://emojipedia.org/flags/
                      LanguageListTile(
                        languageEmoji: '🇬🇧',
                        languageName: 'English',
                        showCheck: Utils.currentLocale(context) == Locale('en'),
                        locale: SupportedLocale.en,
                      ),
                      LanguageListTile(
                        languageEmoji: '🇸🇦',
                        languageName: 'العربية',
                        showCheck: Utils.currentLocale(context) == Locale('ar'),
                        locale: SupportedLocale.ar,
                      ),
                    ]..add(SizedBox(height: 80.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LanguageListTile extends StatelessWidget {
  const LanguageListTile({
    Key key,
    @required this.languageEmoji,
    @required this.languageName,
    @required this.showCheck,
    @required this.locale,
  }) : super(key: key);

  final String languageEmoji;
  final String languageName;
  final bool showCheck;
  final SupportedLocale locale;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        languageEmoji,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      title: Text(
        languageName,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: showCheck
          ? Icon(
              Icons.check,
              color: Colors.white,
            )
          : null,
      onTap: () async {
        Utils.changeLocale(context, locale);
        await Future.delayed(const Duration(milliseconds: 400));
        Navigator.of(context).pop();
      },
    );
  }
}
