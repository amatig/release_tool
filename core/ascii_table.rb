class ASCIITable
  class Row
    attr_accessor :items

    def initialize(items = [])
      @items = items
    end

    def draw(column_widths)
      formatted_row = items.each_with_index.map do |value, index|
        value.to_s.ljust(column_widths[index])
      end

      "| #{formatted_row.join(" | ")} |"
    end
  end

  class Separator < Row
    def draw(column_widths)
      separator = column_widths.map do |width|
        "-" * width
      end

      "+-#{separator.join("-+-")}-+"
    end
  end

  attr_accessor :title, :headings

  def initialize(title: nil, headings: [])
    @title = title
    @headings = headings
    @rows = []

    yield(self) if block_given?
  end

  def add_row(items)
    row = items == :separator ? Separator.new : Row.new(items)
    @rows << row
  end

  def to_s
    column_widths = determine_column_widths
    separator_output = Separator.new.draw(column_widths)

    output = @title ? draw_top_table(column_widths, @title) : []

    output << separator_output

    if !@headings.empty?
      output << Row.new(@headings).draw(column_widths)
      output << separator_output
    end

    @rows.each do |row|
      output << row.draw(column_widths)
    end

    output << separator_output

    output.join("\n")
  end

  def determine_column_widths
    max_widths = []

    @headings.each_with_index do |value, index|
      max_widths[index] = [max_widths[index] || 0, value.to_s.length].max
    end

    @rows.each do |row|
      row.items.each_with_index do |value, index|
        max_widths[index] = [max_widths[index] || 0, value.to_s.length].max
      end
    end

    !max_widths.empty? ? max_widths : [@title&.length || 0]
  end

  def draw_top_table(column_widths, title)
    column_widths_sum = column_widths.reduce(0) { |sum, size| sum + size + 2 }
    total_width = column_widths_sum + column_widths.length - 3

    formatted_title = title
      .center(total_width)
      .slice(0, total_width)

    [
      Separator.new.draw([total_width]),
      "| #{formatted_title} |",
    ]
  end
end
