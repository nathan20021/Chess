class abstractPieces{
  
  PVector coor = new PVector();
  boolean side;
  char name;
  boolean ischose = false;
  boolean isGuard;
  boolean isChecked;
  boolean firstMove;
  boolean castleable;
  boolean[] isPinned;
  ArrayList<PVector> moveables = new ArrayList<PVector>();
  PVector guardSquare;
  int dir;
  
  public abstractPieces(PVector _coor, boolean _side, String _name, ArrayList<PVector> _moveables, boolean _isGuard, boolean _isChecked, boolean _isChose, PVector _guardSquare, boolean _firstMove, boolean _castleable, int _dir, boolean[] _isPinned){
    this.coor = _coor;
    this.side = _side;
    _name.toLowerCase();
    this.name = _name.charAt(0);
    if(_name == "knight"){
      this.name = 'n';
    }
    this.moveables = _moveables;
    this.isGuard = _isGuard;
    this.isChecked = _isChecked;
    this.ischose = _isChose;
    this.guardSquare = _guardSquare;
    this.firstMove = _firstMove;
    this.castleable = _castleable;
    this.dir = _dir;
    this.isPinned = _isPinned;
  }
  
}
