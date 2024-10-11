class ASCIITable
  attr_accessor :title, :headings, :rows

  def initialize(title: nil, headings: [], rows: [])
    @title = title
    @headings = headings
    @rows = rows

    yield(self) if block_given?
  end

  def to_s
    column_widths = determine_column_widths

    output = []

    output << printable_top_table(column_widths, @title) if @title
    output << printable_separator(column_widths)

    if !@headings.empty?
      output << printable_row(column_widths, @headings)
      output << printable_separator(column_widths)
    end

    @rows.each do |row|
      output << printable_row(column_widths, row)
    end

    output << printable_separator(column_widths)

    output.join("\n")
  end

  def determine_column_widths
    max_widths = []

    @headings.each_with_index do |value, index|
      max_widths[index] = [max_widths[index] || 0, value.to_s.length].max
    end

    @rows.each do |row|
      row.each_with_index do |value, index|
        max_widths[index] = [max_widths[index] || 0, value.to_s.length].max
      end
    end

    !max_widths.empty? ? max_widths : [@title&.length || 0]
  end

  def printable_top_table(column_widths, title)
    column_widths_sum = column_widths.reduce(0) { |sum, size| sum + size + 2 }
    total_width = column_widths_sum + column_widths.length - 3

    formatted_title = title
      .center(total_width)
      .slice(0, total_width)

    [
      printable_separator([total_width]),
      "| #{formatted_title} |",
    ]
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
