class PAWN extends piece{
  
  public PAWN(PVector start, boolean side, PVector origin){
    super(start, side, "pawn", origin);
  }
  
  
  @Override
  public void checkMoveables(){
    super.moveables.clear();
    // Check for forward move
    if(super.firstMove){
      super.moveables.add(new PVector(super.coor.x,super.coor.y+this.dir));
      super.moveables.add(new PVector(super.coor.x,super.coor.y+(this.dir*2)));
    }else{
      if(super.coor.y+this.dir<8&&super.coor.y+this.dir>=0){
        super.moveables.add(new PVector(super.coor.x,super.coor.y+this.dir));
      }
    }
    
    //remove invalid forward moves
    outer: for(int i=0; i<super.moveables.size(); i++){
      PVector moveable = super.moveables.get(i);
     for(abstractPieces enemy:super.enemies){     
      if(moveable.x==enemy.coor.x&&moveable.y==enemy.coor.y){
        super.moveables.remove(i);
        if(this.firstMove && enemy.coor.y == super.coor.y+(this.dir)){
          super.moveables.clear();
        }
        break outer;
      }
     }
    }
    
    PVector toCheck = new PVector(super.coor.x-1, super.coor.y+this.dir);
    for(abstractPieces enemy:enemies){
     if(enemy.coor.x==toCheck.x&&enemy.coor.y==toCheck.y){
      super.moveables.add(new PVector(toCheck.x, toCheck.y)); 
     }
    }
    
    toCheck = new PVector(super.coor.x+1, super.coor.y+this.dir);
    for(abstractPieces enemy:enemies){
     if(enemy.coor.x==toCheck.x&&enemy.coor.y==toCheck.y){
      super.moveables.add(new PVector(toCheck.x, toCheck.y)); 
     }
    }
  }
}
