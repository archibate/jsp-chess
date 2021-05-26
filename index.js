/**
 * Created by Administrator on 2021/4/19.
 */

const S = 36;

class Chess
{
  constructor(color, name, x, y)
  {
    this.x = x;
    this.y = y;
    this.name = name;
    this.color = color;
    this.map = null;
  }

  paint(ctx)
  {
    ctx.fillStyle = '#fc6';
    ctx.fillRect(this.x * S, this.y * S, S, S);
    ctx.fillStyle = this.color;
    ctx.font = S + "px 华文隶书";
    ctx.fillText(this.name, (this.x + 0) * S, (this.y + 0.8) * S);
  }

  paintSelection(ctx) {
    ctx.strokeStyle = 'green';
    ctx.lineWidth = 3;
    ctx.strokeRect(this.x * S, this.y * S, S, S);
    var points = this.getMovePoints();
    for (var i in points) {
      var [px, py] = points[i];
      ctx.fillStyle = 'lightgreen';
      ctx.strokeStyle = 'green';
      ctx.lineWidth = 4;
      ctx.beginPath();
      ctx.arc((px + 0.5) * S, (py + 0.5) * S, S * 0.1, 0, Math.PI * 2);
      ctx.stroke();
      ctx.fill();
    }
  }

  getMoveDirs() {
    return [];
  }

  basicMovePointFilter(px, py) {
    if (!this.map.inside(px, py))
      return false;
    var target = this.map.at(px, py);
    if (target != null && target.color == this.color)
      return false;
    return true;
  }

  movePointFilter(px, py) {
    return true;
  }

  getMovePoints() {
    var dirs = this.getMoveDirs();
    var points = [];
    for (var i in dirs) {
      var [dx, dy] = dirs[i];
      var [px, py] = [this.x + dx, this.y + dy];
      if (this.basicMovePointFilter(px, py)
        && this.movePointFilter(px, py)) {
        points.push([px, py]);
      }
    }
    return points;
  }

  tryMoveTo(mx, my) {
    var points = this.getMovePoints();
    for (var i in points) {
      var [px, py] = points[i];
      if (px == mx && py == my) {
        this.map.eatChessAt(mx, my);
        [this.x, this.y] = [mx, my];
        return true;
      }
    }
    return false;
  }
}

class Map
{
  constructor()
  {
    this.chesses = [];
    this.lut = null;
    this.selection = null;
  }

  buildLUT() {
    this.lut = [];
    for (var i = 0; i < 90; i++)
      this.lut.push(-1);
    for (var i in this.chesses) {
      var c = this.chesses[i];
      this.lut[c.x * 10 + c.y] = i;
    }
  }

  indexAt(x, y) {
    if (!this.inside(x, y))
      return -1;
    return this.lut[x * 10 + y];
  }

  at(x, y) {
    var i = this.indexAt(x, y);
    if (i == -1)
      return null;
    return this.chesses[i];
  }

  eatChessAt(x, y) {
    var i = this.indexAt(x, y);
    if (i == -1)
      return;
    this.chesses.splice(i, 1);
  }

  paint(ctx)
  {
    ctx.fillStyle = 'aliceblue';
    ctx.fillRect(0, 0, 9 * S, 10 * S);
    for (var i in this.chesses) {
      var c = this.chesses[i];
      c.paint(ctx);
    }
    if (this.selection != null)
      this.selection.paintSelection(ctx);
  }

  addChess(color, name, px, py)
  {
    var ctors = {
      '车': ChessChe,
      '马': ChessMa,
      '象': ChessXiang,
      '相': ChessXiang,
      '士': ChessShi,
      '仕': ChessShi,
      '将': ChessJiang,
      '帅': ChessJiang,
      '炮': ChessPao,
      '卒': ChessZu,
      '兵': ChessZu,
    };
    var chess = new ctors[name](color, name, px, py);
    chess.map = this;
    this.chesses.push(chess);
  }

