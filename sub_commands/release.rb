require_relative "../extensions/string"
require_relative "../extensions/array"
require_relative "../core/git"

class ReleaseSubcommand < Thor
  desc "list", "List of the releases"
  option :dir, default: ".", aliases: "-d", desc: "Git repo directory"
  option :limit, type: :numeric, default: 10, aliases: "-l", desc: "Limit of the list length"

  def list
    begin
      dir = options[:dir]
      git = Git.new

      list = git.tags dir
      list = list.select { |tag| tag.is_valid_version }
      list = list.sort { |tag_a, tag_b| tag_a.compare_versions(tag_b) }
      list = list.last options[:limit]

      list = list.map do |tag|
        commit, date = git.info(dir, tag)
        [tag, date]
      end

      # Output
      column_sizes = [10, 32]

      headers = ["Tag", "Date"]
      puts headers.pretty_row(column_sizes)
      puts "-".pretty_row_separator(column_sizes)

      list.each do |info|
        puts info.pretty_row(column_sizes)
      end
    rescue => error
      puts error
    end
  end
end
