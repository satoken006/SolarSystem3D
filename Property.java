// ****** 惑星の特徴量に関する列挙子 ******

import java.awt.*;

enum Property {
  /** フィールド一覧
   *  diam             | 惑星の直径
   *  orbit_radius     | 軌道長半径
   *  oblateness       | へん平率
   *  revolution_cycle | 公転周期
   *  orbit_inc        | 軌道の傾斜角
   *  equator_inc      | 地軸の傾斜角
   *  ring             | 環の太さ
   *  c                | 環の色
   *  satellite        | 衛星の数(本プログラムではインスタンス化に使用しません)
   *  is_rotating      | 自転しているかどうか
   *  img_file         | テクスチャ用の画像ファイル
   */
      SUN(  50f,   0f, 1f,   0.01f, 0f,         0f,      true, 0f,   Color.WHITE,       0, "sun.jpg"), 
  MERCURY(   8f, 100f, 1f,   0.24f, 7.004f,     0.027f,  true, 0f,   Color.WHITE,       0, "mercury.jpg"), 
    VENUS(  15f, 200f, 1f,   0.88f, 3.39471f, 177.36f,   true, 0f,   Color.WHITE,       0,  "venus.jpg"), 
    EARTH(  15f, 300f, 1f,   1f,    0.00005f,  23.4f,    true, 0f,   Color.WHITE,       1, "earth.jpg"), 
     MARS(  10f, 400f, 1f,   1.81f, 1.85061f,  25f,      true, 0f,   Color.WHITE,       2, "mars.jpg"), 
  JUPITER(  38f, 500f, 1f,  12f,    1.30530f,   3.08f,   true, 0.2f, Color.WHITE,      63, "jupiter.jpg"), 
   SATURN(  33f, 600f, 1f,  29f,    2.48446f,  26.7f,    true, 5f,   Color.LIGHT_GRAY, 64, "saturn.jpg"), 
   URANUS(  25f, 700f, 1f,  84f,    0.774f,    97.9f,    true, 1f,   Color.WHITE,      27, "uranus.jpg"), 
  NEPTUNE(  24f, 800f, 1f, 164.79f, 1.76917f,  29.6f,    true, 0.2f, Color.WHITE,      13, "neptune.jpg"), 
  //  PLUTO(   5f, 900f, 1f, 250f,    0f,       0f,      true, 0f,   Color.WHITE,       0, "pluto.jpg"),
    SPACE(1000f,   0f, 1f,   0.01f, 0f,       0f,       false, 0f,   Color.WHITE,       0, "space.jpg");

  float diam, orbit_radius, oblateness, revolution_cycle, orbit_inc, equator_inc, ring;
  Color c;
  int satellite;
  boolean is_rotating;
  String img_file;

  Property(float _diam, float _orbit_radius, float _oblateness, float _revolution_cycle, float _orbit_inc, float _equator_inc, boolean _is_rotating, float _ring, Color _c, int _satellite, String _img_file) {
    diam = _diam;
    orbit_radius = _orbit_radius;
    oblateness = _oblateness;
    revolution_cycle = _revolution_cycle;
    orbit_inc = _orbit_inc;
    equator_inc = _equator_inc;
    is_rotating = _is_rotating;
    ring = _ring;
    c = _c;
    satellite = _satellite;
    img_file = _img_file;
  }
}