import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pundi_kita/core/presentation/widgets/custom_text_field.dart';
import 'package:pundi_kita/core/static/dimens.dart';
import 'package:pundi_kita/core/static/extensions.dart';

import '../../../../core/presentation/blocs/image_picker/image_picker_bloc.dart';
import '../../../../core/presentation/blocs/text_controller/text_controller_bloc.dart';
import '../../../../core/presentation/widgets/bottom_sheet_image_source.dart';
import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/locator.dart';
import '../../../../core/utility/validation_helper.dart';

class RegisterPhotoFilePicker extends StatefulWidget {
  final String title;
  final Function(XFile? file) onPicked;
  const RegisterPhotoFilePicker({Key? key, required this.onPicked, required this.title}) : super(key: key);

  @override
  State<RegisterPhotoFilePicker> createState() => _RegisterPhotoFilePickerState();
}

class _RegisterPhotoFilePickerState extends State<RegisterPhotoFilePicker> {
  final _imagePicker = ImagePicker();
  XFile? _file;
  final _controller = TextEditingController();
  late OutlineInputBorder normalBorder;
  late OutlineInputBorder errorBorder;

  @override
  void initState() {
    super.initState();
    normalBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(
        color: Colors.white,
      ),
    );
    errorBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ImagePickerBloc(),
        ),
        BlocProvider(
          create: (_) => locator<TextControllerBloc>(),
        ),
      ],
      child: BlocConsumer<ImagePickerBloc, ImagePickerState>(
        listener: (context, state) {
          if (state is ImagePickerLoaded) {
            _file = state.file;
            _controller.text = state.file?.name ?? '';
          } else {
            _file = null;
            _controller.text = '';
          }
          widget.onPicked(_file);
        },
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: context.textTheme().titleSmall,
            ),
            smallVerticalSpacing(),
            BlocBuilder<TextControllerBloc, TextControllerState>(
              builder: (context, state) {
                final bloc = context.read<TextControllerBloc>();
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                          enabled: false,
                          controller: _controller,
                          style: context.textTheme().bodyMedium,
                          decoration: InputDecoration(
                            focusColor: Colors.white,
                            border: InputBorder.none,
                            hintText: _file?.name ?? 'Belum dipilih',
                            enabledBorder: normalBorder,
                            disabledBorder: normalBorder,
                            focusedBorder: normalBorder,
                            errorBorder: errorBorder,
                            focusedErrorBorder: errorBorder,
                            filled: true,
                            fillColor: state.error ? Colors.red : Colors.grey[200],
                            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            errorStyle: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          validator: ValidationHelper(
                            isError: (error) => bloc.add(TextControllerOnError(error)),
                            typeField: TypeField.none,
                          ).validate()),
                    ),
                    TextButton(
                      onPressed: () async {
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
                      child: const Text('Pilih'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
