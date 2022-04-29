import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/locator.dart';
import '../bloc/register_bloc.dart';
import '../cubit/donature_type_cubit.dart';
import '../widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<RegisterBloc>(),
        ),
        BlocProvider(
          create: (_) => DonatureTypeCubit(),
        ),
      ],
      child: LoaderOverlay(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: AppLocale.loc.registerPage,
            canBack: true,
            centerTitle: true,
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(Dimension.MEDIUM),
              children: const [RegisterForm()],
            ),
          ),
        ),
      ),
    );
  }
}
