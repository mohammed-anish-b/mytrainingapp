import 'package:flutter/material.dart';
import 'package:training/data/models/training.dart';
import 'package:training/presentation/common/app_theme.dart';
import 'package:training/presentation/common/ui_string.dart';
import 'package:training/presentation/screens/detail/training_detail_page.dart';

class TrainingCard extends StatelessWidget {
  static const _badgeImage = "assets/images/badge.jpeg";

  const TrainingCard({
    super.key,
    required this.training,
  });

  final Training training;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TrainingDetailPage(training: training),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(12),
        decoration: _cardDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: _dateTimeAndLocation(),
            ),
            Expanded(
              flex: 1,
              child: _dashedLine(),
            ),
            Expanded(
              flex: 6,
              child: _trainingDetail(),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
        color: AppTheme.white,
        boxShadow: [
          BoxShadow(
              color: AppTheme.black.withOpacity(0.1),
              offset: const Offset(4, 4),
              blurRadius: 4,
              spreadRadius: 0),
          BoxShadow(
              color: AppTheme.black.withOpacity(0.1),
              offset: const Offset(-1, -1),
              blurRadius: 4,
              spreadRadius: 0),
        ],
        borderRadius: BorderRadius.circular(2));
  }

  Column _trainingDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          UIString.fillingFast,
          style: TextStyle(
            color: AppTheme.sunburntCyclops,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          training.name,
          style: const TextStyle(
            color: AppTheme.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        _trainerDetail(),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: _enrollNowButton(),
        )
      ],
    );
  }

  Container _enrollNowButton() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.sunburntCyclops,
        borderRadius: BorderRadius.circular(2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: const Text(
        UIString.enrolNow,
        style: TextStyle(
          color: AppTheme.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
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
                minRadius: 25,
              ),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.white,
                ),
                child: const CircleAvatar(
                  backgroundImage: AssetImage(_badgeImage),
                  minRadius: 8,
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
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              training.trainerName,
              style: TextStyle(
                color: AppTheme.black.withOpacity(0.5),
                fontSize: 12,
              ),
            ),
          ],
        )
      ],
    );
  }

  Column _dashedLine() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(12, (index) {
        return Container(
          width: 1,
          height: 5,
          margin: const EdgeInsets.symmetric(vertical: 4),
          color: AppTheme.black.withOpacity(0.5),
        );
      }),
    );
  }

  Column _dateTimeAndLocation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          training.date,
          style: const TextStyle(
            color: AppTheme.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          training.time,
          style: TextStyle(
            color: AppTheme.black.withOpacity(0.5),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          training.location,
          style: const TextStyle(
            color: AppTheme.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
