package ajax.upload;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;

import java.io.File;

public class MonitoredDiskFileItemFactory extends DiskFileItemFactory {
	private OutputStreamListener listener = null; // 自定义监听器类

	// 扩展方法，增加listener参数
	public MonitoredDiskFileItemFactory(OutputStreamListener listener) {
		super();
		this.listener = listener;
	}

	// 扩展方法，增加listener参数
	public MonitoredDiskFileItemFactory(int sizeThreshold, File repository,
			OutputStreamListener listener) {
		super(sizeThreshold, repository);
		this.listener = listener;
	}

	// 覆盖方法，通过重写createItem方法返回扩展后的MonitoredDiskFileItem
	public FileItem createItem(String fieldName, String contentType,
			boolean isFormField, String fileName) {
		return new MonitoredDiskFileItem(fieldName, contentType, isFormField,
				fileName, getSizeThreshold(), getRepository(), listener);
	}
}
