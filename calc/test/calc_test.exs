defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "Test the eval Function" do
    assert Calc.eval("2 + 3") == 5
    assert Calc.eval("5 * 1") == 5
    assert Calc.eval("20 / 4") == 5
    assert Calc.eval("24 / 6 + (5 - 4)") == 5
    assert Calc.eval("1 + 3 * 3 + 1") == 11
    assert Calc.eval("(((3+2*((2+3+4))/2)))") == 12
    assert Calc.eval("3+ 2*3/2 +1") == 7
  end

  test "Test the helper Function" do
    assert Calc.helper('2 + 3',0,0,0) == 5
    assert Calc.helper('5 * 1',0,0,0) == 5
    assert Calc.helper('20 / 4',0,0,0) == 5
    assert Calc.helper('24 / 6 + (5 - 4)',0,0,0) == 5
    assert Calc.helper('1 + 3 * 3 + 1',0,0,0) == 11
    assert Calc.helper('(((3+2*((2+3+4))/2)))',0,0,0) == 12
    assert Calc.helper('3+ 2*3/2 +1',0,0,0) == 7
  end

  test "Test the trimSpaces Function" do
    assert Calc.trimSpaces('  2 + 3') == '2 + 3'
    assert Calc.trimSpaces('2 + 3') == '2 + 3'
    assert Calc.trimSpaces('   23') == '23'
  end

  test "Test the findNumberIndex Function" do
    assert Calc.findNumberIndex('234 + 657',9) == 3
    assert Calc.findNumberIndex('234',3) == 3
    assert Calc.findNumberIndex('23  ',4) == 2
  end

  test "Test the findClosingBracket Function" do
    assert Calc.findClosingBracket('(234)',0,0) == 4
    assert Calc.findClosingBracket('((234))',0,0) == 6
    assert Calc.findClosingBracket('((234+45)+3)',0,0) == 11
  end

  test "Test the findClosingHelper Function" do
    assert Calc.findClosingHelper('(234)',0,1) == 4
    assert Calc.findClosingHelper('((234))',0,1) == 6
    assert Calc.findClosingHelper('((234+45)+3)',0,1) == 11
  end

  test "Test the evalLastOperator Function" do
    assert Calc.evalLastOperator('',4,1,0,0,2) == 4
    assert Calc.evalLastOperator('',6,0,0,0,2) == 2
    assert Calc.evalLastOperator('',8,-1,0,0,2) == -4
  end

end
