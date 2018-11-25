onmessage = function(e) {
    postMessage("worker says: " + e.data );
}

