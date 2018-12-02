<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>大量数据动态浏览查询</title>
<style>
/* 固定表格样式 */
.fixedTable {
   table-layout:fixed;
}

/* 单元格样式 */
td.cell {
    padding:2px 0px 2px 3px;
    margin:0px;
    border-bottom:1px solid #B8B8B8;
    border-right:1px solid #B8B8B8;
    height:22px;
    overflow:hidden;
    font-size:12px;
    font-family:Arial;
    line-height:12px;
}

/* 列头样式 */
.first {
   border-left:1px solid #B8B8B8;
}

/* 表头样式 */
.tableCellHeader {
   padding:2px 0px 2px 3px;
   text-align:left;
   font-size:12px;
   border-top:1px solid #B8B8B8;
   border-right:1px solid #B8B8B8;
   background-color:#003366;
   color:#FFF;
   font-family:Arail;
}
</style>
<script type="text/javascript" src="prototype.js"></script>
<script type="text/javascript" src="rico.js"></script>
<script type="text/javascript">
function init() {
    //设置预取参数为true，数据滚动响应函数为updateTip
    var opts = {
        prefetchBuffer:true,
        onscroll:updateTip
    }
    //新建Rico.LiveGrid对象
    new Rico.LiveGrid("data_grid", 10, 100, "live_grid.jsp", opts);
}

//更新提示信息
function updateTip( liveGrid, offset ) {
    $('tip').innerHTML = "浏览产品 " + (offset+1) + " - " + 
                              (offset+liveGrid.metaData.getPageSize()) + 
                              " of " + liveGrid.metaData.getTotalRows();
}
</script>
</head>

<body onload="init()">
<h1>大量数据动态浏览查询</h1>
<div id="tip" style="font-size:12px">浏览产品</div>

<div id="container">

    <!-- 数据表头 -->
    <table id="data_grid_header" class="fixedTable" cellspacing="0" cellpadding="0" style="width:400px">
    <tr>
        <th class="first tableCellHeader" style="width:40px;text-align:center">NO.</th>
        <th class="tableCellHeader" style="width:280px">名称</th>
        <th class="tableCellHeader" style="width:80px">价格</th>
    </tr>
    </table>

    <!-- 数据容器 -->
    <div id="data_grid_container" style="width:430px">
        <div id="viewPort" style="float:left">
            <table id="data_grid" 
                   class="fixedTable" 
                   cellspacing="0"
                   cellpadding="0" 
                   style="width:400px; border-left:1px solid #ababab" >

            <!-- 循环显示20行供存放数据 -->
            <% for (int i=0; i<20; i++) { %>
            <tr>
                <td class="cell" style="width:40px;text-align:center"></td>
                <td class="cell" style="width:280px"></td>
                <td class="cell" style="width:80px"></td>
            </tr>
            <% } %>
            </table>
        </div>
    </div>
</div>
</body>
</html>
