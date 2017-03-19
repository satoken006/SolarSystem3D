// ****** 惑星に関するクラス ******

class Planet extends PVector {
  // *----- ポリゴン生成に関するフィールド -----*
  // ポリゴン数
  final int ptsW = 30, ptsH = 30;
  // ポリゴンの頂点の数
  int numPointsW;
  int numPointsH_2pi; 
  int numPointsH;
  // ポリゴンの頂点座標
  float[] coorX;
  float[] coorY;
  float[] coorZ;
  float[] multXZ;
  // テクスチャ画像格納用
  PImage img;  

  // *----- 惑星の挙動に関するフィールド -----*
  // 軌道長半径
  float orbitR;
  // 公転周期
  float revolutionCycle;
  // 軌道傾斜角、軌道を傾斜させる向き
  float orbitInc, incDir;
  // 赤道傾斜角
  float equatorInc;
  // 環の太さ
  float ring;
  // 環の色
  color c;
  // 惑星と衛星との距離(衛星の数ぶんの配列)
  float[] distance, rotX, rotY, rotZ, speed;
  // 衛星の数
  int SATELLITE_NUM; 
  //自転させるかどうか
  boolean isRotating;

  // コンストラクタ
  Planet( Property p ) {
    super(p.diam * p.oblateness, p.diam * p.oblateness, p.diam);
    img=loadImage(p.img_file);
    orbitR = p.orbit_radius;
    revolutionCycle = p.revolution_cycle;
    orbitInc = p.orbit_inc;
    // Z軸に関して軌道を回転させるので、惑星の初期位置もランダムになります
    incDir = random(360);
    equatorInc = p.equator_inc;
    ring = p.ring;
    c = color(p.c.getRed(), p.c.getGreen(), p.c.getBlue(), 204);
    isRotating = p.is_rotating;
    //衛星の設定
    //SATELLITE_NUM = p.satellite;
    distance = new float[SATELLITE_NUM];
    rotX = new float[SATELLITE_NUM];
    rotY = new float[SATELLITE_NUM];
    rotZ = new float[SATELLITE_NUM];
    speed = new float[SATELLITE_NUM];
    for( int i = 0 ; i < SATELLITE_NUM ; i ++ ){
      distance[i] = random(60, 80);
      rotX[i] = random(60, 80);
      rotY[i] = random(60, 80);
      rotZ[i] = random(60, 80);
      speed[i] = random(0.5, 3);
    }
  }

  // ****** ポリゴン生成 ******
  void initializeFields() {
    numPointsW=ptsW+1;
    numPointsH_2pi=ptsH;
    numPointsH=ceil((float)numPointsH_2pi/2)+1;

    coorX=new float[numPointsW];
    coorY=new float[numPointsH];
    coorZ=new float[numPointsW];
    multXZ=new float[numPointsH];

    for (int i=0; i<numPointsW; i++) {
      float thetaW=i*2*PI/(numPointsW-1);
      coorX[i]=sin(thetaW);
      coorZ[i]=cos(thetaW);
    }

    for (int i=0; i<numPointsH; i++) {
      if (int(numPointsH_2pi/2) != (float)numPointsH_2pi/2 && i==numPointsH-1) {
        float thetaH=(i-1)*2*PI/(numPointsH_2pi);
        coorY[i]=cos(PI+thetaH); 
        multXZ[i]=0;
      } else {
        float thetaH=i*2*PI/(numPointsH_2pi);

        coorY[i]=cos(PI+thetaH); 
        multXZ[i]=sin(thetaH);
      }
    }
  }

  float posX, posY, posZ;

  // ****** 天体描画 ******
  void draw() {
    // 公転軌道
    noFill();
    stroke(255, 51);
    strokeWeight(1);
    pushMatrix();
    rotateZ(radians(incDir));
    rotateX(radians(orbitInc * intensity));
    ellipse(0, 0, orbitR * 2, orbitR * 2 );
    // 惑星 
    stroke(255, 0);
    pushMatrix();
    float theta = frameCount / (float)revolutionCycle; 
    posX = orbitR * cos(radians(theta));
    posY = orbitR * sin(radians(theta));
    posZ = 0;
    translate(posX, posY, posZ);
    float changeU=img.width/(float)(numPointsW-1); 
    float changeV=img.height/(float)(numPointsH-1); 
    float u=0;
    float v=0;
    // 画像が逆さまなので正しい向きに修正、赤道を傾ける
    rotateX(radians(-90 - equatorInc));
    // 天体を自転させる
    if( isRotating ){
      rotateY(radians(frameCount));
    }

    // 天体のテクスチャを行う
    beginShape(TRIANGLE_STRIP);
    texture(img);
    for (int i=0; i< numPointsH-1; i++) {  // 両極意外の全てのリングに対してテクスチャ
      float coory=coorY[i];
      float cooryPlus=coorY[i+1];

      float multxz=multXZ[i];
      float multxzPlus=multXZ[i+1];

      for ( int j = 0; j < numPointsW; j ++ ) {
        normal(coorX[j] * multxz, coory, coorZ[j] * multxz);
        vertex(coorX[j] * multxz * this.x, coory * this.y, coorZ[j] * multxz * this.z, u, v);
        normal(coorX[j] * multxzPlus, cooryPlus, coorZ[j] * multxzPlus);
        vertex(coorX[j] * multxzPlus * this.x, cooryPlus * this.y, coorZ[j] * multxzPlus * this.z, u, v+changeV);
        u+=changeU;
      }
      v+=changeV;
      u=0;
    }
    endShape();
    // 木星型惑星には環を追加
    rotateX(HALF_PI);
    noFill();
    stroke(c);
    strokeWeight(ring);
    ellipse(0, 0, x * 4, x * 4);
    popMatrix();
    popMatrix();
  }
  
  // ****** 惑星の(X, Y, Z)座標を取得 ******
  PVector getCoordinates() {
    return new PVector(posX, posY, posZ);
  }
}

