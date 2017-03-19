/** 
 *  制作物 : 太陽系の模倣 3D Ver.
 *  天体の距離比、直径比は圧縮してあります  
 *  見栄えを考慮しているため、自転周期は実際のものとは異なります 
 */

Planet[] p;
int ANGLE_HORIZONTAL = 0, ANGLE_VERTICAL = 30;
int zoom = 600;
int intensity = 1;

void setup() {
  size(640, 640, P3D);
  frameRate(30);
  background(0);
  noFill();
  
  // 惑星オブジェクトのインスタンス化
  p = new Planet[Property.values().length];
  for( int i = 0 ; i < p.length ; i ++ ){
    p[i] = new Planet(Property.values()[i]);
    p[i].initializeFields();
  }
  frameRate(60);
}

void draw() {
  background(0);
  camera(zoom * cos(radians(ANGLE_HORIZONTAL)), zoom * sin(radians(ANGLE_HORIZONTAL)), zoom * 5f/3 * sin(radians(ANGLE_VERTICAL)), 0, 0, 0, 0, 0, -1);
  for( Planet q : p ){
    if( q.equals( p[1] ) ){
      pointLight(255, 255, 255, 0, 0, 105);
    } 
    q.draw();
  }
}

// ****** マウスドラッグによってカメラの視点を変更することが可能です ******
void mouseDragged(){
  ANGLE_HORIZONTAL += (pmouseX - mouseX) * 0.15;
  ANGLE_VERTICAL += (pmouseY - mouseY) * 0.15;
  if( ANGLE_VERTICAL < 0 ){
    ANGLE_VERTICAL = 0;
  }else if( ANGLE_VERTICAL > 85 ){
    ANGLE_VERTICAL = 85;
  }
}

// ****** キー操作 ******
// a : 公転軌道傾斜角を増加  d : 公転軌道傾斜角
// UP, DOWN, LEFT, RIGHT : カメラ視点移動(マウスドラッグ操作により代替できます)   
void keyPressed(){
  switch( key ){
    case 'a':
      intensity --;
      intensity = max(intensity, 1);
      break;
    case 'd':
      intensity ++;
  }
  switch( keyCode ){
    case UP:
      if( ANGLE_VERTICAL < 85 )
        ANGLE_VERTICAL ++;
      break;
    case DOWN:
      if( ANGLE_VERTICAL > 0 )
        ANGLE_VERTICAL --;
      break;
    case LEFT:
      ANGLE_HORIZONTAL ++;
      break;
    case RIGHT:
      ANGLE_HORIZONTAL --;
      break;
  }
}

// ****** マウスホイールをスクロールさせることでズームイン・ズームアウトが可能です ******
void mouseWheel(processing.event.MouseEvent e){
  zoom += e.getCount() * 10;
  zoom = min(1020, zoom);
}