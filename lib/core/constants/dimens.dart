import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Responsive
class Dimens {
  Dimens._();

  /// Tasarımı yaptığın referans ekran (telefon). Figma/tasarım neyse o.
  static const Size designSize = Size(375, 812);

  /// Tablette bir değerin tasarım değerine göre ne kadar büyüyeceği.
  ///
  /// Kural: tasarımda 14 yazan bir değer tablette 16 olarak çizilir
  /// (16 / 14 = 1.143). İkon da aynı şekilde: 24 -> 27.4.
  ///
  /// Bu çarpan ScreenUtil'in kendi ölçeğinin ÜSTÜNE binmiyor; [r] ve [sp]
  /// tablette ScreenUtil'i devre dışı bırakıp tasarım değerini doğrudan
  /// bununla çarpıyor. Öncesinde ikisi üst üste geliyordu: ScreenUtil 1024pt
  /// genişlikte zaten ~1.68x büyütüyordu, çarpan da onun üstüne gelince
  /// 14pt'lik bir yazı iPad'de 26pt olarak çiziliyordu.
  static const double _tabletScale = 16 / 14;
  static double device({required double phone, required double tablet}) {
    return isTablet ? tablet : phone;
  }

  // ── Cihaz bilgisi ────────────────────────────────────────────────
  static bool get isTablet =>
      ScreenUtil().screenWidth >= 600 ||
      // en kısa kenar 600+ ise tablet (yatay tablette de doğru çalışır)
      _shortestSide >= 600;

  static double get _shortestSide {
    final w = ScreenUtil().screenWidth;
    final h = ScreenUtil().screenHeight;
    return w < h ? w : h;
  }

  static bool get isPhone => !isTablet;
  static bool get isPortrait =>
      ScreenUtil().orientation == Orientation.portrait;
  static bool get isLandscape => !isPortrait;

  static double get screenWidth => ScreenUtil().screenWidth;
  static double get screenHeight => ScreenUtil().screenHeight;

  // ── Çekirdek ölçekleyiciler ──────────────────────────────────────

  /// Boyut (genişlik/yükseklik/padding/margin/radius) için.
  ///
  /// Telefonda ScreenUtil ile ölçeklenir: 375pt referansa göre küçük/büyük
  /// telefonlar arasında tasarım oranı korunur.
  ///
  /// Tablette ScreenUtil devrede DEĞİL. Sebebi: ScreenUtil ekran ne kadar
  /// genişse değeri o kadar büyütür, ama tablet "büyük telefon" değildir —
  /// daha fazla içerik göstermek içindir, aynı içeriği şişirmek için değil.
  /// 1024pt'lik bir iPad'de ölçek ~1.68x'e çıkıyor ve 14pt'lik bir yazı
  /// 24pt olarak çiziliyordu. Tablette tasarım değerini olduğu gibi alıp
  /// sadece [_tabletScale] kadar büyütüyoruz.
  static double r(double size) {
    if (isTablet) return size * _tabletScale;
    return size.r; // screenutil: en kısa kenara göre ölçekler
  }

  /// Font boyutu için.
  ///
  /// Yazı ve kutu aynı çarpanı paylaşır: tasarımda 14 olan yazı tablette 16,
  /// 24 olan ikon 27.4 olur. Ayrı tutulmasının tek sebebi, ileride yazıyı
  /// boyuttan bağımsız ayarlamak gerekirse tek yerden yapılabilmesi.
  static double sp(double fontSize) {
    if (isTablet) return fontSize * _tabletScale;
    return fontSize.sp;
  }

  /// Ekran genişliğinin yüzdesi. w(50) = ekranın %50'si.
  static double w(double percent) => ScreenUtil().screenWidth * percent / 100;

  /// Tablette ekran genişliğini tutan widget'ların kaplayacağı oran.
  static const double _tabletContentRatio = 0.7;

  /// Bir metin/kart sütununun uzayabileceği azami genişlik.
  ///
  /// Telefonda ekranın tamamı. Tablette ekranın %70'i: bir satır yazı 1024pt
  /// boyunca uzarsa göz satır sonundan başına dönemez, dört sayaç da ekrana
  /// yayılıp aralarında boşluk kalır. Ölçeği düzeltmek yazıyı doğru boyuta
  /// getirir ama düzeni germesini engellemez — onu bu yapar.
  ///
  /// Sabit bir pt değeri yerine oran: böylece bölünmüş ekranda (splitScreen)
  /// ya da yatay çevrildiğinde de ekranla birlikte hareket ediyor.
  static double get contentMaxWidth => isTablet
      ? ScreenUtil().screenWidth * _tabletContentRatio
      : ScreenUtil().screenWidth;

