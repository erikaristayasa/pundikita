import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/domain/entities/user_entity.dart';
import '../../../../core/presentation/blocs/image_picker/image_picker_bloc.dart';
import '../../../../core/presentation/pages/loading_page.dart';
import '../../../../core/presentation/widgets/bottom_sheet_image_source.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/presentation/widgets/custom_birthdate_input.dart';
import '../../../../core/presentation/widgets/custom_text_area.dart';
import '../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/locator.dart';
import '../bloc/profile_bloc.dart';
import '../widgets/profile_photo_container.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({Key? key}) : super(key: key);

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  final _imagePicker = ImagePicker();
  XFile? _file;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  prepareControllerValue(User user) {
    final _user = user;

    _nameController.text = _user.name ?? '';
    _emailController.text = _user.email ?? '';
    _phoneController.text = _user.phone ?? '';
    _birthDateController.text = _user.birthDate?.toText() ?? '';
    _bioController.text = _user.biodata ?? '';
  }

  Future<FormData> generatedFormData() async {
    return FormData.fromMap({
      'nama': _nameController.text,
      'telepon': _phoneController.text,
      'tanggal_lahir': _birthDateController.text,
      'biodata': _bioController.text,
      if (_file != null) 'foto': await MultipartFile.fromFile(_file!.path, filename: _file!.name)
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => locator<ProfileBloc>()..add(FetchProfile()),
          ),
          BlocProvider(
            create: (context) => ImagePickerBloc(),
            child: Container(),
          )
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: AppLocale.loc.updateProfile,
            canBack: true,
          ),
          body: MultiBlocListener(
            listeners: [
              BlocListener<ImagePickerBloc, ImagePickerState>(
                listener: (context, state) {
                  if (state is ImagePickerLoaded) {
                    _file = state.file;
                    logMe(_file);
                  } else {
                    _file = null;
                  }
                },
              ),
              BlocListener<ProfileBloc, ProfileState>(
                listener: (context, state) {
                  if (state is ProfileLoaded) {
                    prepareControllerValue(state.data);
                  } else if (state is ProfileUpdating) {
                    context.loaderOverlay.show();
                  } else if (state is ProfileUpdated) {
                    context.loaderOverlay.hide();
                    Fluttertoast.showToast(msg: 'Profil berhasil diperbaharui.');
                    context.read<ProfileBloc>().add(FetchProfile());
                  }
                },
              )
            ],
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoaded) {
                  final _user = state.data;
                  return ListView(
                    padding: const EdgeInsets.all(Dimension.MEDIUM),
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: Dimension.MEDIUM),
                        height: 130,
                        child: Center(
                          child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
                            builder: (context, state) {
                              XFile? _file;
                              if (state is ImagePickerLoaded) {
                                _file = state.file;
                              }
                              return AspectRatio(
                                aspectRatio: 1 / 1,
                                child: InkWell(
                                  onTap: () async {
                                    await showModalBottomSheet(
                                      context: context,
                                      builder: (ctx) => BottomSheetImageSource(
                                        selectCamera: () async {
                                          Navigator.pop(context);
                                          context.read<ImagePickerBloc>().add(PickingImage(
                                                context: context,
                                                imagePicker: _imagePicker,
                                                imageSource: ImageSource.camera,
                                              ));
                                        },
                                        selectGallery: () async {
                                          Navigator.pop(context);
                                          context.read<ImagePickerBloc>().add(PickingImage(
                                                context: context,
                                                imagePicker: _imagePicker,
                                                imageSource: ImageSource.gallery,
                                              ));
                                        },
                                      ),
                                    );
                                  },
                                  child: ProfilePhotoContainer(
                                    file: _file != null ? FileImage(File(_file.path)) : null,
                                    network: _user.photo != null ? NetworkImage(getUserImageUrl(_user.photo!)) : null,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      largeVerticalSpacing(),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              title: 'Nama Lengkap',
                              placeholder: 'Nama Lengkap',
                              inputType: TextInputType.name,
                              controller: _nameController,
                            ),
                            mediumVerticalSpacing(),
                            CustomTextField(
                              enabled: false,
                              title: 'Email',
                              placeholder: 'Email',
                              inputType: TextInputType.emailAddress,
                              controller: _emailController,
                            ),
                            mediumVerticalSpacing(),
                            CustomTextField(
                              title: 'Nomor Telepon',
                              placeholder: 'Nomor Telepon',
                              inputType: TextInputType.phone,
                              controller: _phoneController,
                            ),
                            mediumVerticalSpacing(),
                            CustomBirthDateInput(
                              birthDate: _user.birthDate,
                              controller: _birthDateController,
                            ),
                            mediumVerticalSpacing(),
                            CustomTextArea(
                              title: 'Bio Singkat',
                              controller: _bioController,
                              fieldValidator: (_) => null,
                            ),
                            largeVerticalSpacing(),
                            RoundedButton(
                              title: 'Simpan',
                              onTap: () async {
                                context.read<ProfileBloc>().add(SubmitUpdate(data: await generatedFormData()));
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  );
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
