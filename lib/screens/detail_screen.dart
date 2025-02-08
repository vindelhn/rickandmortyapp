import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:rickandmortyapp/models/character.dart';

import '../resources/app_colors.dart';
import '../widgets/dotted_panel.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Character character =
        ModalRoute.of(context)!.settings.arguments as Character;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(character.image),
        SliverList(
          delegate: SliverChildListDelegate([
            Column(
              children: [
                SizedBox(
                  height: 58,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: DottedPanel(
                        valueColor: AppColors.palette3,
                        title: 'Name',
                        value: character.name.toUpperCase(),
                        alignment: MainAxisAlignment.center),
                  ),
                ),
                SizedBox(
                  height: 58,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: DottedPanel(
                            valueColor: AppColors.palette3,
                            title: 'Species',
                            value: character.species.toUpperCase(),
                            alignment: MainAxisAlignment.center,
                          ),
                        ),
                      ),
                       Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: DottedPanel(
                              valueColor: AppColors.palette3,
                              title: 'Gender',
                              value: character.gender.toUpperCase(),
                              alignment: MainAxisAlignment.center),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 58,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: DottedPanel(
                        valueColor: AppColors.palette3,
                        title: 'Status',
                        value: character.status.toUpperCase(),
                        alignment: MainAxisAlignment.center),
                  ),
                ),
                SizedBox(
                  height: 58,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: DottedPanel(
                        valueColor: AppColors.palette3,
                        title: 'Origin',
                        value: character.originName.toUpperCase(),
                        alignment: MainAxisAlignment.center),
                  ),
                ),
                SizedBox(
                  height: 58,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: DottedPanel(
                        valueColor: AppColors.palette3,
                        title: 'Location',
                        value: character.currentLocationName.toUpperCase(),
                        alignment: MainAxisAlignment.center),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ],
    ));
  }
}

class _CustomAppBar extends StatefulWidget {
  final String imageUrl;

  const _CustomAppBar(this.imageUrl);

  @override
  State<_CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<_CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: [],
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      expandedHeight: 500,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          background: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.40),
                            BlendMode.multiply,
                          ),
                          image: imageProvider,
                          fit: BoxFit.cover
                          //    colorFilter: ColorFilter.mode(Colors.red, BlendMode.dstOver)
                          ),
                    ),
                  ),
              placeholder: (context, url) =>
                  const SpinKitFadingCircle(color: Colors.green, size: 50),
              errorWidget: (context, url, error) => const Icon(
                  Icons.image_not_supported,
                  size: 80,
                  color: Colors.grey))),
    );
  }
}
