module Feeds::Items::DailyHelper
  def op_description(date, items)
    "On #{l date.to_date, format: :long}, there were #{items.records_count} updates, including #{titles(items)} etc."
  end

  def titles(items)
    items.records.first(3).map { |item| "\"#{item.title}\"" }.join(', ')
  end
end
