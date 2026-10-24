// ignore_for_file: constant_identifier_names
//
// Google Maps Platform — Weather + Maps endpointleri (statik klas).
// Resminamalar boýunça barlanan senesi: 2026-10-21.
//
// API açaryny koda ýazmaň! Ol `env/dev.json` faýlynda durýar (git-e
// goşulmaýar) we işledilende geçirilýär:
//   flutter run --dart-define-from-file=env/dev.json
// VS Code-da `.vscode/launch.json` muny özi edýär (F5).
//
// Ulanyş mysaly (Dio bilen, `getIt<Dio>()`):
//   final uri = ApiEndpoints.currentConditions(
//     lat: TmCities.ashgabat.lat, lng: TmCities.ashgabat.lng);
//   final res = await dio.getUri<Map<String, dynamic>>(uri);
//
//   // POST (Places, Routes, Air Quality):
//   final res = await dio.postUri<Map<String, dynamic>>(
//     ApiEndpoints.placesSearchText(),
//     options: Options(
//       headers: ApiEndpoints.fieldMaskHeaders('places.displayName'),
//     ),
//     data: {'textQuery': 'Aşgabat'},
//   );
library;

class ApiEndpoints {
  ApiEndpoints._();

  /// `env/dev.json` faýlyndan `--dart-define-from-file` arkaly berilýär.
  ///
  /// `fromEnvironment`-iň argumenti açaryň özi däl-de, **üýtgeýjiniň ady**.
  /// Açaryň özüni şu ýere ýazsaňyz, Flutter şol atly üýtgeýjini gözleýär,
  /// tapmaýar we boş setir gaýtarýar.
  static const String apiKey = String.fromEnvironment('GOOGLE_MAPS_API_KEY');

  // ───────────────────────── HOSTLAR ─────────────────────────
  static const String weatherHost = 'weather.googleapis.com';
  static const String airQualityHost = 'airquality.googleapis.com';
  static const String pollenHost = 'pollen.googleapis.com';
  static const String mapsHost = 'maps.googleapis.com';
  static const String placesHost = 'places.googleapis.com';
  static const String routesHost = 'routes.googleapis.com';
  static const String roadsHost = 'roads.googleapis.com';
  static const String tileHost = 'tile.googleapis.com';
  static const String solarHost = 'solar.googleapis.com';
  static const String addressValidationHost =
      'addressvalidation.googleapis.com';
  static const String geolocationHost = 'www.googleapis.com';

  // ───────────────────────── KÖMEKÇILER ─────────────────────────

  /// null bahalary aýyrýar we hemmesini String-e öwürýär.
  static Map<String, String> _q(Map<String, Object?> params) => {
    for (final e in params.entries)
      if (e.value != null) e.key: e.value.toString(),
  };

  static Map<String, String> _loc(double lat, double lng) => {
    'location.latitude': '$lat',
    'location.longitude': '$lng',
  };

  /// Places API (New) we Routes API üçin hökmany sözbaşylar.
  /// [fieldMask] mysal: 'places.displayName,places.formattedAddress'
  static Map<String, String> fieldMaskHeaders(String fieldMask) => {
    'Content-Type': 'application/json',
    'X-Goog-Api-Key': apiKey,
    'X-Goog-FieldMask': fieldMask,
  };

  static const Map<String, String> jsonHeaders = {
    'Content-Type': 'application/json',
  };

  // ════════════════════════════════════════════════════════════
  //  1. WEATHER API  (hemmesi GET)
  // ════════════════════════════════════════════════════════════

  /// Häzirki howa ýagdaýy (temperatura, duýulýan temp., çyglylyk,
  /// UV, ýagyş ähtimallygy, şemal, görnüş, soňky 24 sagat taryhy).
  static Uri currentConditions({
    required double lat,
    required double lng,
    String unitsSystem = WeatherUnits.METRIC,
    String? languageCode,
  }) => Uri.https(
    weatherHost,
    '/v1/currentConditions:lookup',
    _q({
      'key': apiKey,
      ..._loc(lat, lng),
      'unitsSystem': unitsSystem,
      'languageCode': languageCode,
    }),
  );

