import 'package:flutter/material.dart';
import 'package:training/data/models/training.dart';
import 'package:training/presentation/common/app_theme.dart';
import 'package:training/presentation/common/ui_string.dart';

class TrainingDetailPage extends StatelessWidget {
  static const _badgeImage = "assets/images/badge.jpeg";

  final Training training;
  const TrainingDetailPage({super.key, required this.training});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _enrollNowButton(),
      body: CustomScrollView(
        slivers: [
          _sliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    training.description,
                    style: TextStyle(
                      color: AppTheme.black.withOpacity(.5),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 20),
                  _dateTimeAndLocation(),
                  const Divider(),
                  const SizedBox(height: 10),
                  _trainingDetail(),
                  const Divider(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _enrollNowButton() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.sunburntCyclops,
        borderRadius: BorderRadius.circular(2),
      ),
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: const Center(
        child: Text(
          UIString.enrolNow,
          style: TextStyle(
            color: AppTheme.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Column _trainingDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        _trainerDetail(),
        const SizedBox(height: 10),
      ],
    );
  }

  Row _trainerDetail() {
    return Row(
      children: [
        SizedBox(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(training.trainerImage),
                minRadius: 40,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.white,
                ),
                child: const CircleAvatar(
                  backgroundImage: AssetImage(_badgeImage),
                  minRadius: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              training.trainerRole,
              style: const TextStyle(
                color: AppTheme.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              training.trainerName,
              style: TextStyle(
                color: AppTheme.black.withOpacity(0.5),
                fontSize: 14,
              ),
            ),
          ],
        )
      ],
    );
  }

  Column _dateTimeAndLocation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Icon(Icons.date_range),
            const SizedBox(width: 10),
            Text(
              training.date,
              style: const TextStyle(
                color: AppTheme.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.watch,
              size: 12,
              color: AppTheme.black.withOpacity(0.5),
            ),
            const SizedBox(width: 5),
            Text(
              training.time,
              style: TextStyle(
                color: AppTheme.black.withOpacity(0.5),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Icon(Icons.pin, size: 30),
            const SizedBox(width: 5),
            Text(
              training.location,
              style: const TextStyle(
                color: AppTheme.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  SliverAppBar _sliverAppBar() {
    return SliverAppBar(
      title: Text(
        training.name,
        style: const TextStyle(
          color: AppTheme.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      floating: true,
      pinned: true,
      expandedHeight: 200,
      foregroundColor: AppTheme.white,
      flexibleSpace: _sliverAppBarFlexibleSpaceContent(),
    );
  }

  Widget _sliverAppBarFlexibleSpaceContent() {
    return FlexibleSpaceBar(
      background: Container(
        decoration: BoxDecoration(image: _bannerImageView()),
      ),
    );
  }

  DecorationImage _bannerImageView() {
    return DecorationImage(
      image: AssetImage(training.banner),
      fit: BoxFit.fill,
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.6),
        BlendMode.darken,
      ),
    );
  }
}
