class piece{
  
  PVector coor = new PVector();
  PVector real_coor = new PVector();
  PVector origin;
  abstractPieces important;
  abstractPieces pinnedBy;
  ArrayList<PVector> moveables = new ArrayList<PVector>();
  ArrayList<abstractPieces> abstractBoard = new ArrayList<abstractPieces>();
  ArrayList<abstractPieces> allies = new ArrayList<abstractPieces>();
  ArrayList<abstractPieces> enemies = new ArrayList<abstractPieces>();
  PVector guardSquare = new PVector(-1,-1);
  boolean isChecked = false;
  boolean side; //0 black 1 white
  boolean ischose = false;
  boolean isGuard = false;
  boolean firstMove = true;
  boolean castleable = false;
  boolean toMove = false;
  PImage sprite;
  String name;
  String sprite_name = "../sprites/";
  float scale = 70* 85/100;
  boolean king_side = false;
  boolean queen_side = false;
  int POV = 1;
  int dir = 0;
  
  public piece(){
  }
  
  public piece(PVector start, boolean side, String name, PVector origin){
    this.coor = start;
    this.side = side;
    this.name = name;

    if(this.side == true){
      this.sprite_name += "w";
    }else{
      this.sprite_name += "b";
    }
    this.sprite_name += this.name+".png";
    this.sprite = loadImage(this.sprite_name);
    this.origin = origin;
    if(this.side == true){
     this.dir = -1; 
    }else{
     this.dir = 1; 
    }
    important = new abstractPieces(this.coor, this.side, this.name, this.moveables, this.isGuard, this.isChecked, this.ischose, this.guardSquare, this.firstMove, this.castleable, this.dir, this.pinnedBy);
  }
  
  public void calc(){
    if(this.POV == 1){
      this.real_coor.x = this.origin.x+((this.coor.x)*70)+(70*8/100);
      this.real_coor.y = this.origin.y+((this.coor.y)*70)+(70*10/100);
    }else{
      this.real_coor.x = this.origin.x-((this.coor.x+1)*70)+(70*8/100);
      this.real_coor.y = this.origin.y-((this.coor.y+1)*70)+(70*10/100);      
    }
  }
  
  public void show(){
   this.calc();
   if(this.ischose){
     this.showMoveables();
     this.checkMoveables();
     strokeWeight(20);
     point(this.origin.x+(70*(coor.x+0.5)*POV), this.origin.y+(70*(coor.y+0.5))*POV);
     imageMode(CENTER);
   }else{
     imageMode(CORNER);
     image(this.sprite, this.real_coor.x, this.real_coor.y, this.scale, this.scale);
   }
  }
  
  public void checkMoveables(){}
  public void showChecked(){}
  
  public void removePiece(Board board){
    this.firstMove = false;
    this.important.firstMove = false;
    board.all.remove(this);
    board.abstractBoard.remove(this.important);
    for(piece single:board.all){
      single.initAbstractBoard(board.all);
    }
  }
  
  public void showMoveables(){
    noFill();
    stroke(0);
    strokeWeight(3);
    for(PVector square:moveables){ 
      if(this.POV==1){
        rect(this.origin.x+(70*square.x*POV), this.origin.y+(70*square.y*POV), 70,70); 
      }else{
        rect(this.origin.x-(70*(square.x+1)), this.origin.y-(70*(square.y+1)), 70,70);
      }
    }
  }
  
  public void move(PVector _coor, Board board){
    for(PVector __coor : moveables){
      if(_coor.x == __coor.x &&_coor.y == __coor.y){
        this.coor = _coor;
        this.important.coor = _coor;
        this.firstMove = false;
        this.important.firstMove = false;
        for(abstractPieces single:abstractBoard){
          single.isGuard = false;
        }
        break;
      }
    }   
    for(abstractPieces enemy:this.enemies){
      if(this.coor.x==enemy.coor.x&&this.coor.y==enemy.coor.y&&enemy.ischose==false){
        board.removePiece(enemy.coor);
        break;
      }
    }      
  }
  
  public void checkIfPinned(){
    for(abstractPieces _enemy : this.enemies){
      if(_enemy.name == 'q'|_enemy.name == 'r'|_enemy.name == 'b'){
        for(PVector _moveable: _enemy.moveables){
          if(_moveable.x == this.coor.x && _moveable.y == this.coor.y){
           
            // find its king location:
            PVector king_coor = new PVector(-1,-1);
            for(abstractPieces _ally :this.allies){
              if(_ally.name =='k'){
                king_coor.x = _ally.coor.x;
                king_coor.y = _ally.coor.y;
              }
            }
            // Check if there are any pieces between the king and that piece
            // rook First:
            
            // First check if the piece, rook and the king is co-linear
            if(_enemy.name == 'r'){
              boolean coLinear = false;
              outer: for(int i = 0; i <2; i++){
               switch(i){
                 case 0:
                 // Check in x direction
                 if(_enemy.coor.x == this.coor.x && this.coor.x == king_coor.x){
                   coLinear = true;
                   break outer;
                 }
                 break;
                 case 1:
                 // Check in y direction
                 if(_enemy.coor.y == this.coor.y && this.coor.y == king_coor.y){
                   coLinear = true;
                   break outer;
                 }
                 break;
                 
               }
              }
            }
            
            
            
          }
        }
      }
    }
  }
  
  public void initAbstractBoard(ArrayList<piece> _all){
    this.abstractBoard.clear();
    this.enemies.clear();
    this.allies.clear();
    for(piece single:_all){
      this.abstractBoard.add(single.important);
      if(single.side!=this.side){
       enemies.add(single.important);
      }else{
        allies.add(single.important);
      }
    }
  }
  
}
