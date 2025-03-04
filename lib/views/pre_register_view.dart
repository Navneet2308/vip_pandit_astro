import 'package:astrologeradmin/constance/language/language.dart';
import 'package:astrologeradmin/constance/my_colors.dart';
import 'package:astrologeradmin/constance/textstyle.dart';
import 'package:astrologeradmin/utils/ui_utils.dart';
import 'package:astrologeradmin/views/register_success_screen.dart';
import 'package:astrologeradmin/widget/global_button.dart';
import 'package:astrologeradmin/widget/navigators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constance/common_Widget.dart';
import '../model/quiz_response.dart';
import '../provider/auth_provider.dart';

class PreRegisterView extends StatelessWidget {
  const PreRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.fetchQuiz();
    });
    return Consumer<AuthProvider>(builder: (context, provider, child)
    {
     return Scaffold(
       backgroundColor:bg,
        appBar: PreferredSize(preferredSize: Size.zero, child: AppBar()),
        body: SingleChildScrollView(
          child: Column(
            children: [
              UiUtils.topHeaderUi(context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      Languages.of(context)!.preRegistrationScreeningQuiz,
                      style:
                          mediumTextStyle(fontSize: dimen22, color: colBlack),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      Languages.of(context)!.astrologerNeedToComplete,
                      style:
                          regularTextStyle(fontSize: dimen13, color: colHint),
                    ),
                  ),
                  const SizedBox(height: 25),

          provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: provider.quizList.length,
            itemBuilder: (context, index) {
              return mainQuizUI(context, provider.quizList[index], index,provider);
            },
          ),





          // mainQuizUI(context);
                ],
              ),
              Container(
                color: white,
                child: Wrap(
                  children: [
                    const SizedBox(height: 20),
                    buildDatePickerField(
                      context,
                      "Suggest Time for interview",
                      "YYYY-MM-DD",
                      provider.updateDoi,
                      // Callback to update the selected date
                      provider.doi, // Current selected date value
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 15, right: 5),
                      child: Text(
                        Languages.of(context)!.beforeStartUsingThisPlatform,
                        style: regularTextStyle(fontSize: dimen13, color: lightGrey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 30),
                      child: GlobalButton(
                          "${Languages.of(context)!.registerAccount}", colSecondary, colSecondary, () {
                        provider.saveQuiz(context);
                      }, 10, 0, semiBoldTextStyle(fontSize: 16.0, color: colWhite),
                          btn50),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: regularTextStyle(fontSize: 13.0, color: lightText),
                          children: [
                             TextSpan(text: "${Languages.of(context)!.bySigningUpYouAgree}"),
                            TextSpan(
                              text: "${Languages.of(context)!.termsAndConditions}",
                              style: regularTextStyle(
                                  fontSize: 13.0, color: secondaryTextColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Navigate to Terms & Conditions screen
                                },
                            ),
                            TextSpan(
                                text: "${Languages.of(context)!.and}",
                                style: regularTextStyle(
                                    fontSize: 13.0, color: lightText)),
                            TextSpan(
                              text: "${Languages.of(context)!.privacyPolicy}",
                              style: regularTextStyle(
                                  fontSize: 13.0, color: secondaryTextColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Navigate to Privacy Policy screen
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget quizUi(BuildContext context, String option, String correctAnswer, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 5, bottom: 2),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? colSecondary : startDefault),
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? colSecondary.withOpacity(0.2) : Colors.transparent,
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: option == correctAnswer ? colCheckGreen : Colors.grey,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              option,
              style: regularTextStyle(
                fontSize: dimen14,
                color: colBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget mainQuizUI(BuildContext context, AstrologyQuiz as_quiz, int index,AuthProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            as_quiz.question ?? '',
            style: regularTextStyle(fontSize: dimen15, color: colBlack),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 200), // Constrain height
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 3,
              ),
              itemCount: 4, // Assuming 4 options
              itemBuilder: (context, gridIndex) {
                String option;
                switch (gridIndex) {
                  case 0:
                    option = as_quiz.option1 ?? '';
                    break;
                  case 1:
                    option = as_quiz.option2 ?? '';
                    break;
                  case 2:
                    option = as_quiz.option3 ?? '';
                    break;
                  case 3:
                    option = as_quiz.option4 ?? '';
                    break;
                  default:
                    option = '';
                }

                return InkWell(
                  onTap: (){
                    provider.updateAnswer(index, option);

                  },
                  child: quizUi(
                    context,
                    option,
                    as_quiz.answer ?? '', // Dynamic comparison
                    isSelected: false, // You can update this based on user interaction
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

}
