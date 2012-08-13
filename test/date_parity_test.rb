require 'date_parity/test_helper'

class DateParityTest < MiniTest::Unit::TestCase

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
    assert_equal date_hash,  Date._parse("08/12/2012")

    Date.format = "%d/%m/%Y"
    assert_equal date_hash,  Date._parse("12/08/2012")

    Date.format = '%Y-%m-%d'
    assert_equal date_hash,  Date._parse("2012-08-12")

    Date.format = '%d.%m.%Y'
    assert_equal date_hash,  Date._parse("12.08.2012")

    Date.format = '%Y.%m.%d'
    assert_equal date_hash,  Date._parse("2012.08.12")

    Date.format = '%Y/%m/%d'
    assert_equal date_hash,  Date._parse("2012/08/12")
  end

  def test_string_to_date_respects_format
    # This works because Rails ActiveSupport provides 
    # string.to_date, which uses Date._parse
    Date.format = "%m/%d/%Y"
    assert_equal Date.parse("2012-08-12"), "08/12/2012".to_date

    Date.format = "%d/%m/%Y"
    assert_equal Date.parse("2012-08-12"), "12/08/2012".to_date

    Date.format = '%Y-%m-%d'
    assert_equal Date.parse("2012-08-12"), "2012-08-12".to_date

    Date.format = '%d.%m.%Y'
    assert_equal Date.parse("2012-08-12"), "12.08.2012".to_date

    Date.format = '%Y.%m.%d'
    assert_equal Date.parse("2012-08-12"), "2012.08.12".to_date

    Date.format = '%Y/%m/%d'
    assert_equal Date.parse("2012-08-12"), "2012/08/12".to_date
  end

  def test_invalid_date_still_raises_argument_error
    # Assert that the normal ArgumentError that gets 
    # raised in Rails when parsing an invalid string
    # to_date still gets raised
    assert_raises ArgumentError, 'invalid date' do
      "12/31/2012".to_date
    end
  end

  def full_date_parity
    Date.format = "%m/%d/%Y"
    date = Date.parse("2012-12-31")
    assert date, date.to_s.to_date

    assert "12/31/2012", "12/31/2012".to_date.to_s
  end

end
