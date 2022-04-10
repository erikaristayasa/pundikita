import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/custom_label.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../cubit/campaign_story/campaign_story_cubit.dart';

class CampaignStory extends StatelessWidget {
  const CampaignStory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CampaignStoryCubit(),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(Dimension.MEDIUM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomLabel(title: AppLocale.loc.story),
            mediumVerticalSpacing(),
            BlocBuilder<CampaignStoryCubit, CampaignStoryState>(
              builder: (context, state) {
                final _isShrink = (state is CampaignStoryShrinked);
                return SizedBox(
                  // height: _isShrink ? 150 : null,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          // Story text
                          Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                            style: context.textTheme().bodyMedium,
                            maxLines: _isShrink ? 5 : null,
                            overflow: TextOverflow.fade,
                          ),

                          // Gradient
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                gradient: _isShrink
                                    ? LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.white.withOpacity(0.5),
                                          Colors.white,
                                        ],
                                        stops: const [0, 1.0],
                                      )
                                    : null,
                              ),
                            ),
                          )
                        ],
                      ),

                      // Expand button
                      Center(
                        child: RoundedButton(
                          radius: 13,
                          onTap: () {
                            if (_isShrink) {
                              context.read<CampaignStoryCubit>().expand();
                            } else {
                              context.read<CampaignStoryCubit>().shrink();
                            }
                          },
                          height: 26,
                          width: 0.0,
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _isShrink ? 'Baca selengkapnya' : 'Baca lebih ringkas',
                                style: context.textTheme().labelSmall!.withColor(Colors.white),
                              ),
                              smallHorizontalSpacing(),
                              Icon(_isShrink ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded),
                            ],
                          ),
                          color: AppColors.SECONDARY,
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
