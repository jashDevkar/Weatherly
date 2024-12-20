
import 'package:geolocator/geolocator.dart';



Future<Position> getLocation()async{
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if(!serviceEnabled){
    serviceEnabled = await Geolocator.openLocationSettings();
  }
  if(serviceEnabled){
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.whileInUse || permission == LocationPermission.always){
        return await Geolocator.getCurrentPosition();
      }
      else if( permission == LocationPermission.deniedForever){
        return Future.error('Location permission denied forever');
      }
      else{
        return Future.error('Permission not granted');
      }
    }
    else{
      return await Geolocator.getCurrentPosition();
    }

  }
  else{
    return Future.error('Service not enabled');
  }

}