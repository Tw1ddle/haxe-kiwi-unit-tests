package kiwi;

import haxe.Timer;
import kiwi.Constraint;
import kiwi.Expression;
import kiwi.frontend.ConstraintParser;
import kiwi.frontend.VarResolver;
import kiwi.Solver;
import kiwi.Term;
import kiwi.Variable;
import utest.Assert;

class TestStrengths {
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

class TestExpressions {
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

class TestConstraints {
	public function test() {
		Assert.isTrue(true); // TODO
	}
}

class SolverTests {
	public function new() {}
	
	public function testAddRemoveConstraints() {
		
		try {
			var solver = new Solver();
			var resolver = new VarResolver();
			
			var constraints = new Array<Constraint>();
			
			trace("Parsing constraint strings");
			Timer.measure(function() {
				solver.addConstraint(ConstraintParser.parseConstraint("Var_0 == 100", resolver));
				
				for (i in 1...1001) {
					var constraintString = "Var_" + Std.string(i) + " == 100 + " + "Var_" + Std.string(i - 1);
					var constraint = ConstraintParser.parseConstraint(constraintString, resolver);
					constraints.push(constraint);
				}
			});
			
			trace("Adding " + constraints.length + " constraints to solver");
			Timer.measure(function() {
				for (constraint in constraints) {
					solver.addConstraint(constraint);
				}
			});
			
			trace("Confirming that constraints were added to solver");
			Timer.measure(function() {
				for (constraint in constraints) {
					Assert.isTrue(solver.hasConstraint(constraint));
				}
			});
			
			trace("Removing constraints from solver");
			Timer.measure(function() {
				for (constraint in constraints) {
					solver.removeConstraint(constraint);
				}
			});
		
		} catch(msg:String) {
			trace("Error occurred: " + msg);
			Assert.isTrue(false);
		}
		
		Assert.isTrue(true);
	}
	
	public function testAddRemoveEditVars() {
		
		try {
			var solver = new Solver();
			var vars = new Array<Variable>();
			
			trace("Creating variables");
			Timer.measure(function() {
				for (i in 0...1000) {
					vars.push(new Variable("Var_" + Std.string(i)));
				}
			});
			
			trace("Adding " + vars.length + " edit variables to solver");
			Timer.measure(function() {
				for (i in 0...vars.length) {
					solver.addEditVariable(vars[i], Strength.create(Math.random(), Math.random(), Math.random(), 1.0));
				}
			});
			
			trace("Confirming edit vars were added to solver");
			Timer.measure(function() {
				for (i in 0...vars.length) {
					Assert.isTrue(solver.hasEditVariable(vars[i]));
				}
			});
			
			trace("Suggesting values to solver");
			Timer.measure(function() {
				for (i in 0...vars.length) {
					solver.suggestValue(vars[i], Math.random() * 10000);
				}
			});
			
			trace("Removing edit variables from solver");
			Timer.measure(function() {
				for (i in 0...vars.length) {
					solver.removeEditVariable(vars[i]);
				}
			});
		} catch(msg:String) {
			trace("Error occurred: " + msg);
			Assert.isTrue(false);
		}
		
		Assert.isTrue(true);
	}
	
	public function testConstraintStrengths() {
		
		try {
			var solver = new Solver();
			var resolver = new VarResolver();
			
			var x = resolver.resolveVariable("x");
			
			var weak = addConstraint(solver, ConstraintParser.parseConstraint("x == 100", "weak", resolver));
			var medium = addConstraint(solver, ConstraintParser.parseConstraint("x == 200", "medium", resolver));
			var strong = addConstraint(solver, ConstraintParser.parseConstraint("x == 300", "strong", resolver));
			var required = addConstraint(solver, ConstraintParser.parseConstraint("x == 400", "required", resolver));
			
			solver.updateVariables();
			Assert.isTrue(x.value == 400);
			solver.removeConstraint(required);
			solver.updateVariables();
			Assert.isTrue(x.value == 300);
			solver.removeConstraint(strong);
			solver.updateVariables();
			Assert.isTrue(x.value == 200);
			solver.removeConstraint(medium);
			solver.updateVariables();
			Assert.isTrue(x.value == 100);
			solver.removeConstraint(weak);
			solver.updateVariables();
			Assert.isTrue(x.value == 0);
			
		} catch(msg:String) {
			trace("Error occurred: " + msg);
			Assert.isTrue(false);
		}
		
		Assert.isTrue(true);
		
	}
	
	private function addConstraint(solver:Solver, constraint:Constraint):Constraint {
		solver.addConstraint(constraint);
		return constraint;
	}
}