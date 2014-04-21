require "minitest/autorun"
require "future"

class TestFuture < MiniTest::Test
  def test_future
    assert_kind_of Future, Future { 123 }
  end

  def test_value
    assert_equal 123, Future { 123 }.value
  end

  def test_all
    assert_equal [123, 456, 789], Future.all([
      Future { 123 },
      Future { 456 },
      Future { 789 },
    ]).value
  end
end
