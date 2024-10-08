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

      data = git.tags(dir: dir)
      data = data.select { |tag| tag.is_valid_version }
      data = data.sort { |tag_a, tag_b| tag_a.compare_versions(tag_b) }
      data = data.last options[:limit]
      data = data.map do |tag|
        commit, date = git.info(dir: dir, tag: tag)
        [tag, date]
      end

      # Output
      table = ASCIITable.new(data.unshift(["Tag", "Date"]), has_header: true)
      table.print_table
    rescue => error
      puts error
    end
  end
end
