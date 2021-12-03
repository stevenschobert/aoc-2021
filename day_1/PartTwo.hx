import sys.io.File;
import haxe.iterators.StringIteratorUnicode;

class PartTwo {
    public static function main() {
        var input = File.getContent("input.txt");
        var iter = StringIteratorUnicode.unicodeIterator(input);
        
        var prevSum: Null<Int> = null;
        var stack = new StringBuf();
        var window: Array<Null<Int>> = [null, null, null];
        var numberCount = 0;
        var increases = 0;
        
        for (charCode in iter) {
            if (charCode >= 48 && charCode <= 57) {
                stack.addChar(charCode);
            } else {
                var thisNum = Std.parseInt(stack.toString());
                stack = new StringBuf();
                if (thisNum != null) {      
                    var threeAgoCount = numberCount - 3;
                    var threeAgoNumber: Null<Int> = null;
                    var currentSum: Int = thisNum;

                    if (prevSum != null) {
                        currentSum += prevSum;
                    }

                    if (threeAgoCount >= 0) {
                        threeAgoNumber = window[threeAgoCount % 3];
                        if (threeAgoNumber != null) {
                            currentSum -= threeAgoNumber;
                        }
                    }

                    if (numberCount >= 3) {
                        if (currentSum > prevSum) {
                            increases += 1;
                            trace('$currentSum (increase)');
                        } else {
                            trace('$currentSum (decrease)');
                        }
                    } else if (numberCount >= 2) {
                        trace('$currentSum (start)');
                    }

                    window[numberCount % 3] = thisNum;
                    numberCount += 1;
                    prevSum = currentSum;
                }
            }
        }

        var lastNum = Std.parseInt(stack.toString());
        if (lastNum != null) {
            var threeAgoCount = numberCount - 3;
            var threeAgoNumber: Null<Int> = null;
            var currentSum: Int = lastNum;

            if (prevSum != null) {
                currentSum += prevSum;
            }

            if (threeAgoCount >= 0) {
                threeAgoNumber = window[threeAgoCount % 3];
                if (threeAgoNumber != null) {
                    currentSum -= threeAgoNumber;
                }
            }

            if (numberCount >= 3) {
                if (prevSum != null) {
                    if (currentSum > prevSum) {
                        increases += 1;
                        trace('$currentSum (increase)');
                    } else {
                        trace('$currentSum (decrease)');
                    }
                } else {
                    trace('$currentSum (start)');
                }
            }
        }

        trace('Increases: $increases');
    }
}