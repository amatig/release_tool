class ASCIITable
  def initialize(data, has_header: false)
    @data = data
    @has_header = has_header
  end

  def print_table
    column_widths = determine_column_widths

    print_separator(column_widths)

    if @has_header
      first_row = @data.shift
      print_row(column_widths, first_row)
      print_separator(column_widths)
    end

    @data.each do |row|
      print_row(column_widths, row)
    end

    print_separator(column_widths)
  end

  def determine_column_widths
    max_widths = []

    @data.each do |row|
      row.each_with_index do |value, index|
        max_widths[index] = [max_widths[index] || 0, value.to_s.length].max
      end
    end

    max_widths
  end

  def print_row(column_widths, values)
    formatted_row = values.each_with_index.map do |value, index|
      value.to_s.ljust(column_widths[index])
    end

    puts "| #{formatted_row.join(" | ")} |"
  end

  def print_separator(column_widths)
    separator = column_widths.map { |width| "-" * width }
    puts "+-#{separator.join("-+-")}-+"
  end
end
