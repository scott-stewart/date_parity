class Date
  class << self 
    def format
      Thread.current[:date_format] || Date::DATE_FORMATS[:db]  || "%Y-%m-%d"
    end
    def format=(format)
      Thread.current[:date_format] = format
    end
  end
end


