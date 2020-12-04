class KING extends piece{

  ArrayList<abstractPieces> checkedBy = new ArrayList<abstractPieces>();
  
  public KING(PVector start, boolean side, PVector origin){
    super(start, side, "king", origin);
  }
  
  public void changeChecked(boolean _isChecked){
    this.isChecked = _isChecked;
    this.important.isChecked = _isChecked;
  }
  
  public void checkIfChecked(){
    for(abstractPieces enemy:enemies){
      for(PVector moveable:enemy.moveables){
        if(this.coor.x == moveable.x &&this.coor.y == moveable.y){
          this.changeChecked(true);
          checkedBy.add(enemy);
        }
      }
    }
  }
  
  public void checkCastling(){
    // Check to see if any allies is in the way
    if(super.firstMove == false){
        this.king_side = false;
        this.queen_side = false;
      }else{
      // queen-side
      //Check for ally within the castling range
      boolean allies_not_in_way = false;
      outer: for(int i=1;i<=3;i++){
        for(abstractPieces ally:super.allies){
          if(ally.coor.x == i&&ally.coor.y==super.coor.y){
            allies_not_in_way = false;
            break outer;
          }
        }
        allies_not_in_way = true;
      }
      //Check for enemies within the castling range
      outer: for(int i=1;i<=3;i++){
        for(abstractPieces enemy:super.enemies){
          if(enemy.coor.x == i&&enemy.coor.y==super.coor.y){
            this.queen_side = false;
            break outer;
          }
        }
        this.queen_side = true;
      }
      
      //Check for the rook
      boolean checkRook = false;
      outer: for(abstractPieces single:this.allies){  
        if(single.name=='r' && single.coor.x == 0){
          if(single.firstMove == false){
            checkRook = false;
            break outer;
          }else{
           checkRook = true;
           break outer;
          }
        }
        checkRook = false;
      }
      
      //Check for snipper
      boolean safeFromSnipped = true;
      outer: for(abstractPieces enemy:enemies){
        for(PVector _moveable:enemy.moveables){
           for(int i=1;i<=3;i++){
            if(_moveable.x==i &&_moveable.y==super.coor.y){
              safeFromSnipped = false;
              break outer;
            }
           }
        }
        safeFromSnipped = true;
      }
      
      if(this.queen_side && checkRook && safeFromSnipped && super.isChecked == false && allies_not_in_way){
       this.queen_side = true; 
      }else{
       this.queen_side = false; 
      }
      //King side
      //Check for allies within the castling range
      allies_not_in_way = false;
      outer: for(int i=5;i<=6;i++){
        for(abstractPieces ally:super.allies){
          if(ally.coor.x == i && ally.coor.y==super.coor.y){
            allies_not_in_way = false;
            break outer;
          }
        }
        allies_not_in_way = true;
      }
      //Check for enemies within the castling range
      outer: for(int i=5;i<=6;i++){
        for(abstractPieces enemy:super.enemies){
          if(enemy.coor.x == i && enemy.coor.y==super.coor.y){
            this.king_side = false;
            break outer;
          }
        }
        this.king_side = true;
      }
      //Check for the rook
      checkRook = false;
      outer: for(abstractPieces single:this.allies){  
        if(single.name=='r' && single.coor.x == 7){
          if(single.firstMove == false){
            checkRook = false;
            break outer;
          }else{
           checkRook = true;
           break outer;
          }
        }
        checkRook = false;
      }
      
      safeFromSnipped = true;
      outer: for(abstractPieces enemy:enemies){
        for(PVector _moveable:enemy.moveables){
           for(int i=5;i<=6;i++){
            if(_moveable.x==i &&_moveable.y==super.coor.y){
              safeFromSnipped = false;
              break outer;
            }
           }
        }
        safeFromSnipped = true;
      }
      
      if(this.king_side && checkRook &&safeFromSnipped && super.isChecked == false && allies_not_in_way){
       this.king_side = true; 
      }else{
       this.king_side = false; 
      }
    }
  }
  
  @Override
  public void showChecked(){
    noStroke();
    fill(255,100,100);
    if(super.POV == 1){
      rect(super.origin.x+((super.coor.x)*70), super.origin.y+((super.coor.y)*70), 70,70);
    }else{
      rect(super.origin.x+((super.coor.x+1)*70*POV),super.origin.y+((super.coor.y+1)*70*POV),70,70);
    }
  }
  
  public void checkMoveables(){
    
    super.moveables.clear();
    
    if(this.queen_side){
     super.moveables.add(new PVector(2,super.coor.y));
    }
    if(this.king_side){
     super.moveables.add(new PVector(6,super.coor.y));
    }
    for(int a=(int)super.coor.x-1; a<=(int)super.coor.x+1; a++){
      outer: for(int b=(int)super.coor.y-1; b<=(int)super.coor.y+1; b++){
        if((a==(int)this.coor.x && b==(int)this.coor.y) || (a<0||a>7) ||(b<0||b>7)){
          continue outer;
        }
        for(abstractPieces single:abstractBoard){
          PVector _coor = single.coor;
          if(a== (int)_coor.x && b==(int)_coor.y){
            if(this.side!=single.side){
              //If the king is near by an enemy piece:
              if(single.isGuard == false){
                this.moveables.add(new PVector(a,b));
              }
            }else{
              single.isGuard = true;
            }
            continue outer;
          }
        }
        this.moveables.add(new PVector(a,b));
      }
    }
    
    //Remove Invalid King's moves
    outer: for(abstractPieces enemy:enemies){
      if(enemy.name == 'p'){
         for(int i=0; i<this.moveables.size(); i++){
           PVector king_moveable = this.moveables.get(i);
           if(king_moveable.x==(enemy.coor.x+1)&&king_moveable.y==enemy.coor.y+enemy.dir){
             this.moveables.remove(i);
           }
           if(king_moveable.x==(enemy.coor.x-1)&&king_moveable.y==enemy.coor.y+enemy.dir){
             this.moveables.remove(i);
           }
         }        
       continue outer; 
      }
      
     for(int i=0; i<this.moveables.size(); i++){
       PVector king_moveable = this.moveables.get(i);
       if(king_moveable.x==enemy.guardSquare.x&&king_moveable.y==enemy.guardSquare.y){
         this.moveables.remove(i);
       }
     }
     for(PVector moveable:enemy.moveables){
       for(int i=0; i<this.moveables.size(); i++){
         PVector king_moveable = this.moveables.get(i);
         if(moveable.x == king_moveable.x && moveable.y == king_moveable.y){
           this.moveables.remove(i);
         }
       }
       
     }
    }
    
  }
  
}
