import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pundi_kita/core/static/dimens.dart';
import 'package:pundi_kita/core/static/extensions.dart';

import '../../../../core/presentation/blocs/image_picker/image_picker_bloc.dart';
import '../../../../core/presentation/widgets/bottom_sheet_image_source.dart';
import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/utility/helper.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImagePickerBloc(),
      child: BlocConsumer<ImagePickerBloc, ImagePickerState>(
        listener: (context, state) {
          if (state is ImagePickerLoaded) {
            _file = state.file;
          } else {
            _file = null;
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
            RoundedContainer(
              color: Colors.grey[200]!,
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: Dimension.MEDIUM),
              child: Row(
                children: [
                  Expanded(child: Text(_file?.name ?? 'Belum dipilih')),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