  inside(x, y)
  {
    return 0 <= x && x < 9 && 0 <= y && y < 10;
  }

  initialize()
  {
    this.chesses = [];
    this.addChess('black', '车', 0, 0);
    this.addChess('black', '马', 1, 0);
    this.addChess('black', '象', 2, 0);
    this.addChess('black', '士', 3, 0);
    this.addChess('black', '将', 4, 0);
    this.addChess('black', '士', 5, 0);
    this.addChess('black', '象', 6, 0);
    this.addChess('black', '马', 7, 0);
    this.addChess('black', '车', 8, 0);
    this.addChess('black', '卒', 0, 3);
    this.addChess('black', '炮', 1, 2);
    this.addChess('black', '卒', 2, 3);
    this.addChess('black', '卒', 4, 3);
    this.addChess('black', '卒', 6, 3);
    this.addChess('black', '炮', 7, 2);
    this.addChess('black', '卒', 8, 3);

    this.addChess('red', '车', 0, 9);
    this.addChess('red', '马', 1, 9);
    this.addChess('red', '相', 2, 9);
    this.addChess('red', '仕', 3, 9);
    this.addChess('red', '帅', 4, 9);
    this.addChess('red', '仕', 5, 9);
    this.addChess('red', '相', 6, 9);
    this.addChess('red', '马', 7, 9);
    this.addChess('red', '车', 8, 9);
    this.addChess('red', '兵', 0, 6);
    this.addChess('red', '炮', 1, 7);
    this.addChess('red', '兵', 2, 6);
    this.addChess('red', '兵', 4, 6);
    this.addChess('red', '兵', 6, 6);
    this.addChess('red', '炮', 7, 7);
    this.addChess('red', '兵', 8, 6);
  }
}

class ChessChe extends Chess {
  getMoveDirs() {
    var points = [];
    var deltas = [[0, +1], [0, -1], [+1, 0], [-1, 0]];
    for (var t in deltas) {
      var [dx, dy] = deltas[t];
      for (var i = 1; i <= 10; i++) {
        points.push([dx * i, dy * i]);
        if (this.map.at(
          this.x + dx * i, this.y + dy * i)
          != null)
          break;
      }
    }
    return points;
  }
}

class ChessMa extends Chess {
  getMoveDirs() {
    var points = [];
    if (this.map.at(this.x, this.y + 1) == null) {
      points.push([+1, +2]);
      points.push([-1, +2]);
    }
    if (this.map.at(this.x, this.y - 1) == null) {
      points.push([+1, -2]);
      points.push([-1, -2]);
    }
    if (this.map.at(this.x + 1, this.y) == null) {
      points.push([+2, +1]);
      points.push([+2, -1]);
    }
    if (this.map.at(this.x - 1, this.y) == null) {
      points.push([-2, +1]);
      points.push([-2, -1]);
    }
    return points;
  }
}

class ChessXiang extends Chess {
  getMoveDirs() {
    var points = [];
    if (this.map.at(this.x + 1, this.y + 1) == null)
      points.push([+2, +2]);
    if (this.map.at(this.x - 1, this.y + 1) == null)
      points.push([-2, +2]);
    if (this.map.at(this.x + 1, this.y - 1) == null)
      points.push([+2, -2]);
    if (this.map.at(this.x - 1, this.y - 1) == null)
      points.push([-2, -2]);
    return points;
  }
  movePointFilter(px, py) {
    if (this.color == 'black' && py > 4
      || this.color == 'red' && py < 5) {
      return false;
    }
    return true;
  }
}

class ChessShi extends Chess {
  getMoveDirs() {
    var points = [];
    points.push([+1, +1]);
    points.push([-1, +1]);
    points.push([+1, -1]);
    points.push([-1, -1]);
    return points;
  }
  movePointFilter(px, py) {
    if (this.color == 'black') {
      if (3 <= px && px <= 5 && 0 <= py && py <= 2)
        return true;
    } else {
      if (3 <= px && px <= 5 && 7 <= py && py <= 9)
        return true;
    }
    return false;
  }
}

