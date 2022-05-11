import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/user_entity.dart';
import '../../../../core/presentation/cubits/user_info_cubit.dart';
import '../../../../core/presentation/pages/loading_page.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/presentation/widgets/simple_alert_dialog.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/dimens.dart';
import '../../../../core/static/enums.dart' as e;
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/locator.dart';
import '../bloc/type/campaign_type_bloc.dart';
import '../widgets/campaign_type_item.dart';
import 'campaign_category_list_page.dart';
import 'campaign_create_page.dart';

class CampaignTypeListPage extends StatelessWidget {
  const CampaignTypeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserInfoCubit, User?>(
      bloc: locator<UserInfoCubit>()..getData(),
      listener: (context, state) async {
        if (state != null) {
          if (!state.campaignStatus) {
            await Future.delayed(const Duration(milliseconds: 1300), () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => SimpleAlertDialog(
                  title: AppLocale.loc.failure,
                  message: 'Maaf, akun Anda belum bisa untuk membuat Galang Dana.',
                ),
              );
            });
          }
        }
      },
      builder: (context, state) {
        if (state != null && state.campaignStatus) {
          return BlocProvider(
            create: (context) => locator<CampaignTypeBloc>()..add(GetData()),
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: CustomAppBar(
                title: AppLocale.loc.raiseFunds,
                canBack: true,
              ),
              body: SafeArea(
                child: BlocBuilder<CampaignTypeBloc, CampaignTypeState>(
                  builder: (context, state) {
                    if (state is CampaignTypeLoaded) {
                      final _data = state.data;
                      return ListView.separated(
                        padding: const EdgeInsets.all(Dimension.MEDIUM),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => CampaignTypeItem(
                          type: _data.elementAt(index),
                          onTap: () {
                            if (index != 0) {
                              Navigator.pushNamed(
                                context,
                                path.CAMPAIGN_CATEGORY,
                                arguments: CampaignCategoryListPageRouteArguments(
                                  type: _data.elementAt(index),
                                ),
                              );
                            } else {
                              Navigator.pushNamed(
                                context,
                                path.CAMPAIGN_CREATE,
                                arguments: CampaignCreatePageRouteArguments(
                                  type: e.CampaignType.sick,
                                  typeId: _data.elementAt(index).id,
                                ),
                              );
                            }
                          },
                        ),
                        separatorBuilder: (_, __) => largeVerticalSpacing(),
                        itemCount: _data.length,
                      );
                    } else if (state is CampaignTypeLoading) {
                      return const LoadingPage(isList: true);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          );
        }

        return const LoadingPage(isList: true);
      },
    );
  }
}
