package kiwi;

import kiwi.Expression;
import utest.Assert;

class TestExpression {
	public function new() {
	}
	
	public function test() {
		var a = new Expression();
		var b = new Expression();
		
		Assert.isTrue(a.constant == b.constant && a.constant == 0);
		Assert.isTrue(a.isConstant() && b.isConstant());
		Assert.isTrue(a.terms.length == 0 && b.terms.length == 0);
		Assert.isTrue(a.value() == 0 && b.value() == 0);
		
		var c = new Expression([ new Term(new Variable("a", 1), 2) ], 3);
		var d = new Expression([ new Term(new Variable("b", 1), 3) ], 4);
		
		Assert.isTrue(c.constant == 3 && d.constant == 4);
		Assert.isTrue(!c.isConstant() && !d.isConstant());
		Assert.isTrue(c.terms.length == 1 && d.terms.length == 1);
		Assert.isTrue(c.value() == 5 && d.value() == 7);
	}
}