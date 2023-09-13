import 'package:superhero/models/hr_byid.dart';

import '../models/heroes_response.dart';
import '../models/main_response.dart';

abstract class ICharcters{
  Future<HRById?> getById(String id);
  Future<MainResponse?> getByName(String name);
}