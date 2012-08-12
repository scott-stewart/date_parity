class String

  def to_date_from_formatted_string
    return nil if self.blank?
    Date.strptime(self, Date.format)
  rescue
    to_rails_date
  end

  alias_method :to_rails_date, :to_date
  alias_method :to_date, :to_date_from_formatted_string

end
