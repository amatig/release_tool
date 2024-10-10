class ASCIITable
  def initialize(data = {})
    @data = data
  end

  def to_s
    column_widths = determine_column_widths

    output = []

    if @data[:title]
      output << printable_title(column_widths, @data[:title])
    end

    output << printable_separator(column_widths)

    if @data[:headings]
      output << printable_row(column_widths, @data[:headings])
      output << printable_separator(column_widths)
    end

    @data[:rows]&.each do |row|
      output << printable_row(column_widths, row)
    end

    output << printable_separator(column_widths)

    output.join("\n")
  end

  def determine_column_widths
    max_widths = []

    @data[:headings]&.each_with_index do |value, index|
      max_widths[index] = [max_widths[index] || 0, value.to_s.length].max
    end

    @data[:rows]&.each do |row|
      row.each_with_index do |value, index|
        max_widths[index] = [max_widths[index] || 0, value.to_s.length].max
      end
    end

    max_widths.length == 0 ? [@data[:title]&.length || 0] : max_widths
  end

  def printable_title(column_widths, value)
    internal_column_sum = column_widths.reduce(0) { |sum, size| sum + size + 2 }
    total_sum = internal_column_sum + column_widths.length - 1

    output = []

    output << printable_separator([total_sum - 2])
    output << "|#{value.center(total_sum).slice(0, total_sum)}|"

    output
  end

  def printable_row(column_widths, values)
    formatted_row = values.each_with_index.map do |value, index|
      value.to_s.ljust(column_widths[index])
    end

    "| #{formatted_row.join(" | ")} |"
  end

  def printable_separator(column_widths)
    separator = column_widths.map do |width|
      "-" * width
    end

    "+-#{separator.join("-+-")}-+"
  end
end
