class ROOK extends piece{
  
  public ROOK(PVector start, boolean side, PVector origin){
    super(start, side, "rook", origin);
  }
  
  @Override
  public void checkMoveables(){
    super.moveables.clear();
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
