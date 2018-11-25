window.applicationCache.onchecking = function(e) {
    log("检查应用程序更新");
}

window.applicationCache.onnoupdate = function(e) {
    log("发现没有应用更新");
}

window.applicationCache.onupdateready = function(e) {
    log("应用程序更新完成");
}

window.applicationCache.onobsolete = function(e) {
    log("应用过时");
}

window.applicationCache.ondownloading = function(e) {
    log("下载应用程序更新");
}

window.applicationCache.oncached = function(e) {
    log("应用程序缓存");
}

window.applicationCache.onerror = function(e) {
    log("应用程序缓存错误");
}

window.addEventListener("online", function(e) {
    log("在线");
}, true);

window.addEventListener("offline", function(e) {
    log("离线");
}, true);

showCacheStatus = function(n) {
    statusMessages = ["没有缓存","空闲","正在检查...","正在下载...","更新完成","过时"];
    return statusMessages[n];
}

install = function() {
    log("正在检查更新");
    try {
        window.applicationCache.update();
    } catch (e) {
        applicationCache.onerror();
    }
}

onload = function(e) {
    if (!window.applicationCache) {
        log("你的浏览器不支持离线缓存.");
        return;
    }

    if (!navigator.geolocation) {
        log("你的浏览器不支持HTML5定位.");
        return;
    }

    if (!window.localStorage) {
        log("你的浏览器不支持本地存储.");
        return;
    }


    log("初始缓存状态: " + showCacheStatus(window.applicationCache.status));
    document.getElementById("installButton").onclick = install;

    if(navigator.onLine) {
        uploadLocations();
    }
}

