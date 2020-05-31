//set avatar init path, load img
void setAvatar(){
  for(int i = 0; i<8;i++){
    images[i] = loadImage(path[i]);
  }
    imageMode(CENTER);
    //------------------- to do
    image(images[0],220,200);
    image(images[1],440,200);
    image(images[2],680,200);
    image(images[3],125,320);
    image(images[4],380, 320);
    image(images[5],600, 320);
    image(images[6],850, 200); //extra 1
    image(images[7],840, 320); // extra 2
  //}
}
