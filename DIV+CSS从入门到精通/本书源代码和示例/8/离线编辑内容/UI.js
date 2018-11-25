	function newNote() {
		var title = window.prompt("New Note:");
		if(title) {
			add(title);
		}
	}

	function add(title) {
		// 在界面中添加
		addUIItem(title);
		// 在数据中添加
		addDataItem(title);
	}

	function remove(title) {
		// 从界面中删除
		removeUIItem(title);
		// 从数据中删除
		removeDataItem(title);
	}

	function addUIItem(title) {
		var item = document.createElement("li");
		item.setAttribute("ondblclick", "remove('" + title + "')");
		item.innerHTML = title;

		var list = document.getElementById("list");
		list.appendChild(item);
	}

	function removeUIItem(title) {
		var list = document.getElementById("list");
		for(var i = 0; i < list.children.length; i++) {
			if(list.children[i].innerHTML == title) {
				list.removeChild(list.children[i]);
			}
		}
	}