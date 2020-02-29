
package dev.mvc.tool;

public class Random {
	
	private StringBuilder sb;
	
	public Random(StringBuilder sb) {
		this.sb = sb;
	}
	
	public int getRandom(int count) {
		for(int i =0; i< count; i++) {
			sb.append((int)(Math.random() * 9) + 1);
		}
		try {
			int value = Integer.parseInt(sb.toString());
			sb.delete(0, sb.length());
			return value;
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		return 0;
	}
}