  /// Günlük çaklama (iň köp 10 gün).
  static Uri forecastDays({
    required double lat,
    required double lng,
    int days = 10,
    int? pageSize,
    String? pageToken,
    String unitsSystem = WeatherUnits.METRIC,
    String? languageCode,
  }) => Uri.https(
    weatherHost,
    '/v1/forecast/days:lookup',
    _q({
      'key': apiKey,
      ..._loc(lat, lng),
      'days': days,
      'pageSize': pageSize,
      'pageToken': pageToken,
      'unitsSystem': unitsSystem,
      'languageCode': languageCode,
    }),
  );

  /// Sagatlyk çaklama (iň köp 240 sagat).
  static Uri forecastHours({
    required double lat,
    required double lng,
    int hours = 24,
    int? pageSize,
    String? pageToken,
    String unitsSystem = WeatherUnits.METRIC,
    String? languageCode,
  }) => Uri.https(
    weatherHost,
    '/v1/forecast/hours:lookup',
    _q({
      'key': apiKey,
      ..._loc(lat, lng),
      'hours': hours,
      'pageSize': pageSize,
      'pageToken': pageToken,
      'unitsSystem': unitsSystem,
      'languageCode': languageCode,
    }),
  );

  /// Sagatlyk taryh (soňky iň köp 24 sagat).
  static Uri historyHours({
    required double lat,
    required double lng,
    int hours = 24,
    int? pageSize,
    String? pageToken,
    String unitsSystem = WeatherUnits.METRIC,
    String? languageCode,
  }) => Uri.https(
    weatherHost,
    '/v1/history/hours:lookup',
    _q({
      'key': apiKey,
      ..._loc(lat, lng),
      'hours': hours,
      'pageSize': pageSize,
      'pageToken': pageToken,
      'unitsSystem': unitsSystem,
      'languageCode': languageCode,
    }),
  );

  /// Resmi howa duýduryşlary. languageCode diňe alertTitle-y terjime edýär.
  /// ⚠ Türkmenistan üçin maglumat çeşmesi häzirlikçe ýok.
  static Uri publicAlerts({
    required double lat,
    required double lng,
    String? languageCode,
  }) => Uri.https(
    weatherHost,
    '/v1/publicAlerts:lookup',
    _q({'key': apiKey, ..._loc(lat, lng), 'languageCode': languageCode}),
  );

  /// [Experimental] Minutlyk ýagyn çaklamasy (6 sagat).
  /// ⚠ Gurşaw çäkli (esasan ABŞ/Ýewropa).
  static Uri forecastMinutes({
    required double lat,
    required double lng,
    int? pageSize,
    String? pageToken,
    String unitsSystem = WeatherUnits.METRIC,
  }) => Uri.https(
    weatherHost,
    '/v1/forecast/minutes:lookup',
    _q({
      'key': apiKey,
      ..._loc(lat, lng),
      'pageSize': pageSize,
      'pageToken': pageToken,
      'unitsSystem': unitsSystem,
    }),
  );

  /// [Experimental] Howa karta tile-lary (PNG, zoom 0–16).
  /// ⚠ Diňe US_PRECIPITATION_CURRENT we EU_PRECIPITATION_CURRENT bar.
  static String weatherMapTile({
    required String mapType,
    required int z,
    required int x,
    required int y,
  }) =>
      'https://$weatherHost/v1/mapTypes/$mapType/mapTiles/$z/$x/$y?key=$apiKey';

  /// Jogapdaky weatherCondition.iconBaseUri-den ikona URL-i.
  /// [format]: 'svg' ýa-da 'png'; [dark]: garaňky tema üçin.
  static String weatherIcon(
    String iconBaseUri, {
    String format = 'png',
    bool dark = false,
  }) => '$iconBaseUri${dark ? '_dark' : ''}.$format';

