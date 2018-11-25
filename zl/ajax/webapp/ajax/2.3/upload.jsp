<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="ajax.upload.MonitoredDiskFileItemFactory"%>
<%@ page import="ajax.upload.UploadListener"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.FileUploadException"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%
    //创建一个上传监听器类，第二个参数是为了演示效果设置的等待时间，正式应用时传入0
    UploadListener listener = new UploadListener(request, 50);

    //创建磁盘存储文件Item工厂
    FileItemFactory factory = new MonitoredDiskFileItemFactory(listener);

    //创建新的文件上传处理类
    ServletFileUpload upload = new ServletFileUpload(factory);

    try {
        upload.parseRequest(request);   //处理请求
        //这里可以进一步将文件保存在硬盘或数据库中
    } catch (FileUploadException e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>文件上传</title>
</head>

<body>
文件成功上传。
</body>
</html>