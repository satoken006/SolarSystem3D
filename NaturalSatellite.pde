// ****** 衛星に関するクラス ******

class NaturalSatellite{
  // *----- スーパークラスのフィールド -----*
  // x, y, z : 衛星の位置座標
  Planet planet;
  
  NaturalSatellite(Planet p){
    this.planet = p;
  }
  
  void draw(){
    pushMatrix();
      PVector v = planet.getCoordinates();
      println(v);
      translate(v.x, v.y, v.z);
      rotateX(radians(frameCount));
      //translate(v.x + 100 * cos(radians(frameCount)), v.y + 100 * sin(radians(frameCount)), v.z + 100 * sin(radians(frameCount)));
      //println(p[3].x + ", " + p[3].y + ", " +  (p[3].z+100));
      fill(255);
      stroke(255);
      sphere(10);
    popMatrix();
  }
}
