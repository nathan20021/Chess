class Board{
  
  //All the pieces
  QUEEN bqueen;
  QUEEN wqueen;
  
  ROOK brook1;
  ROOK wrook1;
  ROOK brook2;
  ROOK wrook2;
  
  KNIGHT bk1;
  KNIGHT wk1;
  KNIGHT bk2;
  KNIGHT wk2;
  
  BISHOP bb1;
  BISHOP wb1;
  BISHOP bb2;
  BISHOP wb2;
  
  KING bking;
  KING wking;
  
  //Atributes
  ArrayList<piece> whitePieces = new ArrayList<piece>();
  ArrayList<piece> blackPieces = new ArrayList<piece>();
  ArrayList<piece> all = new ArrayList<piece>();
  ArrayList<abstractPieces> abstractBoard = new ArrayList<abstractPieces>();
  ArrayList<PVector> highlight = new ArrayList<PVector>();
  ArrayList<PVector> starts = new ArrayList<PVector>();
  ArrayList<PVector> ends = new ArrayList<PVector>();
  //1 for white POV and -1 for black POV
  int POV = 1;
  PVector origin;
  PVector borigin;
  int scale;
  int offSet;
  final int size = 8;
  char[] letters = {'A','B','C','D','E','F','G','H'};
  
  public Board(PVector _origin, int _scale){
    this.origin = _origin;
    this.scale = _scale;
  }
  
  private void draw_head(float _startx, float _starty,float _endx, float _endy){
    pushMatrix();
    translate(_endx, _endy);
    if(_startx == _endx){
      if(_starty<_endy){
        rotate(-3*PI/4);
      }else{
        rotate(PI/4);
      }
    }else{
      if(_starty<_endy){
        rotate(-radians(135) - (atan((_startx-_endx)/(_starty-_endy))) );
      }
      else{
        rotate(radians(45) - (atan((_startx-_endx)/(_starty-_endy))) );
      }
    }
    triangle(0,0,0,4,4,0);
    popMatrix();
  }
  
  public void init(){
    this.borigin = new PVector(this.origin.x+(8*this.scale), this.origin.y+(8*this.scale));
    brook1 = new ROOK(new PVector(0,0), false, origin);
    blackPieces.add(brook1);
    bk1 = new KNIGHT(new PVector(1,0), false, origin);
    blackPieces.add(bk1);
    bb1 = new BISHOP(new PVector(2,0), false, origin);
    blackPieces.add(bb1);
    bqueen = new QUEEN(new PVector(3,0), false, origin);
    blackPieces.add(bqueen);
    bking = new KING(new PVector(4,0), false, origin);
    blackPieces.add(bking);
    bb2 = new BISHOP(new PVector(5,0), false, origin);
    blackPieces.add(bb2);
    bk2 = new KNIGHT(new PVector(6,0), false, origin);
    blackPieces.add(bk2);
    brook2 = new ROOK(new PVector(7,0), false, origin);
    blackPieces.add(brook2);
    for(int i=0; i<8; i++){
     blackPieces.add(new PAWN(new PVector(i,1), false,origin));
    }
    
    wrook1 = new ROOK(new PVector(0,7), true, origin);
    whitePieces.add(wrook1);
    wk1 = new KNIGHT(new PVector(1,7), true, origin);
    whitePieces.add(wk1);
    wb1 = new BISHOP(new PVector(2,7), true, origin);
    whitePieces.add(wb1);
    wqueen = new QUEEN(new PVector(3,7), true, origin);
    whitePieces.add(wqueen);
    wking = new KING(new PVector(4,7), true, origin);
    whitePieces.add(wking);
    wb2 = new BISHOP(new PVector(5,7), true, origin);
    whitePieces.add(wb2);
    wk2 = new KNIGHT(new PVector(6,7), true, origin);
    whitePieces.add(wk2);
    wrook2 = new ROOK(new PVector(7,7), true, origin);
    whitePieces.add(wrook2);
    for(int i=0; i<8; i++){
     whitePieces.add(new PAWN(new PVector(i,6), true,origin)); 
    }
    
    this.all.addAll(blackPieces);
    this.all.addAll(whitePieces);
    //this.updateCoors(); 
    for(piece single:all){
      this.abstractBoard.add(single.important);
      single.checkMoveables(); 
      single.initAbstractBoard(all);
      single.checkMoveables();
      if(single.side == true){
       single.toMove = true; 
      }
    }

  }
  
  public void flip(){
    PVector temp = new PVector(this.origin.x, this.origin.y);
    this.origin = new PVector(this.borigin.x, this.borigin.y);
    this.borigin = new PVector(temp.x, temp.y);
    if(this.POV == 1){
      this.POV = -1;
      for(piece single:this.all){
       single.origin = new PVector(this.origin.x ,this.origin.y); 
       single.POV = -1;
      }
    }else{
      this.POV = 1;
      for(piece single:this.all){
       single.origin = new PVector(this.origin.x ,this.origin.y); 
       single.POV = 1;
      }
    }
  }
  
  public void showHighlights(){
   fill(255,50,50,200); 
   for(PVector square:this.highlight){
     if(POV == 1){
        rect(this.origin.x+(square.x*this.scale*POV),this.origin.y+(square.y*this.scale*POV),this.scale,this.scale); 
     }else{
       rect(this.origin.x+((square.x+1)*this.scale*POV),this.origin.y+((square.y+1)*this.scale*POV),this.scale,this.scale); 
     }
   }
  }

  public void king_side_castle(boolean _side){
    for(piece single:this.all){
      if(single.side==_side && single.name == "king"){
        for(piece king_rook:this.all){
          if(king_rook.side==_side && king_rook.coor.x == 7 && king_rook.name=="rook"){
            king_rook.coor = new PVector(5,single.coor.y);
            single.coor = new PVector(6,single.coor.y);
            king_rook.important.coor = king_rook.coor;
            king_rook.checkMoveables();
            single.important.coor = single.coor;
            single.checkMoveables();
          }
        }
      }
    }
    
  }
  
  public void queen_side_castle(boolean _side){
    for(piece king:this.all){
      if(king.side==_side && king.name == "king"){
        for(piece queen_rook:this.all){
          if(queen_rook.side==_side && queen_rook.coor.x == 0 && queen_rook.name=="rook"){
            queen_rook.coor = new PVector(3,king.coor.y);
            king.coor = new PVector(2,king.coor.y);
            queen_rook.important.coor = queen_rook.coor;
            queen_rook.checkMoveables();
            king.important.coor = king.coor;
            king.checkMoveables();
          }
        }
      }
    }
  }
  
  public void removePiece(PVector location){
    outer: for(piece _single:this.all){
      if(_single.coor.x==location.x&&_single.coor.y==location.y&&_single.ischose==false){
        
       for(abstractPieces _abstractSingle:abstractBoard){
         if(_abstractSingle.coor.x==location.x &&_abstractSingle.coor.y==location.y&&_abstractSingle.ischose==false){
           this.abstractBoard.remove(_abstractSingle);
           this.all.remove(_single);
           break outer;
         }
       }
     }
   }
    
    //update after removing
    for(piece single:this.all){
      single.abstractBoard.clear();
      single.initAbstractBoard(this.all);
    }
  }
  
  public void show(){ 
    noStroke();
    for(int i = 0; i<this.size; i++){
      for(int j=0; j<this.size; j++){
        if(j==7){
          fill(0);
          textSize(22);
          textAlign(CENTER, TOP);
          if(this.POV == 1){
            text(letters[i], this.origin.x+(this.scale*(i+0.5)), this.origin.y+(this.scale*(j+1))+10); 
          }else{
            text(letters[7-i], this.borigin.x+(this.scale*(i+0.5)), this.borigin.y+(this.scale*(j+1))+10);
          }
        }
        if(i==0){
          fill(0);
          textSize(22);
          textAlign(RIGHT ,CENTER);
          if(this.POV == 1){
            text(8-j, this.origin.x+(this.scale*i)-10, this.origin.y+(this.scale*(j+0.5))); 
          }else{
            text(j+1, this.borigin.x+(this.scale*i)-10, this.borigin.y+(this.scale*(j+0.5))); 
          }
        }
        fill(#DDBA94);
        if( (i+j)%2 != 0){fill(#91502F);}
        if(POV == 1){
          rect(this.origin.x+(this.scale*i*POV), this.origin.y+(this.scale*j*POV), this.scale,this.scale); 
        }else{
         rect(this.origin.x+(this.scale*(i+1)*POV), this.origin.y+(this.scale*(j+1)*POV), this.scale,this.scale); 
        }
      }
    }
  }
  
  public void drawArrow(){
    stroke(81, 196, 117);
    noFill();
    strokeWeight(7);
    for(int i =0; i<this.starts.size(); i++){
      PVector _start = this.starts.get(i);
      PVector _end = this.ends.get(i);
        //Normal scenarios
      line(this.origin.x+(this.scale*(_start.x+0.5)*POV), this.origin.y+(this.scale*(_start.y+0.5)*POV), this.origin.x+(this.scale*(_end.x+0.5)*POV), this.origin.y+(this.scale*(_end.y+0.5)*POV));
      draw_head(this.origin.x+(this.scale*(_start.x+0.5)*POV), this.origin.y+(this.scale*(_start.y+0.5)*POV), this.origin.x+(this.scale*(_end.x+0.5)*POV), this.origin.y+(this.scale*(_end.y+0.5)*POV));
    }
    strokeWeight(0);
  }

}
