import sys.io.File;
import haxe.iterators.StringIteratorUnicode;

class Main {
    static public function main() {
        var input = File.getContent("input.txt");
        var iter = StringIteratorUnicode.unicodeIterator(input);
        var prevNum: Null<Int> = null;
        var stack = new StringBuf();
        var increases = 0;
        for (char in iter) {
            if (char >= 48 && char <= 57) {
                stack.addChar(char);
            } else {
                var thisNum = Std.parseInt(stack.toString());
                stack = new StringBuf();
                if (thisNum != null) {
                    if (prevNum != null && thisNum > prevNum) {
                        trace('$thisNum (increased)');
                        increases += 1;
                    } else if (prevNum != null) {
                        trace('$thisNum (decreased)');
                    } else {
                        trace('$thisNum (start)');
                    }
                    prevNum = thisNum;
                }
            }
        }
        var lastNum = Std.parseInt(stack.toString());
        if (lastNum != null) {
            if (lastNum > prevNum) {
                trace('$lastNum (increased)');
                increases += 1;
            } else {
                trace('$lastNum (decreased)');
            }
        }
        trace('Increases: $increases');
    }
}