  /// İçeriğin fiilen kaplayacağı genişlik: ekran ile [contentMaxWidth]'in
  /// küçüğü. Genişliği elle hesaplayan yerler [screenWidth] yerine bunu
  /// kullanmalı, yoksa tablette dörde bölünen bir satır aşırı genişler.
  static double get contentWidth {
    final screen = ScreenUtil().screenWidth;
    final max = contentMaxWidth;
    return screen < max ? screen : max;
  }

  /// Ekran yüksekliğinin yüzdesi. h(30) = ekranın %30'u.
  static double h(double percent) => ScreenUtil().screenHeight * percent / 100;

  // ── Grid: asıl responsive çözüm burada ──────────────────────────
  //
  // Container'ı tablette büyütmek yerine, aynı boyutta bırakıp
  // KOLON SAYISINI artırıyoruz. Phone'da 3 sığan yere tablette 5 sığar.

  /// Normal grid/yatay liste kolon sayısı.
  /// phone dikey: 3, phone yatay: 4, tablet dikey: 5, tablet yatay: 6
  static int get gridColumns {
    if (isTablet) return isPortrait ? 5 : 6;
    return isPortrait ? 3 : 4;
  }

  /// Daha büyük kartlar için (ürün kartı vb.).
  /// phone dikey: 2, phone yatay: 3, tablet dikey: 3, tablet yatay: 4
  static int get gridColumnsLarge {
    if (isTablet) return isPortrait ? 3 : 4;
    return isPortrait ? 2 : 3;
  }

  /// Yatay listede (ListView) item genişliğini ekrana göre hesapla.
  /// Örn: phone'da 3 item görünsün → itemExtent(visible: 3).
  /// Tablette otomatik olarak daha fazla item görünür (aynı genişlikte).
  static double itemExtent({double? visiblePhone, double? visibleTablet}) {
    final count = isTablet ? (visibleTablet ?? 5) : (visiblePhone ?? 3);
    final spacing = gap * (count - 1);
    return (screenWidth - gridPadding * 2 - spacing) / count;
  }

  // ── Hazır sabitler (hepsi r() üzerinden, tek kaynak) ─────────────

  // Radius
  static double get radiusSmall => r(8);
  static double get radiusMedium => r(12);
  static double get radius => r(16);
  static double get radiusLarge => r(24);

  // Spacing / gap / padding (aynı ölçek, isim farkı okunabilirlik için)
  static double get spacingTiny => r(4);
  static double get spacingSmall => r(8);
  static double get spacingMedium => r(12);
  static double get spacing => r(16);
  static double get spacingLarge => r(24);
  static double get spacingHuge => r(32);

  static double get gapSmall => r(8);
  static double get gap => r(16);
  static double get gapLarge => r(24);

  static double get gridSpacing => r(12);
  static double get gridPadding => r(16);

  /// Ekran kenarı ile kartlar arasındaki yatay boşluk.
  static double get screenPadding => r(12);

  /// Kartların iç boşluğu.
  static double get cardPadding => r(12);

  /// Büyük (hero) kartların iç boşluğu.
  static double get cardPaddingLarge => r(16);

  // Font boyutları
  static double get fontTiny => sp(11);
  static double get fontSmall => sp(13);
  static double get fontNormal => sp(14);
  static double get fontMedium => sp(16);
  static double get fontLarge => sp(18);
  static double get fontExtraLarge => sp(21);

  // Icon boyutları
  static double get iconSmall => r(18);
  static double get iconNormal => r(24);
  static double get iconLarge => r(32);

  // Bileşen yükseklikleri (tıklama alanları en az 48 kalır)
  static double get buttonHeight => r(48);
  static double get textFieldHeight => r(52);
  static double get appBarHeight => isTablet ? r(64) : r(56);
  static double get bottomNavHeight => isTablet ? r(72) : r(60);
}

/// Kısa kullanım için extension: 16.dr, 16.dsp
extension DimensExt on num {
  /// responsive boyut
  double get dr => Dimens.r(toDouble());

  /// responsive font
  double get dsp => Dimens.sp(toDouble());
}
