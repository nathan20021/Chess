class QUEEN extends piece{
  
  public QUEEN(PVector start, boolean side, PVector origin){
    super(start, side, "queen", origin);
  }

  @Override
  public void checkMoveables(){
    
    super.moveables.clear();
    
    //----------------------------BISHOP's Code-----------------------------------
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
 
    //--------------------------ROOK's Code-------------------------------
    for(int t=0; t<4; t++){
      int delta_x = 0;
      int delta_y = 0;
      switch(t){
        // right
        case 0:
        delta_x = 1;
        delta_y = 0;
          break;
        //left
        case 1:
        delta_x = -1;
        delta_y = 0;
          break;
        //up
        case 2:
        delta_x = 0;
        delta_y = 1;
          break;
        //down
        case 3:
        delta_x = 0;
        delta_y = -1;
          break;
      }
      PVector to_check = new PVector(super.coor.x +delta_x, super.coor.y+delta_y);
      outer: while(true){
        if(to_check.x == -1 || to_check.x == 8){
          break outer;
        }
        if(to_check.y == -1 || to_check.y == 8){
          break outer;
        }
        for(abstractPieces single:super.abstractBoard){
          //If found a piece
          if(single.coor.x == to_check.x && single.coor.y == to_check.y){
           //If found an ally
           if(super.side == single.side){
            single.isGuard = true; 
            break outer;
           //If found enemy
           }else if(super.side != single.side){
             super.moveables.add(new PVector(to_check.x, to_check.y));
             if(single.name == 'k'){
              super.guardSquare = new PVector(to_check.x+delta_x, to_check.y+delta_y); 
              super.important.guardSquare = new PVector(to_check.x+delta_x, to_check.y+delta_y);
             }
           }
           break outer;
           
         }
        }
        super.moveables.add(new PVector(to_check.x, to_check.y));
        
        // Update the next coordinate to check
        to_check = new PVector(to_check.x+delta_x, to_check.y+delta_y);
      }
    }
  }
}
