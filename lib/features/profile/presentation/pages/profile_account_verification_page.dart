import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pundi_kita/core/static/colors.dart';
import 'package:pundi_kita/core/static/dimens.dart';
import 'package:pundi_kita/core/utility/helper.dart';

import '../../../../core/presentation/pages/loading_page.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/static/enums.dart';
import '../../../../core/utility/locator.dart';
import '../../../register/presentation/widgets/additional_forms/foundation_form.dart';
import '../../../register/presentation/widgets/additional_forms/personal_form.dart';
import '../bloc/profile_bloc.dart';

class ProfileAccountVerificationPage extends StatelessWidget {
  const ProfileAccountVerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: BlocProvider(
        create: (context) => locator<ProfileBloc>()..add(FetchProfile()),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(
            canBack: true,
            title: 'Form Verifikasi Akun',
            backgroundColor: Colors.white,
          ),
          body: SafeArea(
            child: BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileUpdating) {
                  context.loaderOverlay.show();
                } else {
                  context.loaderOverlay.hide();
                  if (state is ProfileUpdated) {
                    Fluttertoast.showToast(msg: 'Data berhasil disimpan. Silahkan menunggu untuk proses verifikasi.');
                    Navigator.pop(context);
                  }
                }
              },
              builder: (context, state) {
                if (state is ProfileLoaded) {
                  final _user = state.data;
                  if (_user.donatureType == DonatureType.personal) {
                    return const FormContainer(child: PersonalForm());
                  } else {
                    return const FormContainer(child: FoundationForm());
                  }
                }
                return const LoadingPage(isList: true);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class FormContainer extends StatefulWidget {
  final Widget child;
  const FormContainer({Key? key, required this.child}) : super(key: key);

  @override
  State<FormContainer> createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(Dimension.MEDIUM),
        children: [
          widget.child,
          mediumVerticalSpacing(),
          RoundedButton(
            title: 'Simpan',
            onTap: () async {
              if (_formKey.currentState!.validate()) {}
              // context.read<ProfileBloc>().add(SubmitUpdate(data: await generatedFormData()));
            },
          )
        ],
      ),
    );
  }
}