  // ════════════════════════════════════════════════════════════
  //  2. AIR QUALITY API  (lookup-lar POST + JSON body)
  // ════════════════════════════════════════════════════════════

  /// POST body: {"location":{"latitude":..,"longitude":..},
  ///             "extraComputations":["HEALTH_RECOMMENDATIONS", ...]}
  static Uri airQualityCurrent() => Uri.https(
    airQualityHost,
    '/v1/currentConditions:lookup',
    {'key': apiKey},
  );

  /// POST body: location + "period":{"startTime","endTime"} ýa-da "dateTime".
  static Uri airQualityForecast() =>
      Uri.https(airQualityHost, '/v1/forecast:lookup', {'key': apiKey});

  /// POST body: location + "hours": 1–720.
  static Uri airQualityHistory() =>
      Uri.https(airQualityHost, '/v1/history:lookup', {'key': apiKey});

  /// Howa hili heatmap tile (GET, PNG).
  static String airQualityHeatmapTile({
    String mapType = AirQualityMapType.UAQI_RED_GREEN,
    required int z,
    required int x,
    required int y,
  }) =>
      'https://$airQualityHost/v1/mapTypes/$mapType/heatmapTiles/$z/$x/$y?key=$apiKey';

  // ════════════════════════════════════════════════════════════
  //  3. POLLEN API  (GET)
  // ════════════════════════════════════════════════════════════

  /// Tozan (pollen) çaklamasy, iň köp 5 gün.
  static Uri pollenForecast({
    required double lat,
    required double lng,
    int days = 5,
    String? languageCode,
    bool plantsDescription = false,
  }) => Uri.https(
    pollenHost,
    '/v1/forecast:lookup',
    _q({
      'key': apiKey,
      ..._loc(lat, lng),
      'days': days,
      'languageCode': languageCode,
      'plantsDescription': plantsDescription,
    }),
  );

  static String pollenHeatmapTile({
    String mapType = PollenMapType.TREE_UPI,
    required int z,
    required int x,
    required int y,
  }) =>
      'https://$pollenHost/v1/mapTypes/$mapType/heatmapTiles/$z/$x/$y?key=$apiKey';

  // ════════════════════════════════════════════════════════════
  //  4. GEOCODING / TIME ZONE / ELEVATION / GEOLOCATION
  // ════════════════════════════════════════════════════════════

  /// Salgy → koordinata. Mysal: address: 'Mary, Turkmenistan'
  static Uri geocodeAddress(
    String address, {
    String? language,
    String region = 'tm',
  }) => Uri.https(
    mapsHost,
    '/maps/api/geocode/json',
    _q({
      'key': apiKey,
      'address': address,
      'language': language,
      'region': region,
    }),
  );

  /// Koordinata → salgy (şäher adyny tapmak üçin).
  static Uri reverseGeocode(double lat, double lng, {String? language}) =>
      Uri.https(
        mapsHost,
        '/maps/api/geocode/json',
        _q({'key': apiKey, 'latlng': '$lat,$lng', 'language': language}),
      );

  /// [timestamp] — sekuntda Unix wagty.
  static Uri timeZone(double lat, double lng, {int? timestamp}) => Uri.https(
    mapsHost,
    '/maps/api/timezone/json',
    _q({
      'key': apiKey,
      'location': '$lat,$lng',
      'timestamp': timestamp ?? DateTime.now().millisecondsSinceEpoch ~/ 1000,
    }),
  );

  /// Deňiz derejesinden beýiklik. [locations]: 'lat,lng|lat,lng'
  static Uri elevation(String locations) => Uri.https(
    mapsHost,
    '/maps/api/elevation/json',
    {'key': apiKey, 'locations': locations},
  );

  /// POST body: {"considerIp": true} ýa-da wifi/cell maglumatlary.
  static Uri geolocate() =>
      Uri.https(geolocationHost, '/geolocation/v1/geolocate', {'key': apiKey});

