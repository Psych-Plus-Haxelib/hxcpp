package;

class Progress {
	public var current:Int;
	public var total:Int;
	public var currentFile:String = "";

	public function new(inCurrent:Int, inTotal:Int) {
		current = inCurrent;
		total = inTotal;
	}

	public function progress(inCurrent:Int) {
		current += inCurrent;
	}

	public function setFile(fileName:String) {
		currentFile = fileName;
	}

	public function getProgress() {
		var percent = current / total;
		var pct = Std.int(percent * 1000) / 10;
		var str = Std.string(pct);
		if (Std.int(pct) == pct) {
			str += ".0";
		}
		while (str.length < 4)
			str = " " + str;
		return "[" + str + "%]";
	}

	public function getFormattedProgress():String {
		var safeTotal = total <= 0 ? 1 : total;
		var percent = Std.int((current / safeTotal) * 100);
		if (percent < 0) percent = 0;
		if (percent > 100) percent = 100;

		var width = 20;
		var full = Std.int(percent / 5);
		var remainder = percent % 5;
		var hasHalf = remainder >= 3 && full < width;
		var empty = width - full - (hasHalf ? 1 : 0);

		var green = "\x1b[32m";
		var yellow = "\x1b[33m";
		var red = "\x1b[31m";
		var reset = "\x1b[0m";

		var bar = "";
		for (i in 0...full) bar += green + "#" + reset;
		if (hasHalf) bar += yellow + "=" + reset;
		for (i in 0...empty) bar += red + "-" + reset;

		return "[" + bar + "] " + percent + "%";
	}
}

