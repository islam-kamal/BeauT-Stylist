// TODO: Should be done from remote configs
ColorThemeConfigs lightTheme = ColorThemeConfigs.fromJson({
  "primary": "0xFFF51625",
  "secondary": "0xFFF51625",
  "text-head": "0xff000000",
  "text-body": "0xffb2b2b2",
  "border": "0xffeeeeee",
  "surface-bright": "0xffffffff",
  "surface-dim": "0xfff9f9f9",
  "service-errands": "0xFF3CB4AD",
  "service-food": "0xFFEB3649",
  "service-shop": "0xFF00A9FE",
  "service-pet": "0xFFFFAE3C"
});

ColorThemeConfigs darkTheme = ColorThemeConfigs.fromJson({
  "primary": "0xFFF51625",
  "secondary": "0xFFF51625",
  "text-head": "0xffffffff",
  "text-body": "0xFF6D6D6D",
  "border": "0xFF272437",
  "surface-bright": "0xff1F1C2F",
  "surface-dim": "0xff151424",
  "service-errands": "0xFF3CB4AD",
  "service-food": "0xFFEB3649",
  "service-shop": "0xFF00A9FE",
  "service-pet": "0xFFFFAE3C"
});

class ColorThemeConfigs {
  int _primary;
  int _secondary;
  int _textHead;
  int _textBody;
  int _border;
  int _surfaceBright;
  int _surfaceDim;
  int _serviceErrands;
  int _servicefood;
  int _serviceShop;
  int _servicePet;

  ColorThemeConfigs(
      {int primary,
      int secondary,
      int textHead,
      int textBody,
      int border,
      int surfaceBright,
      int surfaceDim,
      int serviceErrands,
      int servicefood,
      int serviceShop,
      int servicePet}) {
    this._primary = primary;
    this._secondary = secondary;
    this._textHead = textHead;
    this._textBody = textBody;
    this._border = border;
    this._surfaceBright = surfaceBright;
    this._surfaceDim = surfaceDim;
    this._serviceErrands = serviceErrands;
    this._servicefood = servicefood;
    this._serviceShop = serviceShop;
    this._servicePet = servicePet;
  }

  int get primary => _primary;

  int get secondary => _secondary;

  int get textHead => _textHead;

  int get textBody => _textBody;

  int get border => _border;

  int get surfaceBright => _surfaceBright;

  int get surfaceDim => _surfaceDim;

  int get serviceErrands => _serviceErrands;

  int get servicefood => _servicefood;

  int get serviceShop => _serviceShop;

  int get servicePet => _servicePet;

  ColorThemeConfigs.fromJson(Map<String, dynamic> json) {
    _primary = int.parse(json['primary']);
    _secondary = int.parse(json['secondary']);
    _textHead = int.parse(json['text-head']);
    _textBody = int.parse(json['text-body']);
    _border = int.parse(json['border']);
    _surfaceBright = int.parse(json['surface-bright']);
    _surfaceDim = int.parse(json['surface-dim']);
    _serviceErrands = int.parse(json['service-errands']);
    _servicefood = int.parse(json['service-food']);
    _serviceShop = int.parse(json['service-shop']);
    _servicePet = int.parse(json['service-pet']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['primary'] = this._primary;
    data['secondary'] = this._secondary;
    data['text-head'] = this._textHead;
    data['text-body'] = this._textBody;
    data['border'] = this._border;
    data['surface-bright'] = this._surfaceBright;
    data['surface-dim'] = this._surfaceDim;
    data['service-errands'] = this._serviceErrands;
    data['service-food'] = this._servicefood;
    data['service-shop'] = this._serviceShop;
    data['service-pet'] = this._servicePet;
    return data;
  }
}