  // ════════════════════════════════════════════════════════════
  //  5. PLACES API (New)  — fieldMaskHeaders() bilen ulanyň
  // ════════════════════════════════════════════════════════════

  /// POST body: {"textQuery": "...", "languageCode": "ru"}
  static Uri placesSearchText() =>
      Uri.https(placesHost, '/v1/places:searchText');

  /// POST body: {"locationRestriction":{"circle":{"center":{...},"radius":5000}}}
  static Uri placesSearchNearby() =>
      Uri.https(placesHost, '/v1/places:searchNearby');

  /// POST body: {"input": "Aşg", "includedRegionCodes": ["tm"]}
  /// Şäher gözleg meýdançasy üçin amatly.
  static Uri placesAutocomplete() =>
      Uri.https(placesHost, '/v1/places:autocomplete');

  /// GET — ýeriň jikme-jiklikleri (fieldMaskHeaders bilen).
  static Uri placeDetails(String placeId, {String? languageCode}) => Uri.https(
    placesHost,
    '/v1/places/$placeId',
    _q({'languageCode': languageCode}),
  );

  /// GET — surat. [photoName]: 'places/XXX/photos/YYY'
  static Uri placePhoto(
    String photoName, {
    int maxWidthPx = 800,
    int? maxHeightPx,
  }) => Uri.https(
    placesHost,
    '/v1/$photoName/media',
    _q({'key': apiKey, 'maxWidthPx': maxWidthPx, 'maxHeightPx': maxHeightPx}),
  );

  // ════════════════════════════════════════════════════════════
  //  6. ROUTES / ROADS  — Routes üçin fieldMaskHeaders() hökmany
  // ════════════════════════════════════════════════════════════

  /// POST — ugur hasaplamak. FieldMask mysal:
  /// 'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline'
  static Uri computeRoutes() =>
      Uri.https(routesHost, '/directions/v2:computeRoutes');

  /// POST — birnäçe gelip-gidiş nokatlarynyň aralyk matrisasy.
  static Uri computeRouteMatrix() =>
      Uri.https(routesHost, '/distanceMatrix/v2:computeRouteMatrix');

  /// [path]: 'lat,lng|lat,lng|...'
  static Uri snapToRoads(String path, {bool interpolate = true}) => Uri.https(
    roadsHost,
    '/v1/snapToRoads',
    {'key': apiKey, 'path': path, 'interpolate': '$interpolate'},
  );

  static Uri nearestRoads(String points) => Uri.https(
    roadsHost,
    '/v1/nearestRoads',
    {'key': apiKey, 'points': points},
  );

  // ════════════════════════════════════════════════════════════
  //  7. STATIK KARTALAR / STREET VIEW  (Image.network bilen)
  // ════════════════════════════════════════════════════════════

  /// [mapType]: roadmap | satellite | terrain | hybrid
  /// [markers]: mysal 'color:red|37.96,58.33'
  static Uri staticMap({
    required double lat,
    required double lng,
    int zoom = 10,
    int width = 600,
    int height = 300,
    int scale = 2,
    String mapType = 'roadmap',
    String? markers,
    String? language,
  }) => Uri.https(
    mapsHost,
    '/maps/api/staticmap',
    _q({
      'key': apiKey,
      'center': '$lat,$lng',
      'zoom': zoom,
      'size': '${width}x$height',
      'scale': scale,
      'maptype': mapType,
      'markers': markers,
      'language': language,
    }),
  );

  static Uri streetViewImage({
    required double lat,
    required double lng,
    int width = 600,
    int height = 300,
    int? heading,
    int fov = 90,
    int pitch = 0,
  }) => Uri.https(
    mapsHost,
    '/maps/api/streetview',
    _q({
      'key': apiKey,
      'location': '$lat,$lng',
      'size': '${width}x$height',
      'heading': heading,
      'fov': fov,
      'pitch': pitch,
    }),
  );

