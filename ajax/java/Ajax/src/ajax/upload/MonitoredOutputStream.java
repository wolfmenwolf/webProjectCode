package ajax.upload;

import java.io.OutputStream;
import java.io.IOException;

public class MonitoredOutputStream extends OutputStream {
	private OutputStream target;

	private OutputStreamListener listener; // 自定义监听器

	public MonitoredOutputStream(OutputStream target,
			OutputStreamListener listener) {
		this.target = target;
		this.listener = listener;
		this.listener.start();
	}

	// 覆盖方法
	public void write(byte b[], int off, int len) throws IOException {
		target.write(b, off, len);
		listener.bytesRead(len - off);
	}

	// 覆盖方法
	public void write(byte b[]) throws IOException {
		target.write(b);
		listener.bytesRead(b.length);
	}

	// 实现方法
	public void write(int b) throws IOException {
		target.write(b);
		listener.bytesRead(1);
	}

	// 覆盖方法
	public void close() throws IOException {
		target.close();
		listener.done();
	}

	// 覆盖方法
	public void flush() throws IOException {
		target.flush();
	}
}
