import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/static/enums.dart' as e;
import '../../../../core/static/enums.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/locator.dart';
import '../bloc/create/campaign_create_bloc.dart';
import '../bloc/step/campaign_step_bloc.dart';
import '../widgets/campaign_create_step.dart';
import 'forms/advertisement_form_page.dart';
import 'forms/event_form_page.dart';
import 'forms/fund_target_form_page.dart';
import 'forms/patient_form_page.dart';
import 'forms/personal_data_form_page.dart';
import 'forms/prepare_form_page.dart';
import 'forms/recipient_form_page.dart';
import 'package:pundi_kita/core/routes/path.dart' as path;

class CampaignCreatePageRouteArguments {
  final e.CampaignType type;
  final int typeId;
  final int? categoryId;
  final int? subCategoryId;
  CampaignCreatePageRouteArguments({
    required this.type,
    required this.typeId,
    this.categoryId,
    this.subCategoryId,
  });
}

class CampaignCreatePage extends StatefulWidget {
  final e.CampaignType type;
  final int typeId;
  final int? categoryId;
  final int? subCategoryId;
  const CampaignCreatePage({
    Key? key,
    required this.type,
    required this.typeId,
    this.categoryId,
    this.subCategoryId,
  }) : super(key: key);

  @override
  State<CampaignCreatePage> createState() => _CampaignCreatePageState();
}

class _CampaignCreatePageState extends State<CampaignCreatePage> {
  Map<String, dynamic> get initialMapValue => {
        'campaign_type_id': widget.typeId,
        if (widget.categoryId != null) 'campaign_category_id': widget.categoryId,
        if (widget.subCategoryId != null) 'campaign_sub_category_id': widget.subCategoryId,
      };
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CampaignStepBloc()..add(InitialSteps(type: widget.type)),
        ),
        BlocProvider(
          create: (context) => locator<CampaignCreateBloc>()..add(UpdateBody(body: initialMapValue)),
        )
      ],
      child: LoaderOverlay(
        child: Scaffold(
          appBar: const CustomAppBar(
            title: "Buat Galang Dana",
            canBack: true,
          ),
          body: SafeArea(
            child: Column(
              children: [
                const CampaignCreateStep(),
                BlocListener<CampaignCreateBloc, CampaignCreateState>(
                  listener: (context, state) {
                    if (state is CampaignCreatePrepare) {
                      logMe(state.body);
                    } else if (state is CampaignCreateLoading) {
                      context.loaderOverlay.show();
                    } else if (state is CampaignCreateSuccess) {
                      context.loaderOverlay.hide();
                      Fluttertoast.showToast(msg: 'Galang Dana berhasil dibuat');
                      Navigator.pushNamedAndRemoveUntil(context, path.MAIN, (route) => false);
                    } else if (state is CampaignCreateFailure) {
                      context.loaderOverlay.hide();
                      if (state.failure is RequestFailure) {
                        final msg = (state.failure as RequestFailure).message;
                        Fluttertoast.showToast(msg: msg);
                      } else {
                        Fluttertoast.showToast(msg: 'Galang Dana gagal dibuat');
                      }
                    }
                  },
                  child: Expanded(
                    child: BlocBuilder<CampaignStepBloc, CampaignStepState>(
                      builder: (context, state) {
                        final _step = state.currentStep;
                        switch (_step) {
                          case CampaignStep.prepare:
                            return const PrepareFormPage();
                          case CampaignStep.patient:
                            return const PatientFormPage();
                          case CampaignStep.personalData:
                            return const PersonalDataFormPage();
                          case CampaignStep.fundTarget:
                            return const FundTargetFormPage();
                          case CampaignStep.recipient:
                            return const RecipientFormPage();
                          case CampaignStep.advertisement:
                            return const AdvertisementFormPage();
                          case CampaignStep.event:
                            return const EventFormPage();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
