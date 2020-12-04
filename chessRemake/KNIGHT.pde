class KNIGHT extends piece{
  
  public KNIGHT(PVector start, boolean side, PVector origin){
    super(start, side, "knight", origin);
  }
  
  @Override
  
  public void checkMoveables(){
    super.moveables.clear();
   for(int a=0; a<8;a++){
    int delta_x = 0;
    int delta_y = 0;
    switch(a){
      case 0:
        delta_x = -1;
        delta_y = -2;
        break;
      case 1:
        delta_x = +1;
        delta_y = -2;
        break;
      case 2:
        delta_x = +2;
        delta_y = -1;
        break;
      case 3:
        delta_x = +2;
        delta_y = +1;
        break;
      case 4:
        delta_x = +1;
        delta_y = +2;
        break;
      case 5:
        delta_x = -1;
        delta_y = +2;
        break;
      case 6:
        delta_x = -2;
        delta_y = +1;
        break;
      case 7:
        delta_x = -2;
        delta_y = -1;
        break;
    }
    //Check in board
    if((this.coor.x+delta_x<8&&super.coor.x+delta_x>=0)&&(super.coor.y+delta_y<8&&super.coor.y+delta_y>=0)){
      //Loop through abstract Board for enemies and allies
      boolean normal = true;
      for(abstractPieces _single:super.abstractBoard){
        //If there is a piece there
        if(_single.coor.x==(super.coor.x+delta_x)&&_single.coor.y==(super.coor.y+delta_y)){
          //Check side
          if(this.side!= _single.side){
            //If enemy then add into moveables
           super.moveables.add(new PVector(super.coor.x+delta_x, super.coor.y+delta_y));
           normal = false;
           break;
           //If ally then set isGuard to true
         }else if(super.side == _single.side){
           _single.isGuard = true;
           normal = false;
           break;
         }
        }
      }
      if(normal){
        super.moveables.add(new PVector(super.coor.x+delta_x, super.coor.y+delta_y));
      }
    }
     
   }
  }
  
  
}