  /// Mugt — şol ýerde Street View suraty barmy, barlamak üçin.
  static Uri streetViewMetadata(double lat, double lng) => Uri.https(
    mapsHost,
    '/maps/api/streetview/metadata',
    {'key': apiKey, 'location': '$lat,$lng'},
  );

  // ════════════════════════════════════════════════════════════
  //  8. MAP TILES API  (öz karta gatlagyňyz üçin)
  // ════════════════════════════════════════════════════════════

  /// POST body: {"mapType":"roadmap","language":"en-US","region":"TM"}
  /// Jogapdan "session" tokenini alyň.
  static Uri tileCreateSession() =>
      Uri.https(tileHost, '/v1/createSession', {'key': apiKey});

  static String tile2D({
    required String session,
    required int z,
    required int x,
    required int y,
  }) => 'https://$tileHost/v1/2dtiles/$z/$x/$y?session=$session&key=$apiKey';

  // ════════════════════════════════════════════════════════════
  //  9. BEÝLEKILER
  // ════════════════════════════════════════════════════════════

  /// POST body: {"address":{"regionCode":"TM","addressLines":["..."]}}
  static Uri validateAddress() =>
      Uri.https(addressValidationHost, '/v1:validateAddress', {'key': apiKey});

  /// Gün energiýasy (Türkmenistanda gurşaw gaty çäkli bolup biler).
  static Uri solarBuildingInsights(double lat, double lng) => Uri.https(
    solarHost,
    '/v1/buildingInsights:findClosest',
    {'key': apiKey, ..._loc(lat, lng)},
  );

  // ── Maps URLs: açar gerek däl, Google Maps programmasyny açýar
  //    (url_launcher bilen) ──
  static Uri openInGoogleMaps(double lat, double lng) => Uri.https(
    'www.google.com',
    '/maps/search/',
    {'api': '1', 'query': '$lat,$lng'},
  );

  static Uri directionsInGoogleMaps(
    double lat,
    double lng, {
    String travelMode = 'driving',
  }) => Uri.https('www.google.com', '/maps/dir/', {
    'api': '1',
    'destination': '$lat,$lng',
    'travelmode': travelMode,
  });

  /// Maps Embed API (WebView üçin, mugt).
  static Uri embedPlace(String query) => Uri.https(
    'www.google.com',
    '/maps/embed/v1/place',
    {'key': apiKey, 'q': query},
  );
}

// ───────────────────────── ENUM-LAR ─────────────────────────

class WeatherUnits {
  WeatherUnits._();
  static const String METRIC = 'METRIC';
  static const String IMPERIAL = 'IMPERIAL';
}

class WeatherMapType {
  WeatherMapType._();
  static const String US_PRECIPITATION_CURRENT = 'US_PRECIPITATION_CURRENT';
  static const String EU_PRECIPITATION_CURRENT = 'EU_PRECIPITATION_CURRENT';
}

class AirQualityMapType {
  AirQualityMapType._();
  static const String UAQI_RED_GREEN = 'UAQI_RED_GREEN';
  static const String UAQI_INDIGO_PERSIAN = 'UAQI_INDIGO_PERSIAN';
  static const String PM25_INDIGO_PERSIAN = 'PM25_INDIGO_PERSIAN';
  static const String US_AQI = 'US_AQI';
}

class PollenMapType {
  PollenMapType._();
  static const String TREE_UPI = 'TREE_UPI';
  static const String GRASS_UPI = 'GRASS_UPI';
  static const String WEED_UPI = 'WEED_UPI';
}

// ───────────────────── TÜRKMENISTANYŇ ŞÄHERLERI ─────────────────────

class TmCity {
  final String name;
  final double lat;
  final double lng;
  const TmCity(this.name, this.lat, this.lng);
}

class TmCities {
  TmCities._();

