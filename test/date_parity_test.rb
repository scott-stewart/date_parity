require 'date_parity/test_helper'

class DateParityTest < MiniTest::Unit::TestCase

  def setup
    # Reset Date.format from previous test
    Date.format = nil
  end

  def test_date_to_string_respects_format
    date = Date.parse("2012-08-12")
    Date.format = "%m/%d/%Y"
    assert_equal "08/12/2012", date.to_s

    Date.format = "%d/%m/%Y"
    assert_equal "12/08/2012", date.to_s

    Date.format = '%Y-%m-%d'
    assert_equal "2012-08-12", date.to_s

    Date.format = '%d.%m.%Y'
    assert_equal "12.08.2012", date.to_s

    Date.format = '%Y.%m.%d'
    assert_equal "2012.08.12", date.to_s

    Date.format = '%Y/%m/%d'
    assert_equal "2012/08/12", date.to_s

  end

 def test_date_parse
    date_hash = { :year => 2012, :mon => 8, :mday => 12 }

    Date.format = "%m/%d/%Y"
    assert_equal date_hash[:mday],  Date.parse("08/12/2012").mday
    assert_equal date_hash[:mon],  Date.parse("08/12/2012").mon
    assert_equal date_hash[:year],  Date.parse("08/12/2012").year

    Date.format = "%d/%m/%Y"
    assert_equal date_hash[:mday],  Date.parse("12/08/2012").mday
    assert_equal date_hash[:mon],  Date.parse("12/08/2012").mon
    assert_equal date_hash[:year],  Date.parse("12/08/2012").year

    Date.format = '%Y-%m-%d'
    assert_equal date_hash[:mday],  Date.parse("2012-08-12").mday
    assert_equal date_hash[:mon],  Date.parse("2012-08-12").mon
    assert_equal date_hash[:year],  Date.parse("2012-08-12").year

    Date.format = '%d.%m.%Y'
    assert_equal date_hash[:mday],  Date.parse("12.08.2012").mday
    assert_equal date_hash[:mon],  Date.parse("12.08.2012").mon
    assert_equal date_hash[:year],  Date.parse("12.08.2012").year

    Date.format = '%Y.%m.%d'
    assert_equal date_hash[:mday],  Date.parse("2012.08.12").mday
    assert_equal date_hash[:mon],  Date.parse("2012.08.12").mon
    assert_equal date_hash[:year],  Date.parse("2012.08.12").year

    Date.format = '%Y/%m/%d'
    assert_equal date_hash[:mday],  Date.parse("2012/08/12").mday
    assert_equal date_hash[:mon],  Date.parse("2012/08/12").mon
    assert_equal date_hash[:year],  Date.parse("2012/08/12").year
  end

  def test_string_to_date_respects_format
    # This works because Rails ActiveSupport provides 
    # string.to_date, which uses Date._parse
    Date.format = "%m/%d/%Y"
    assert_equal Date.parse_without_date_parity_format("2012-08-12"), "08/12/2012".to_date

    Date.format = "%d/%m/%Y"
    assert_equal Date.parse_without_date_parity_format("2012-08-12"), "12/08/2012".to_date

    Date.format = '%Y-%m-%d'
    assert_equal Date.parse_without_date_parity_format("2012-08-12"), "2012-08-12".to_date

    Date.format = '%d.%m.%Y'
    assert_equal Date.parse_without_date_parity_format("2012-08-12"), "12.08.2012".to_date

    Date.format = '%Y.%m.%d'
    assert_equal Date.parse_without_date_parity_format("2012-08-12"), "2012.08.12".to_date

    Date.format = '%Y/%m/%d'
    assert_equal Date.parse_without_date_parity_format("2012-08-12"), "2012/08/12".to_date
  end

  def test_invalid_date_still_raises_argument_error
    # Assert that the normal ArgumentError that gets 
    # raised in Rails when parsing an invalid string
    # to_date still gets raised
    assert_raises ArgumentError, 'invalid date' do
      "12/31/2012".to_date
    end
  end

  def test_full_date_parity
    Date.format = "%m/%d/%Y"
    date = Date.parse_without_date_parity_format("2012-12-31")
    assert date, date.to_s.to_date

    assert "12/31/2012", "12/31/2012".to_date.to_s
  end

  def test__parse_also_respects_data_format
    Date.format = "%m/%d/%Y"
    date_parts = Date._parse_without_date_parity_format("1/25/2014")
    assert date_parts[:year], 2014
    assert date_parts[:mon], 1
    assert date_parts[:mday], 25
  end

end
