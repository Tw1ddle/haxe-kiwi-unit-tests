package kiwi;

import kiwi.Strength;
import utest.Assert;

class TestStrength {
	public function new() {
	}
	
	public function testOrdering() {
		Assert.isTrue(Strength.weak < Strength.medium);
		Assert.isTrue(Strength.medium < Strength.strong);
		Assert.isTrue(Strength.strong < Strength.required);
		Assert.isTrue(Strength.clamp(Strength.required + 1) == Strength.required);
	}
	
	public function testCreation() {
		var s1 = Strength.create(1, 2, 3);
		var s2 = Strength.create(4, 5, 6);
		
		Assert.isTrue(s2 > s1);
	}
}