  // Paýtagt / Capital
  static const ashgabat = TmCity('Aşgabat', 37.9601, 58.3261);
  // Ahal welaýaty
  static const anew = TmCity('Änew', 37.8875, 58.5160);
  static const abadan = TmCity('Abadan', 38.0541, 58.1972);
  static const gokdepe = TmCity('Gökdepe', 38.1586, 57.9607);
  static const baherden = TmCity('Bäherden', 38.4362, 57.4316);
  static const archman = TmCity('Arçman', 38.5435, 57.1571);
  static const kaka = TmCity('Kaka', 37.3482, 59.6143);
  static const tejen = TmCity('Tejen', 37.3834, 60.5055);
  static const sarahs = TmCity('Sarahs', 36.5238, 61.2148);
  static const babadayhan = TmCity('Babadaýhan', 37.6900, 60.3942);
  static const dushak = TmCity('Duşak', 37.1952, 60.0247);
  static const berkararAhal = TmCity('Berkarar (Ahal)', 37.6493, 59.1480);
  static const bokurdak = TmCity('Bokurdak', 38.7631, 58.4927);
  static const yzgant = TmCity('Yzgant', 38.1825, 58.1134);

  // Balkan welaýaty
  static const balkanabat = TmCity('Balkanabat', 39.5108, 54.3671);
  static const turkmenbashy = TmCity('Türkmenbaşy', 40.0225, 52.9550);
  static const hazar = TmCity('Hazar', 39.4036, 53.1260);
  static const serdar = TmCity('Serdar (Gyzylarbat)', 38.9764, 56.2758);
  static const bereket = TmCity('Bereket', 39.2446, 55.5154);
  static const magtymguly = TmCity('Magtymguly (Garrygala)', 38.4364, 56.2840);
  static const etrek = TmCity('Etrek', 37.6616, 54.7640);
  static const esenguly = TmCity('Esenguly', 37.4680, 53.9795);
  static const garabogaz = TmCity('Garabogaz', 41.5401, 52.5734);
  static const gumdag = TmCity('Gumdag', 39.2024, 54.5875);
  static const jebel = TmCity('Jebel', 39.6310, 54.2376);

  static const guwlymayak = TmCity('Guwlymaýak', 40.2470, 52.7410);

  // Daşoguz welaýaty
  static const dashoguz = TmCity('Daşoguz', 41.8363, 59.9666);
  static const koneurgench = TmCity('Köneürgenç', 42.3261, 59.1531);
  static const boldumsaz = TmCity('Boldumsaz', 42.1276, 59.6723);
  static const gubadag = TmCity('Gubadag', 42.0795, 59.9496);
  static const gorogly = TmCity('Görogly', 41.6504, 59.9164);
  static const akdepeDashoguz = TmCity('Akdepe (Daşoguz)', 42.0551, 59.3788);
  static const saparmyratTurkmenbashy = TmCity(
    'Saparmyrat Türkmenbaşy',
    42.3799,
    58.8140,
  );

  // Lebap welaýaty
  static const turkmenabat = TmCity('Türkmenabat', 39.0733, 63.5786);
  static const atamyrat = TmCity('Kerki', 37.8408, 65.2064);
  static const seydi = TmCity('Seýdi', 39.4816, 62.9137);
  static const farap = TmCity('Farap', 39.1704, 63.6116);
  static const halach = TmCity('Halaç', 38.0720, 64.8794);
  static const sayat = TmCity('Saýat', 38.7839, 63.8803);
  static const koytendag = TmCity('Köýtendag', 37.5156, 66.0135);
  static const magdanly = TmCity('Magdanly', 37.8124, 66.0466);
  static const dostluk = TmCity('Dostluk', 37.7455, 65.3376);
  static const gazojak = TmCity('Gazojak', 41.1875, 61.4036);
  static const galkynysh = TmCity('Galkynyş', 39.2628, 63.1843);
  static const dowletli = TmCity('Döwletli', 38.0110, 65.5684);
  static const hojambaz = TmCity('Hojambaz', 38.1163, 65.0035);
  static const karabekaul = TmCity('Garabekewül', 38.4846, 64.1515);

