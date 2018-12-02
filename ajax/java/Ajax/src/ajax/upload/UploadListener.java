package ajax.upload;

import javax.servlet.http.HttpServletRequest;

public class UploadListener implements OutputStreamListener {
	private HttpServletRequest request;

	private long delay = 0;// 延迟时间，用于Debug（毫秒）

	private int totalSize = 0;// 上传文件尺寸

	private int totalBytesRead = 0;// 已读取字节数

	// 构造方法，同时设置了请求和延迟时间
	public UploadListener(HttpServletRequest request, long debugDelay) {
		this.request = request;
		this.delay = debugDelay;
		totalSize = request.getContentLength();
	}

	// 上传开始
	public void start() {
		updateUploadInfo("start");
	}

	// 读取字节
	public void bytesRead(int bytesRead) {
		totalBytesRead = totalBytesRead + bytesRead;
		updateUploadInfo("progress");

		try {
			Thread.sleep(delay);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	// 上传错误
	public void error(String message) {
		updateUploadInfo("error");
	}

	// 上传结束
	public void done() {
		updateUploadInfo("done");
	}

	// 更新上传信息
	private void updateUploadInfo(String status) {
		request.getSession().setAttribute("uploadInfo",
				new UploadInfo(totalSize, totalBytesRead, status));
	}

}
