require_relative "../extensions/string"
require_relative "../core/ascii_table"
require_relative "../core/git"

class ReleaseSubcommand < Thor
  desc "list", "List of the releases"
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

      table = ASCIITable.new do |t|
        t.title = "List of the releases"
        t.headings = ["Tag", "Date"]
        t.rows = list
      end

      puts table
    rescue => error
      puts error
    end
  end

  desc "info", "Release info (default is last)"
  option :version, default: nil, aliases: "-v", desc: "Version (default is last)"

  def info
    begin
      dir = options[:dir]
      git = Git.new

      puts "OK"
    rescue => error
      puts error
    end
  end
end
