var controls = {
  doLoad: function() {
  },
  go: function() {
    var useThreads = document.getElementById("worker").checked;

    function Test(name, p) {
      this.g = ground.newGround(name, p);
      this.name = name;
      var self = this;
      setTimeout(function() {
        self.go();
      }, 10);
    };
    Test.prototype = {
      go: function() {
        ground.drawPoints(this.g);
        var opts = {
          points: this.g.allPoints,
          t0: 1,
          g: 0.99,
          stepsPerT: 10
        }
        var listener = {
          ctx: this.g,
          name: this.name,
          onNewMin: function(p) {
          },
          onDone: function(p) {
            ground.clear(this.ctx);
            ground.drawPath(this.ctx, p);
            ground.drawPoints(this.ctx);
          }
        };
        var a;
        if (useThreads)
          a = new ThreadedAnnealing();
        else
          a = new Annealing();
        a.init(opts, 200, 200, listener);
        a.go();
      }
    };

    var t1 = new Test("Test 1", p1);
    var t2 = new Test("Test 2", p2);
    var t3 = new Test("Test 3", p3);
    var t4 = new Test("Test 4", p4);
    var t5 = new Test("Test 5", p5);
    var t6 = new Test("Test 6", p6);
  }
};
