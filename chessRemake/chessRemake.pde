//Object declaration
Board board;

//Variable declaration
int scale = 70;
PVector origin = new PVector(70,70);
PVector hover = new PVector(-1,-1);
PImage current;
PImage currentTurn;
PVector start = new PVector(-1,-1);
PVector end = new PVector(-1,-1);

void displayCurrentTurn(PImage king){
  imageMode(CORNER);
  image(king, 60,20,40,40);
  textAlign(LEFT,CENTER);
  fill(0);
  textSize(25);
  text("   to move", 80, 40);
}



void setup(){
  size(700,700);
  board = new Board(origin, scale);
  board.init();
}

void draw(){
  println(board.brook2.important.guardSquare);
  board.wk2.checkIfPinned(board.all); 
  background(211);
  
  if(board.wking.isChecked ==false){
   board.wking.checkedBy.clear(); 
  }
  if(board.bking.isChecked ==false){
    board.bking.checkedBy.clear(); 
  }
  if(board.wking.toMove){
    currentTurn = loadImage("../sprites/wking.png");
  }else{
    currentTurn = loadImage("../sprites/bking.png");
  }
  displayCurrentTurn(currentTurn);
  
  if(mouseX>min(board.origin.x, board.borigin.x)&&mouseX<max(board.origin.x, board.borigin.x)){
    if(mouseY>min(board.origin.y, board.borigin.y)&&mouseY<max(board.origin.y, board.borigin.y)){
     hover.x = (int) Math.floor(((board.origin.x*board.POV*-1) + (mouseX*board.POV))/board.scale); 
     hover.y = (int) Math.floor(((board.origin.y*board.POV*-1) + (mouseY*board.POV))/board.scale); 
     textAlign(CENTER);
     textSize(30);
     fill(0);
     text((int)hover.x, 10, 30);
     text((int)hover.y, 25, 30);
    }
  }
  board.show();
  board.showHighlights();
  for(piece single:board.all){
    if(single.name == "king"){
     if(single.isChecked){
       single.showChecked();
     }
  }
    single.show();
  }
  board.drawArrow();
  board.bking.checkCastling();
  board.wking.checkCastling();
  board.bking.checkIfChecked();
  board.wking.checkIfChecked();
  
  if(board.wking.isChecked){

  }
  for(piece single:board.all){
    if(single.ischose==true){
      current = loadImage(single.sprite_name);
      imageMode(CENTER);
      image(current, mouseX, mouseY, single.scale,single.scale);
    }
  }
  
}

void mousePressed(){
  if(mouseButton == RIGHT){
    start.x = hover.x;
    start.y = hover.y;
  }
  else if(mouseButton == LEFT){
    board.highlight.clear();
    board.starts.clear();
    board.ends.clear();
    for(piece single:board.all){
      single.ischose = false;
      if(single.coor.x == hover.x &&single.coor.y == hover.y){
        if(single.ischose == false){
          single.ischose = true;
          single.important.ischose = true;
          fill(0,0,0);
        }
      }
    }
  }
}

void mouseReleased(){
  if(mouseButton == RIGHT){
    end.x = hover.x;
    end.y = hover.y;
    if(start.x == end.x && start.y == end.y){
      boolean found = false;
      for(int i =0; i<board.highlight.size(); i++){
        PVector square = board.highlight.get(i);
        if(hover.x == square.x && hover.y == square.y){
           board.highlight.remove(i);
           found = true;
        }
      }if(!found){
        board.highlight.add(new PVector(hover.x, hover.y));
      } 
      start = new PVector(-1,-1);
      end = new PVector(-1,-1);
    }else{
      boolean found = false;
      for(int i = 0; i< board.starts.size(); i++){
        PVector _start = board.starts.get(i);
        PVector _end = board.ends.get(i);
        if(start.x==_start.x && start.y==_start.y && end.x==_end.x && end.y==_end.y){
          board.starts.remove(i);
          board.ends.remove(i);
          found = true;
          break;
        }
      }if(found == false){
        board.starts.add(start);
        board.ends.add(end);
      }
      start = new PVector(-1,-1);
      end = new PVector(-1,-1);
    }
  }
  
  else if(mouseButton == LEFT){
    for(piece single:board.all){
      if(single.ischose){
        if(single.toMove){
          PVector oldCoor = new PVector(single.coor.x, single.coor.y);
          single.move(new PVector(hover.x, hover.y), board);
          if(single.coor.x != oldCoor.x || single.coor.y != oldCoor.y){
            if(single.side){
              for(piece _single:board.all){
               if(_single.side == false){
                 _single.toMove = true;
               }else{
                _single.toMove = false; 
               }
              }
            }else if(!single.side){
              for(piece _single:board.all){
               if(_single.side == true){
                 _single.toMove = true;
               }else{
                _single.toMove = false; 
               }
              }
            }
          }
        }
        //Castling
        if(single.name=="king"){
          //if white king
          if(single.side == true){
            if(hover.x==2&&single.queen_side){
              board.queen_side_castle(true);
            }else if(hover.x==6&&single.king_side){
              board.king_side_castle(true);
            } 
          }else{
            if(hover.x==2&&single.queen_side){
              board.queen_side_castle(false);
            }else if(hover.x==6&&single.king_side){
              board.king_side_castle(false);
            } 
          }
        }
        for(piece _single:board.all){
          _single.ischose = false;
          _single.important.ischose = false;
          _single.checkMoveables();
        }
        board.bking.changeChecked(false);
        board.wking.changeChecked(false);
        break;
      }
    }
  }
}

void keyPressed(){
 if(key == 'f'){
  board.flip();
 }
  
}
