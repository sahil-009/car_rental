
// i made this folder to store all data
import '../models/car.dart';

class GlobalData {
  // login check
  static bool isLoggedIn = false;
  
  // booking stuff
  static var selectedCar; // dont know the type so var
  static String name = "";
  static var startDate;
  static var endDate;
  static String location = "";
  
  // function to clear
  static void clear() {
    selectedCar = null;
    name = "";
    startDate = null;
    endDate = null;
    location = "";
  }
}
