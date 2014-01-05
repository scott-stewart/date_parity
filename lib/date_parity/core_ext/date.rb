class Date
  class << self 
    def format
      Thread.current[:date_format] || Date::DATE_FORMATS[:db]  || "%Y-%m-%d"
    end
    def format=(format)
      Thread.current[:date_format] = format
    end

    def _parse_with_date_parity_format(string, comp=false)
      return _parse_without_date_parity_format(string, comp) if string.blank? or Date.format.blank?
      # Normalize date by first respecting custom date_parity Date.format, 
      # then formatting back to iso/db string so normal ::Date._parse call can succeed.
      _parse_without_date_parity_format(Date.strptime(string, Date.format).to_s(:db), comp)
    rescue
      _parse_without_date_parity_format(string, comp)
    end

    def parse_with_date_parity_format(string, comp=false)
      return parse_without_date_parity_format(string, comp) if string.blank? or Date.format.blank?
      # Normalize date by first respecting custom date_parity Date.format, 
      # then formatting back to iso/db string so normal ::Date.parse call can succeed.
      parse_without_date_parity_format(Date.strptime(string, Date.format).to_s(:db), comp)
    rescue
      parse_without_date_parity_format(string, comp)
    end

    alias_method_chain :_parse, :date_parity_format
    alias_method_chain :parse, :date_parity_format

  end

end


