package ajax.upload;

import uk.ltd.getahead.dwr.WebContextFactory;

import javax.servlet.http.HttpServletRequest;

public class UploadMonitor {
	public UploadInfo getUploadInfo() {
		HttpServletRequest req = WebContextFactory.get()
				.getHttpServletRequest();

		if (req.getSession().getAttribute("uploadInfo") != null)
			return (UploadInfo) req.getSession().getAttribute("uploadInfo");
		else
			return new UploadInfo();
	}
}
