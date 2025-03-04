import 'package:astrologeradmin/constance/language/constant.dart';
import 'package:astrologeradmin/constance/language/language.dart';
import 'package:astrologeradmin/constance/my_colors.dart';
import 'package:astrologeradmin/constance/textstyle.dart';
import 'package:astrologeradmin/provider/language_provider.dart';
import 'package:astrologeradmin/views/login_screen.dart';
import 'package:astrologeradmin/widget/navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider

class LanguageSelectionScreen extends StatefulWidget {
  final String from;

  const LanguageSelectionScreen({Key? key, required this.from})
      : super(key: key);

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  Widget buildLanguageCard({
    required String language,
    required String subtitle,
    required String icon,
    required bool isSelected,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Wrap(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: isSelected ? lightYellow : white,
              border: Border.all(
                color: isSelected ? red : lightGrey,
                width: isSelected ? 2.0 : 1.0,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(language,
                    style: semiBoldTextStyle(fontSize: dimen17, color: black)),
                const SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(subtitle,
                        style: regularTextStyle(
                            fontSize: dimen11, color: lightText)),
                    Text(icon,
                        style: mediumTextStyle(fontSize: dimen17, color: red)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageNotifier>(
      builder: (context, languageNotifier, child) {
        languageNotifier.getLanguage();
        return Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Languages.of(context)!.pickYourPreferredLanguage,
                    style: mediumTextStyle(fontSize: dimen18, color: black),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: buildLanguageCard(
                          language: 'English',
                          subtitle: 'English',
                          icon: 'Aa',
                          isSelected:
                              languageNotifier.selectedLanguage == 'English',
                          onTap: () {
                            languageNotifier.selectLanguage(
                                'English', context, "en");

                            Navigator.pop(context);
                            if (widget.from == "intro") {
                              CustomNavigators.pushRemoveUntil(
                                  LoginView(), context);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: buildLanguageCard(
                          language: 'Hindi',
                          subtitle: 'हिंदी',
                          icon: 'आ',
                          isSelected:
                              languageNotifier.selectedLanguage == 'Hindi',
                          onTap: () {
                            languageNotifier.selectLanguage(
                                'Hindi', context, "hi");

                            Navigator.pop(context);
                            if (widget.from == "intro") {
                              CustomNavigators.pushRemoveUntil(
                                  LoginView(), context);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
