import 'package:training/data/dummy_data.dart';
import 'package:training/data/models/training.dart';

class TrainingController {
  TrainingController._privateConstructor();

  static final TrainingController _instance = TrainingController._privateConstructor();

  static TrainingController get instance => _instance;

  final dummyDataRepo = DummyData();

  List<Training> fetchHighlights() {
    return dummyDataRepo.highlights;
  }

  List<Training> fetchTrainings({
    bool hasFilter = false,
    List<String> trainerNames = const [],
    List<String> trainingNames = const [],
    List<String> locations = const [],
  }) {
    if (!hasFilter) {
      return dummyDataRepo.trainings;
    }
    var training = [...dummyDataRepo.trainings];
    if (trainerNames.isNotEmpty) {
      training = training
          .where((training) => trainerNames.any((name) => training.trainerName == name))
          .toList();
    }
    if (trainingNames.isNotEmpty) {
      training =
          training.where((training) => trainingNames.any((name) => training.name == name)).toList();
    }
    if (locations.isNotEmpty) {
      training =
          training.where((training) => locations.any((name) => training.location == name)).toList();
    }
    return training;
  }

  List<String> fetchTrainerNames() {
    return dummyDataRepo.trainings.map((training) => training.trainerName).toSet().toList();
  }

  List<String> fetchTrainingNames() {
    return dummyDataRepo.trainings.map((training) => training.name).toSet().toList();
  }

  List<String> fetchLocationNames() {
    return dummyDataRepo.trainings.map((training) => training.location).toSet().toList();
  }
}
