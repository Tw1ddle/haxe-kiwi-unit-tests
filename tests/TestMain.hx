package;

import kiwi.TestConstraint;
import kiwi.TestDebugHelper;
import kiwi.TestExpression;
import kiwi.TestRow;
import kiwi.TestSolver;
import kiwi.TestStrength;
import kiwi.TestSymbol;
import kiwi.TestSymbolics;
import kiwi.TestTerm;
import kiwi.TestUtil;
import kiwi.TestVariable;
import kiwi.frontend.TestConstraintParser;
import kiwi.frontend.TestVarResolver;
import utest.Runner;
import utest.ui.Report;

class TestMain {
	static function main() {
		var runner = new Runner();
		runner.addCase(new TestConstraint());
		runner.addCase(new TestDebugHelper());
		runner.addCase(new TestExpression());
		runner.addCase(new TestRow());
		runner.addCase(new TestSolver());
		runner.addCase(new TestStrength());
		runner.addCase(new TestSymbol());
		runner.addCase(new TestSymbolics());
		runner.addCase(new TestTerm());
		runner.addCase(new TestUtil());
		runner.addCase(new TestVariable());
		runner.addCase(new TestConstraintParser());
		runner.addCase(new TestVarResolver());
		Report.create(runner);
		runner.run();
	}
}