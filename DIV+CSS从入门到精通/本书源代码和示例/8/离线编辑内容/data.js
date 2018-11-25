	var storage = window['localStorage'];

	function addDataItem(title) {
		if(navigator.onLine)// 在线状态
		{
			addServerItem(title);
		} else// 离线状态
		{
			var str = storage.getItem("toAdd");
			if(str == null) {
				str = title;
			} else {
				str = str + "," + title;
			}
			storage.setItem("toAdd", str);
		}
	}

	function removeDataItem(title) {
		if(navigator.onLine)// 在线状态
		{
			removeServerItem(title);
		} else// 离线状态
		{
			var str = storage.getItem("toRemove");
			if(str == null) {
				str = title;
			} else {
				str = str + "," + title;
			}
			storage.setItem("toRemove", str);
		}
	}

	function SyncWithServer() {
		// 如果当前是离线状态，不需要做任何处理
		if(navigator.onLine == false)
			return;

		var i = 0;
		// 和服务器同步添加操作
		var str = storage.getItem("toAdd");
		if(str != null) {
			var addItems = str.split(",");
			for( i = 0; i < addItems.length; i++) {
				addDataItem(addItems[i]);
			}
			storage.removeItem("toAdd");
		}

		// 和服务器同步删除操作
		str = storage.getItem("toRemove");
		if(str != null) {
			var removeItems = str.split(",");
			for( i = 0; i < removeItems.length; i++) {
				removeDataItem(removeItems[i]);
			}
			storage.removeItem("toRemove");
		}

		// 删除界面中的所有便签
		var list = document.getElementById("list");
		while(list.lastChild != list.firstElementChild)
		list.removeChild(list.lastChild);
		if(list.firstElementChild)
			list.removeChild(list.firstElementChild);

		// 从服务器获取全部便签，并显示在界面中
		var allItems = getServerItems();
		if(allItems != "") {
			var items = allItems.split(",");
			for( i = 0; i < items.length; i++) {
				addUIItem(items[i]);
			}
		}
	}
	window.addEventListener("online", SyncWithServer,false);