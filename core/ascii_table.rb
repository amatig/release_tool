class ASCIITable
  def initialize(data)
    @data = data
  end

  def print_table
    column_widths = determine_column_widths

    if @data[:title]
      print_title(column_widths, @data[:title])
    end

    print_separator(column_widths)

    if @data[:headings]
      print_row(column_widths, @data[:headings])
      print_separator(column_widths)
    end

    @data[:rows].each do |row|
      print_row(column_widths, row)
    end

    print_separator(column_widths)
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

    max_widths
  end

  def print_title(column_widths, value)
    internal_column_sum = column_widths.reduce(0) { |sum, size| sum + size + 2 }
    total_sum = internal_column_sum + column_widths.length - 1

    print_separator([total_sum - 2])
    puts "|#{value.center(total_sum).slice(0, total_sum)}|"
  end

  def print_row(column_widths, values)
    formatted_row = values.each_with_index.map do |value, index|
      value.to_s.ljust(column_widths[index])
    end

    puts "| #{formatted_row.join(" | ")} |"
  end

  def print_separator(column_widths)
    separator = column_widths.map do |width|
      "-" * width
    end

    puts "+-#{separator.join("-+-")}-+"
  end
end
