/**
 * Created by Administrator on 2021/4/19.
 *
 * vim: et ts=2 sts=2 sw=2
 */

$(function() {

const S = 75;

class Chess
{
  constructor(color, name, x, y) {
    this.x = x;
    this.y = y;
    this.name = name;
    this.color = color;
    this.map = null;
    this.dead = true;
  }

  X(x) {
    if (x === undefined)
      x = this.x;
    return this.map.X(x);
  }

  Y(y) {
    if (y === undefined)
      y = this.y;
    return this.map.Y(y);
  }

  paint(ctx) {
    ctx.fillStyle = '#fc6';
    ctx.strokeStyle = this.color;
    ctx.beginPath();
    ctx.arc((this.X() + 0.5) * S, (this.Y() + 0.5) * S, S * 0.48, 0, Math.PI * 2);
    ctx.fill();
    ctx.lineWidth = 2;
    ctx.beginPath();
    ctx.arc((this.X() + 0.5) * S, (this.Y() + 0.5) * S, S * 0.42, 0, Math.PI * 2);
    ctx.stroke();
    ctx.fillStyle = this.color;
    ctx.font = (S * 0.75) + "px 华文隶书";
    ctx.fillText(this.name, (this.X() + 0.12) * S, (this.Y() + 0.73) * S);
  }

  paintSelection(ctx) {
    ctx.strokeStyle = 'green';
    ctx.lineWidth = 3;
    //ctx.strokeRect(this.X() * S, this.Y() * S, S, S);
    ctx.beginPath();
    ctx.arc((this.X() + 0.5) * S, (this.Y() + 0.5) * S, S * 0.5, 0, Math.PI * 2);
    ctx.stroke();
    var points = this.getMovePoints();
    for (var i in points) {
      var [px, py] = points[i];
      ctx.fillStyle = 'lightgreen';
      ctx.strokeStyle = 'green';
      ctx.lineWidth = 5;
      ctx.beginPath();
      ctx.arc((this.X(px) + 0.5) * S, (this.Y(py) + 0.5) * S, S * 0.1, 0, Math.PI * 2);
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

  canMoveTo(mx, my) {
    var points = this.getMovePoints();
    for (var i in points) {
      var [px, py] = points[i];
      if (px == mx && py == my)
        return true;
    }
    return false;
  }

  doMoveTo(mx, my) {
    this.map.eatChessAt(mx, my);
    [this.x, this.y] = [mx, my];
  }
}

class Map
{
  constructor()
  {
    this.chesses = [];
    this.lut = null;
    this.selection = null;
    this.player = null;
  }

  X(x) {
    return this.player != 'red' ? 8 - x : x;
  }

  Y(y) {
    return this.player != 'red' ? 9 - y : y;
  }

  buildLUT() {
    this.lut = [];
    for (var i = 0; i < 90; i++)
      this.lut.push(-1);
    for (var i in this.chesses) {
      var c = this.chesses[i];
      if (c.dead) continue;
      this.lut[c.x * 10 + c.y] = i;
    }
  }

  serialize() {
    var data = '';
    for (var i in this.chesses) {
      var c = this.chesses[i];
      if (c.dead) {
        data += '--';
        continue;
      }
      var xy = c.x + '' + c.y;
      data += xy;
    }
    return data;
  }

  deserialize(data) {
    for (var i in this.chesses) {
      var c = this.chesses[i];
      var x = data[i * 2 + 0];
      var y = data[i * 2 + 1];
      if (x == '-' && y == '-') {
        c.dead = true;
        continue;
      }
      c.dead = false;
      c.x = parseInt(x);
      c.y = parseInt(y);
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
    var c = this.chesses[i];
    c.dead = true;
  }

  paint(ctx)
  {
    ctx.fillStyle = '#fed';
    ctx.fillRect(0, 0, 9 * S, 10 * S);

    ctx.lineWidth = 3;
    ctx.strokeStyle = 'black';
    ctx.beginPath();
    for (var i = 0; i < 10; i++) {
      ctx.moveTo(0.5 * S, (i + 0.5) * S);
      ctx.lineTo(8.5 * S, (i + 0.5) * S);
    }
    ctx.moveTo(0.5 * S, 0.5 * S);
    ctx.lineTo(0.5 * S, 9.5 * S);
    ctx.moveTo(8.5 * S, 0.5 * S);
    ctx.lineTo(8.5 * S, 9.5 * S);
    for (var i = 1; i < 8; i++) {
      ctx.moveTo((i + 0.5) * S, 0.5 * S);
      ctx.lineTo((i + 0.5) * S, 4.5 * S);
      ctx.moveTo((i + 0.5) * S, 5.5 * S);
      ctx.lineTo((i + 0.5) * S, 9.5 * S);
    }
    ctx.moveTo(3.5 * S, 0.5 * S);
    ctx.lineTo(5.5 * S, 2.5 * S);
    ctx.moveTo(5.5 * S, 0.5 * S);
    ctx.lineTo(3.5 * S, 2.5 * S);
    ctx.moveTo(3.5 * S, 9.5 * S);
    ctx.lineTo(5.5 * S, 7.5 * S);
    ctx.moveTo(5.5 * S, 9.5 * S);
    ctx.lineTo(3.5 * S, 7.5 * S);
    ctx.stroke();

    ctx.lineWidth = 5;
    ctx.strokeRect(0.35 * S, 0.35 * S, 8.3 * S, 9.3 * S);

    if (this.player != null) {
      ctx.fillStyle = 'black';
      ctx.font = (S * 0.75) + "px 华文隶书";
      if (this.player != 'red')
        ctx.setTransform(-1, 0, 0, -1, 9 * S, 10 * S);
      ctx.fillText('汉界', (5.5 + 0.12) * S, (5 - 0.5 + 0.73) * S);
      ctx.transform(-1, 0, 0, -1, 9 * S, 10 * S);
      ctx.fillText('楚河', (5.5 + 0.12) * S, (5 - 0.5 + 0.73) * S);
      ctx.setTransform(1, 0, 0, 1, 0, 0);
    }

    for (var i in this.chesses) {
      var c = this.chesses[i];
      if (c.dead) continue;
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

  isLose()
  {
    if (this.player == 'red')
      return this.chesses[20].dead;
    else
      return this.chesses[4].dead;
  }

  isWin()
  {
    if (this.player == 'red')
      return this.chesses[4].dead;
    else
      return this.chesses[20].dead;
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
    for (var y = this.y + 1; y <= 9; y++) {
      var c = this.map.at(this.x, y);
      if (c != null) {
        if (c instanceof ChessJiang)
          points.push([0, y - this.y]);
        break;
      }
    }
    for (var y = this.y - 1; y >= 0; y--) {
      var c = this.map.at(this.x, y);
      if (c != null) {
        if (c instanceof ChessJiang)
          points.push([0, y - this.y]);
        break;
      }
    }
    return points;
  }
  movePointFilter(px, py) {
    return 3 <= px && px <= 5 && ((0 <= py && py <= 2) || (7 <= py && py <= 9));
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
    this.moved = false;
    this.waiting = true;
    this.enemized = false;
    this.recieved = false;
    this.oldData = null;
    $.post('myColor.jsp', {
    }, function(res) {
        var [roomId, myColor] = res.split(':');
        console.log('MYCOLOR', myColor, roomId);
        $('#roomId').html(roomId);
        if (roomId == 'ERROR') {
          alert('房间不存在或已解散！');
          window.location.href = 'index.jsp';
        }
        this.map.player = myColor;
        this.doExchange();
        this.doGetEnemyInfo();
    }.bind(this));
  }

  invalidate() {
    this.map.buildLUT();
    this.map.paint(this.ctx);
  }

  doGetEnemyInfo() {
    var done = function() {
      setTimeout(this.doGetEnemyInfo.bind(this), 300);
    }.bind(this);

    $.post('enemyInfo.jsp', {
    }, function(res) {
      console.log('ENEMY', res);
      if (res == 'NONE') {
        res = '未加入';
      } else {
        $('#inviteBtn').hide();
      }
      if (res.substr(0, 3) == 'OK:') {
        done = function() {};
        this.enemized = true;
        res = res.substr(3);
      }
      $('#enemyName').html(res);

      done();
    }.bind(this));
  }

  doExchange() {
    var done = function() {
      setTimeout(this.doExchange.bind(this), 500);
    }.bind(this);
    var data = this.moved ? this.map.serialize() : '';
    if (data.length != 0) {
      console.log('SEND', data);
    }
    var wasMoved = this.moved;
    $.post('xchg.jsp', {
      data: data,
    }, function(res) {
      if (res.length != 0) {
        if (res[0] != 'Y' && res[0] != 'N') {
          alert(res);
        }
        var data = res.substr(1);
        var wasWaiting = this.waiting;
        this.waiting = res[0] == 'Y';
        if (!this.recieved || (wasWaiting && !this.waiting)) {
          this.recieved = true;
          console.log('RECV', data);
          this.map.deserialize(data);
          this.invalidate();
        }
        if (wasMoved)
          this.moved = false;
      }

      if (!this.enemized) {
        $('#statBar').html('等待对方加入...');
      } else if (this.waiting || this.moved) {
        $('#statBar').html('等待对方走子...');
        if (!this.recieved && this.map.isLose()) {
          this.map.deserialize('0010203040506070800312234363728309192939495969798906172646667786');
          this.invalidate();
        }
      } else {
        $('#statBar').html('该你走子');
      }

      if (this.recieved) {
        if (this.map.isLose()) {
          $('#statBar').html('很遗憾，你输了！');
          done = function() {};
          $.post('youLose.jsp', {
          }, function(res) {
            if (res != 'OK') {
              alert(res);
            }
          });
        } else if (this.map.isWin()) {
          $('#statBar').html('恭喜，你赢了！');
          //done = function() {};
        }
      }

      done();
    }.bind(this));
  }

  onMouseDown(e) {
    if (!this.enemized || this.waiting || this.moved)
      return;

    var [mx, my] = [e.offsetX, e.offsetY];
    mx = this.map.X(parseInt(mx / S));
    my = this.map.Y(parseInt(my / S));

    if (this.map.selection) {
      var [px, py] = [this.map.selection.x, this.map.selection.y];
      if (this.map.selection.canMoveTo(mx, my)) {
        this.oldData = this.map.serialize();
        this.map.selection.doMoveTo(mx, my);
        this.moved = true;
        $('#statBar').html('正在提交数据...');
        this.map.selection = null;
        this.invalidate();
        return;
      }
    }
    var c = this.map.at(mx, my);
    if (c != null && c.color == this.map.player) {
      this.map.selection = c;
      this.invalidate();
    }
  }

  onQuit() {
    window.location.href = 'index.jsp';
  }

  onSave() {
    var data = this.map.serialize();
    console.log('SAVE', data);
    $.post('saveRecord.jsp', {
      data: data,
    }, function(res) {
        if (res == 'OK') {
          alert('保存成功！稍后可在历史存档页面查看');
        } else {
          alert(res);
        }
    }.bind(this));
  }

  onRegret() {
    if (this.waiting || this.moved) {
      alert('请先等对方走完后，再选择悔棋');
      return;
    }
    if (this.oldData == null) {
      alert('没有上一步了，无法悔棋');
      return;
    }
    $('#statBar').html('正在悔棋...');
    this.map.deserialize(this.oldData);
    this.oldData = null;
    //this.moved = true;
    this.regreting = true;
    this.map.selection = null;
    this.invalidate();
  }

  onLose() {
    this.map.isLose = function () { return true; };
    this.map.deserialize = function (data) {};
  }

  onInvite() {
    $('#statBar').html('正在邀请AI...');
    console.log('INVITE AI');
    $.post('inviteAI.jsp', {
    }, function(res) {
      if (res != 'OK') {
        alert(res);
      }
    }.bind(this));
  }
}

canvas = new Canvas();
canvas.map = new Map();
canvas.map.initialize();
console.log('INIT', canvas.map.serialize());
canvas.invalidate();

$('#quitBtn').click(function () { canvas.onQuit(); });
$('#saveBtn').click(function () { canvas.onSave(); });
$('#regretBtn').click(function () { canvas.onRegret(); });
$('#loseBtn').click(function () { if (!this.hadOnce) alert('再次点击确认'); else canvas.onLose(); this.hadOnce = true; }.bind({}));
$('#inviteBtn').click(function () { canvas.onInvite(); });

});