class ChessJiang extends Chess {
  getMoveDirs() {
    var points = [];
    points.push([+1, 0]);
    points.push([-1, 0]);
    points.push([0, +1]);
    points.push([0, -1]);
    return points;
  }
  movePointFilter(px, py) {
    if (this.color == 'black') {
      if (3 <= px && px <= 5 && 0 <= py && py <= 2)
        return true;
    } else {
      if (3 <= px && px <= 5 && 7 <= py && py <= 9)
        return true;
    }
    return false;
  }
}

class ChessZu extends Chess {
  getMoveDirs() {
    var points = [];
    if (this.color == 'black')
      points.push([0, +1]);
    else
      points.push([0, -1]);
    if (this.color == 'black' && this.y > 4
      || this.color == 'red' && this.y < 5) {
      points.push([-1, 0]);
      points.push([+1, 0]);
    }
    return points;
  }
}

class ChessPao extends Chess {
  getMoveDirs() {
    var points = [];
    var deltas = [[0, +1], [0, -1], [+1, 0], [-1, 0]];
    for (var t in deltas) {
      var [dx, dy] = deltas[t];
      for (var i = 1; i <= 10; i++) {
        if (this.map.at(
          this.x + dx * i, this.y + dy * i)
          != null) {
          for (i++; i <= 10; i++) {
            var c = this.map.at(
              this.x + dx * i, this.y + dy * i);
            if (c != null) {
              points.push([dx * i, dy * i]);
              break;
            }
          }
          break;
        }
        points.push([dx * i, dy * i]);
      }
    }
    return points;
  }
}

class Canvas {
  constructor(map) {
    this.map = null;
    this.canvas = document.getElementById('canvas');
    this.canvas.width = 9 * S;
    this.canvas.height = 10 * S;
    this.ctx = this.canvas.getContext('2d');
    this.canvas.onmousedown = this.onMouseDown.bind(this);
    this.player = 'red';
    //this.ws = new WebSocket('ws://127.0.0.1:9125/');
    //this.ws.onmessage = this.onReceive.bind(this);
  }

  invalidate() {
    this.map.buildLUT();
    this.map.paint(this.ctx);
  }

  onReceive(data) {
    console.log('RECV', data);
    if (data[0] == 'M') {
      var px = parseInt(data[1]);
      var py = parseInt(data[2]);
      var mx = parseInt(data[3]);
      var my = parseInt(data[4]);
      var c = this.map.at(px, py);
      if (c == null) {
        alert('对方疑似作弊，找不到棋子: ' + data);
        return;
      }
      if (!c.tryMoveTo(mx, my)) {
        alert('对方疑似作弊，无法移动: ' + data);
        return;
      }
      this.invalidate();
    }
  }

  sendCommand(data, callback) {
    console.log('SEND', data);
    $.post('send.jsp', {
      data: data,
    }, function(res, err) {
      console.log(res, err);
      callback();
    });
  }

  onMouseDown(e) {
    var [mx, my] = [e.offsetX, e.offsetY];
    mx = parseInt(mx / S);
    my = parseInt(my / S);

    if (this.map.selection) {
      var [px, py] = [this.map.selection.x, this.map.selection.y];
      if (this.map.selection.tryMoveTo(mx, my)) {
        this.sendCommand('M' + px + py + mx + my, function() {
          this.map.selection = null;
          this.invalidate();
        }.bind(this));
        return;
      }
    }
    var c = this.map.at(mx, my);
    if (c != null && c.color == this.player) {
      this.map.selection = c;
      this.invalidate();
    }
  }
}

var canvas = new Canvas();
canvas.map = new Map();
canvas.map.initialize();
canvas.invalidate();
