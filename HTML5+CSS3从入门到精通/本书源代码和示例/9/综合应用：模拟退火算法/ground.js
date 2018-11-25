var ground = {
  clear: function(ctx) {
    ctx.clearRect(0, 0, 200, 200);
  },
  drawPath: function(ctx, path) {
    ctx.strokeStyle = "green";
    ctx.fillStyle = "rgba(236, 138, 4, 0.5)";
    ctx.strokeWidth = 3;
    ctx.beginPath();
    var firstPoint = true;
    var l = ctx.allPoints.length;
    for (var i = 0; i < l; i++) {
      var idx = path[i];
      var x = ctx.allPoints[idx].x;
      var y = ctx.allPoints[idx].y;
      if (firstPoint) {
        ctx.moveTo(x, y);
        firstPoint = false;
      } else {
        ctx.lineTo(x, y);
      }
    }
    ctx.closePath();
    ctx.stroke();
    ctx.fill();
  },
  drawPoints: function(ctx) {
    ctx.fillStyle = "red";
    for (var i = 0; i < ctx.allPoints.length; i++) {
      ctx.fillCircle(ctx.allPoints[i].x, ctx.allPoints[i].y, 6);
    }
  },
  newGround: function(name, points) {
    var h2 = document.createElement("h2");
    h2.appendChild(document.createTextNode(name));

    var canvas = document.createElement("canvas");
    canvas.setAttribute("width", "100");
    canvas.setAttribute("height", "100");

    var div = document.createElement("div");
    div.appendChild(h2);
    div.appendChild(canvas);

    var container = document.getElementById("groundContainer");

    container.appendChild(div);
    var ctx = canvas.getContext("2d");
    ctx.scale(0.5,0.5);
    ctx.allPoints = points;

    return ctx;
  }
};
