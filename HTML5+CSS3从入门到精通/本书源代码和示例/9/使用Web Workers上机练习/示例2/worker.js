function messageHandler(e) {
    postMessage("worker says: " + e.data );
}
addEventListener("message", messageHandler, true);
