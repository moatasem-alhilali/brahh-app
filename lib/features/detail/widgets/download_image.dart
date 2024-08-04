// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:active_ecommerce_flutter/core/failure/request_state.dart';
import 'package:active_ecommerce_flutter/core/services/service_locator.dart';
import 'package:active_ecommerce_flutter/custom/box_decorations.dart';
import 'package:active_ecommerce_flutter/features/home/presentation/bloc/home_bloc.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';

class DownloadImageProduct extends StatelessWidget {
  const DownloadImageProduct({
    Key? key,
   required this.name,
  required  this.url,
  }) : super(key: key);
  final String name;
  final String url;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(
        homeRepositoryImp: getIt.get(),
      ),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch (state.downloadState) {
            case RState.defaults:
              return InkWell(
                onTap: () {
                  context.read<HomeBloc>().add(DownloadImageEvent(url, name));
                },
                child: Container(
                  decoration: BoxDecorations.buildCircularButtonDecoration_1(),
                  width: 36,
                  height: 36,
                  child: Center(
                    child: Icon(
                      Icons.downloading_rounded,
                      color: MyTheme.dark_font_grey,
                      size: 20,
                    ),
                  ),
                ),
              );
            case RState.loading:
              return Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecorations.buildCircularButtonDecoration_1(),
                width: 36,
                height: 36,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case RState.error:
              return Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecorations.buildCircularButtonDecoration_1(),
                width: 36,
                height: 36,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );

            case RState.success:
              return SizedBox();
          }
        },
      ),
    );
  }
}
