import 'package:flutter/material.dart';
import 'package:training/data/models/training.dart';
import 'package:training/presentation/screens/home/widgets/filter_modal.dart';

class TrainingProvider extends ChangeNotifier {
  var _highlights = <Training>[];
  var _trainings = <Training>[];

  var _allTrainerNames = <String>[];
  var _allTrainingNames = <String>[];
  var _allLocations = <String>[];

  var _selectedTrainerNames = <String>[];
  var _selectedTrainingNames = <String>[];
  var _selectedLocations = <String>[];

  var _selectedFilterType = FilterType.location;

  List<Training> get highlights => _highlights;
  List<Training> get trainings => _trainings;
  List<String> get allTrainerNames => _allTrainerNames;
  List<String> get allTrainingNames => _allTrainingNames;
  List<String> get allLocations => _allLocations;
  List<String> get selectedTrainerNames => _selectedTrainerNames;
  List<String> get selectedTrainingNames => _selectedTrainingNames;
  List<String> get selectedLocations => _selectedLocations;
  FilterType get selectedFilterType => _selectedFilterType;

  setHighlights(List<Training> highlights) {
    _highlights = highlights;
    notifyListeners();
  }

  setTraining(List<Training> trainings) {
    _trainings = trainings;
    notifyListeners();
  }

  setAllTrainerNames(List<String> allTrainerNames) {
    _allTrainerNames = allTrainerNames;
  }

  setAllTrainingNames(List<String> allTrainingNames) {
    _allTrainingNames = allTrainingNames;
  }

  setAllLocations(List<String> allLocations) {
    _allLocations = allLocations;
  }

  setSelectedTrainerNames(List<String> selectedTrainerNames) {
    _selectedTrainerNames = selectedTrainerNames;
    notifyListeners();
  }

  setSelectedTrainingNames(List<String> selectedTrainingNames) {
    _selectedTrainingNames = selectedTrainingNames;
    notifyListeners();
  }

  setSelectedLocations(List<String> selectedLocations) {
    _selectedLocations = selectedLocations;
    notifyListeners();
  }

  setSelectedFilterType(FilterType selectedFilterType) {
    _selectedFilterType = selectedFilterType;
    notifyListeners();
  }
}
