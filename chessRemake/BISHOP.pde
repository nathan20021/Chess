class BISHOP extends piece{
  
  public BISHOP(PVector start, boolean side, PVector origin){
    super(start, side, "bish", origin);
  }
  
  @Override
  public void checkMoveables(){
    super.moveables.clear();
    
    //check the top-right
    for(int a=0; a<4; a++){
      int delta_x = 0;
      int delta_y = 0;
      int sign_x = 0;
      int sign_y = 0;
      int limit;
      switch(a){
       case 0:
         delta_x = (int)abs(7-this.coor.x);
         delta_y = (int)abs(0-this.coor.y);
         sign_x = +1;
         sign_y = -1;
         break;
       case 1:
         delta_x = (int)abs(0-this.coor.x);
         delta_y = (int)abs(0-this.coor.y);
         sign_x = -1;
         sign_y = -1;
         break;
       case 2:
         delta_x = (int)abs(0-this.coor.x);
         delta_y = (int)abs(7-this.coor.y);
         sign_x = -1;
         sign_y = +1;
         break;
       case 3:
         delta_x = (int)abs(7-this.coor.x);
         delta_y = (int)abs(7-this.coor.y);
         sign_x = +1;
         sign_y = +1;
         break;
      }
      if(delta_x< delta_y){limit = delta_x;}
      else{limit = delta_y;}
      outer: for(int i=1; i<=limit; i++){
        for(abstractPieces single:abstractBoard){
          PVector _coor = single.coor;
          if(this.coor.x+(i*sign_x)==_coor.x &&this.coor.y+(i*sign_y)==_coor.y){
            if(single.side == this.side){
              single.isGuard = true;
            }
            for(abstractPieces enemy:enemies){
              //If there is an enemy
              if(this.coor.x+(i*sign_x)==enemy.coor.x && this.coor.y+(i*sign_y)==enemy.coor.y){
                super.moveables.add(new PVector(this.coor.x+(i*sign_x),this.coor.y+(i*sign_y)));
                if(enemy.name =='k'){
                  this.guardSquare = new PVector(this.coor.x+((i+1)*sign_x),this.coor.y+((i+1)*sign_y));
                  this.important.guardSquare = new PVector(this.coor.x+((i+1)*sign_x),this.coor.y+((i+1)*sign_y));
                }
                break;
              }
            }
            break outer; 
          }
        }
        super.moveables.add(new PVector(this.coor.x+(i*sign_x),this.coor.y+(i*sign_y))); 
      }
    }
    
    
  }
}
