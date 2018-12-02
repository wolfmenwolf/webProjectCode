package ajax.upload;

public class UploadInfo {
	private long totalSize = 0;// 上传文件尺寸

	private long bytesRead = 0;// 已上传字节数

	private String status = "done";// 上传状态

	// 默认构造函数
	public UploadInfo() {
	}

	// 构造函数
	public UploadInfo(long totalSize, long bytesRead, String status) {
		this.totalSize = totalSize;
		this.bytesRead = bytesRead;
		this.status = status;
	}

	// 获取上传状态
	public String getStatus() {
		return status;
	}

	// 设置上传状态
	public void setStatus(String status) {
		this.status = status;
	}

	// 获取文件尺寸
	public long getTotalSize() {
		return totalSize;
	}

	// 设置文件尺寸
	public void setTotalSize(long totalSize) {
		this.totalSize = totalSize;
	}

	// 获取已上传字节数
	public long getBytesRead() {
		return bytesRead;
	}

	// 设置已上传字节数
	public void setBytesRead(long bytesRead) {
		this.bytesRead = bytesRead;
	}

	// 判断上传是否在进行中
	public boolean isInProgress() {
		return "progress".equals(status) || "start".equals(status);
	}
}
