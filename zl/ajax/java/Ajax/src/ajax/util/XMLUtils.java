package ajax.util;

public class XMLUtils {
	private static final char[] LT = "&lt;".toCharArray();

	private static final char[] GT = "&gt;".toCharArray();

	private static final char[] AMP = "&amp;".toCharArray();

	private static final char[] QUOT = "&quot;".toCharArray();

	private static final char[] APOS = "&apos;".toCharArray();

	public static String escapeXML(String text) {
		char[] textChars = text.toCharArray();
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < textChars.length; i++) {
			char c = textChars[i];
			switch (c) {
			case '<':
				sb.append(LT, 0, 4);
				break;
			case '>':
				sb.append(GT, 0, 4);
				break;
			case '&':
				sb.append(AMP, 0, 5);
				break;
			case '"':
				sb.append(QUOT, 0, 6);
				break;
			case '\'':
				sb.append(APOS, 0, 6);
				break;
			default:
				sb.append(c);
			}
		}
		return sb.toString();
	}
}
