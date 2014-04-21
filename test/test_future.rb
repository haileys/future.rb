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

  def test_to_s_running
    fut = Future { sleep }
    assert_equal "#<Future (incomplete)>", fut.to_s
  end

  def test_to_s_complete
    fut = Future { 123 }
    fut.value
    assert_equal "#<Future value=123>", fut.to_s
  end

  def test_to_s_errored
    fut = Future { raise }
    fut.value rescue nil
    assert_equal "#<Future (errored)>", fut.to_s
  end
end
