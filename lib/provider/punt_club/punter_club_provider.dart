import 'package:flutter/cupertino.dart';

class PunterClubProvider extends ChangeNotifier {
  List clubsList = ["‘Top Punters’", "‘PuntGPT Legends’", "‘Mug Punters Crew’"];

  int _selectedPunters = 0;
  int get selectedPunterWeb => _selectedPunters;

  set setPunterIndex(int value){
    _selectedPunters = value;
    notifyListeners();
  }

}
