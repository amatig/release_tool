require_relative "../extensions/string"
require_relative "../core/ascii_table"
require_relative "../core/git"

class ReleaseSubcommand < Thor
  desc "list", "List of the releases"
  option :dir, default: ".", aliases: "-d", desc: "Git repo directory"
  option :limit, type: :numeric, default: 10, aliases: "-l", desc: "Limit of the list length"

  def list
    begin
      dir = options[:dir]
      git = Git.new

      list = git.tags(dir: dir)
      list = list.select { |tag| tag.is_valid_version }
      list = list.sort { |tag_a, tag_b| tag_a.compare_versions(tag_b) }
      list = list.last options[:limit]
      list = list.map do |tag|
        info = git.info(dir: dir, tag: tag)
        [tag, info[:date]]
      end

      # Output
      table = ASCIITable.new(headings: ["Tag", "Date"], rows: list)
      table.print_table
    rescue => error
      puts error
    end
  end
end
