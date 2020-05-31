//set avatar init path, load img
void initAvatar(){
    image_pos[0] = new PVector(220,200);
    image_pos[1]= new PVector(440,200);
    image_pos[2]= new PVector(680,200);
    image_pos[3]= new PVector(850, 200); 
    image_pos[4]= new PVector(125,320);
    image_pos[5]= new PVector(380, 320);
    image_pos[6]= new PVector(600, 320);
    image_pos[7]= new PVector(840, 320); 
}

void setAvatar(){
  for(int i = 0; i<8;i++){
    images[i] = loadImage(path[i]);
    imageMode(CENTER);
    image(images[i],image_pos[i].x,image_pos[i].y);
  }
}

void changeAva(int s){
  images[s] = loadImage(path[s].substring(0, 11) + "c"+ ".png");
  image(images[s], image_pos[s].x, image_pos[s].y);
}
