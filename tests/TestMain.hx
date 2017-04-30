package;

import kiwi.ParserTests;
import kiwi.SolverTests;
import utest.Runner;
import utest.ui.Report;

class TestMain {
	static function main() {
		var runner = new Runner();
		runner.addCase(new ParserTests());
		runner.addCase(new SolverTests());
		Report.create(runner);
		runner.run();
	}
}