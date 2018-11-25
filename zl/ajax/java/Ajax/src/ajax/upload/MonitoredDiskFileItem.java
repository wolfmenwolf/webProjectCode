package ajax.upload;

import org.apache.commons.fileupload.disk.DiskFileItem;

import java.io.File;
import java.io.OutputStream;
import java.io.IOException;

public class MonitoredDiskFileItem extends DiskFileItem {
	private MonitoredOutputStream mos = null; // 自定义输出流

	private OutputStreamListener listener; // 自定义监听器类

	// 扩展方法，增加listener参数
	public MonitoredDiskFileItem(String fieldName, String contentType,
			boolean isFormField, String fileName, int sizeThreshold,
			File repository, OutputStreamListener listener) {
		super(fieldName, contentType, isFormField, fileName, sizeThreshold,
				repository);
		this.listener = listener;
	}

	// 覆盖方法，返回扩展后的MonitoredOutputStream
	public OutputStream getOutputStream() throws IOException {
		if (mos == null) {
			mos = new MonitoredOutputStream(super.getOutputStream(), listener);
		}
		return mos;
	}
}
