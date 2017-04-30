package kiwi.frontend;

import kiwi.frontend.ConstraintParser;
import utest.Assert;

@:access(kiwi.frontend.ConstraintParser)
class TestConstraintParser {
	/*
	 * Runtime parser tests for strings -> Kiwi constraints.
	 * Adapted from Alex Birkett's kiwi-java port: https://github.com/alexbirkett/kiwi-java
	 */
	public function new() {
	}
	
	public function testInfixToPostfixBasic():Void {
		var infix:Array<String> = ["3", "+", "4", "*", "2", "/", "(", "1", "-", "5", ")", "^", "2", "^", "3"];
		var postfix:Array<String> = ConstraintParser.infixToPostfix(infix);
		var index = 0;
		Assert.isTrue(postfix[index++] == "3");
		Assert.isTrue(postfix[index++] == "4");
		Assert.isTrue(postfix[index++] == "2");
		Assert.isTrue(postfix[index++] == "*");
		Assert.isTrue(postfix[index++] == "1");
		Assert.isTrue(postfix[index++] == "5");
		Assert.isTrue(postfix[index++] == "-");
		Assert.isTrue(postfix[index++] == "2");
		Assert.isTrue(postfix[index++] == "3");
		Assert.isTrue(postfix[index++] == "^");
		Assert.isTrue(postfix[index++] == "^");
		Assert.isTrue(postfix[index++] == "/");
		Assert.isTrue(postfix[index++] == "+");
	}
}