  // Mary welaýaty
  static const mary = TmCity('Mary', 37.5936, 61.8303);
  static const bayramaly = TmCity('Baýramaly', 37.6185, 62.1671);
  static const murgap = TmCity('Murgap', 37.4966, 61.9714);
  static const sakarchage = TmCity('Sakarçäge', 37.6635, 61.6601);
  static const yoloten = TmCity('Ýolöten', 37.2989, 62.3597);
  static const turkmengala = TmCity('Türkmengala', 37.4247, 62.3382);
  static const tagtabazar = TmCity('Tagtabazar', 35.9553, 62.9174);
  static const serhetabat = TmCity('Serhetabat', 35.2799, 62.3438);
  static const oguzhan = TmCity('Oguzhan', 37.3182, 61.0862);
  static const satlyk = TmCity('Şatlyk', 37.6072, 61.5939);

  static const List<TmCity> all = [
    ashgabat,
    anew,
    abadan,
    gokdepe,
    baherden,
    archman,
    kaka,
    tejen,
    sarahs,
    babadayhan,
    dushak,
    berkararAhal,
    bokurdak,
    yzgant,
    balkanabat,
    turkmenbashy,
    hazar,
    serdar,
    bereket,
    magtymguly,
    etrek,
    esenguly,
    garabogaz,
    gumdag,
    jebel,

    guwlymayak,
    dashoguz,
    koneurgench,
    boldumsaz,
    gubadag,
    gorogly,
    akdepeDashoguz,
    saparmyratTurkmenbashy,

    turkmenabat,
    atamyrat,
    seydi,
    farap,
    halach,
    sayat,
    koytendag,
    magdanly,
    dostluk,

    gazojak,
    galkynysh,
    dowletli,
    hojambaz,
    karabekaul,

    mary,
    bayramaly,
    murgap,
    sakarchage,
    yoloten,
    turkmengala,
    tagtabazar,
    serhetabat,
    oguzhan,

    satlyk,
  ];
}

// ───────────────────── RESMINAMA SALGYLARY ─────────────────────

class ApiDocs {
  ApiDocs._();
  static const _b = 'https://developers.google.com/maps/documentation';

  static const weatherOverview = '$_b/weather/overview';
  static const weatherCoverage = '$_b/weather/coverage';
  static const weatherCurrent = '$_b/weather/current-conditions';
  static const weatherDaily = '$_b/weather/daily-forecast';
  static const weatherHourly = '$_b/weather/hourly-forecast';
  static const weatherHistory = '$_b/weather/hourly-history';
  static const weatherAlerts = '$_b/weather/weather-alerts';
  static const weatherMinute = '$_b/weather/minute-forecast';
  static const weatherMaps = '$_b/weather/weather-map';
  static const weatherIcons = '$_b/weather/weather-condition-icons';
  static const weatherUnits = '$_b/weather/weather-units-systems';
  static const weatherReference = '$_b/weather/reference/rest';

  static const airQuality = '$_b/air-quality';
  static const pollen = '$_b/pollen';
  static const solar = '$_b/solar';
  static const geocoding = '$_b/geocoding';
  static const geolocation = '$_b/geolocation';
  static const timeZone = '$_b/timezone';
  static const elevation = '$_b/elevation';
  static const placesNew = '$_b/places/web-service';
  static const addressValidation = '$_b/address-validation';
  static const routes = '$_b/routes';
  static const roads = '$_b/roads';
  static const mapsStatic = '$_b/maps-static';
  static const streetView = '$_b/streetview';
  static const mapTiles = '$_b/tile';
  static const mapsEmbed = '$_b/embed';
  static const mapsUrls = '$_b/urls';
  static const flutterMaps =
      'https://developers.google.com/maps/flutter-package/overview';
  static const apiSecurity =
      'https://developers.google.com/maps/api-security-best-practices';
}
