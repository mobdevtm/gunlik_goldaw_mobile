import 'package:gunluk_goldaw_mobile/core/constants/api_endpoints.dart';

/// Translation keys for [TmCities].
///
/// `TmCity.name` is the Turkmen spelling and stays the stored identifier;
/// what the user reads comes from these keys, in their language. A city
/// added to [TmCities] needs a line here and a `city_*` key in every
/// translation file, or it shows as `city_unknown`.
class CityMapper {
  CityMapper._();

  static const Map<TmCity, String> _keys = {
    TmCities.ashgabat: 'city_ashgabat',
    TmCities.anew: 'city_anew',
    TmCities.abadan: 'city_abadan',
    TmCities.gokdepe: 'city_gokdepe',
    TmCities.baherden: 'city_baherden',
    TmCities.archman: 'city_archman',
    TmCities.kaka: 'city_kaka',
    TmCities.tejen: 'city_tejen',
    TmCities.sarahs: 'city_sarahs',
    TmCities.babadayhan: 'city_babadayhan',
    TmCities.dushak: 'city_dushak',
    TmCities.berkararAhal: 'city_berkarar_ahal',
    TmCities.bokurdak: 'city_bokurdak',
    TmCities.yzgant: 'city_yzgant',
    TmCities.balkanabat: 'city_balkanabat',
    TmCities.turkmenbashy: 'city_turkmenbashy',
    TmCities.hazar: 'city_hazar',
    TmCities.serdar: 'city_serdar',
    TmCities.bereket: 'city_bereket',
    TmCities.magtymguly: 'city_magtymguly',
    TmCities.etrek: 'city_etrek',
    TmCities.esenguly: 'city_esenguly',
    TmCities.garabogaz: 'city_garabogaz',
    TmCities.gumdag: 'city_gumdag',
    TmCities.jebel: 'city_jebel',
    TmCities.guwlymayak: 'city_guwlymayak',
    TmCities.dashoguz: 'city_dashoguz',
    TmCities.koneurgench: 'city_koneurgench',
    TmCities.boldumsaz: 'city_boldumsaz',
    TmCities.gubadag: 'city_gubadag',
    TmCities.gorogly: 'city_gorogly',
    TmCities.akdepeDashoguz: 'city_akdepe_dashoguz',
    TmCities.saparmyratTurkmenbashy: 'city_saparmyrat_turkmenbashy',
    TmCities.turkmenabat: 'city_turkmenabat',
    TmCities.atamyrat: 'city_atamyrat',
    TmCities.seydi: 'city_seydi',
    TmCities.farap: 'city_farap',
    TmCities.halach: 'city_halach',
    TmCities.sayat: 'city_sayat',
    TmCities.koytendag: 'city_koytendag',
    TmCities.magdanly: 'city_magdanly',
    TmCities.dostluk: 'city_dostluk',
    TmCities.gazojak: 'city_gazojak',
    TmCities.galkynysh: 'city_galkynysh',
    TmCities.dowletli: 'city_dowletli',
    TmCities.hojambaz: 'city_hojambaz',
    TmCities.karabekaul: 'city_karabekaul',
    TmCities.mary: 'city_mary',
    TmCities.bayramaly: 'city_bayramaly',
    TmCities.murgap: 'city_murgap',
    TmCities.sakarchage: 'city_sakarchage',
    TmCities.yoloten: 'city_yoloten',
    TmCities.turkmengala: 'city_turkmengala',
    TmCities.tagtabazar: 'city_tagtabazar',
    TmCities.serhetabat: 'city_serhetabat',
    TmCities.oguzhan: 'city_oguzhan',
    TmCities.satlyk: 'city_satlyk',
  };

  static String labelKey(TmCity city) => _keys[city] ?? 'city_unknown';
}
