require_relative "../extensions/string"
require_relative "../extensions/array"
require_relative "../core/ascii_table"
require_relative "../core/git"

class ReleaseSubcommand < Thor
  desc "list", "List of the releases"
  option :limit, type: :numeric, default: 10, aliases: "-l", desc: "Limit of the list length"

  def list
    begin
      dir = options[:dir]
      git = Git.new

      tags = git
        .tags(dir: dir)
        .last(options[:limit])

      rows = tags.map do |tag|
        info = git.info(dir: dir, tag: tag)
        [tag, info[:date]]
      end

      table = ASCIITable.new do |t|
        t.title = "List of the releases"
        t.headings = ["Tag", "Date"]
        t.rows = rows
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

      tags = git.tags(dir: dir)
      tag = options[:version] || tags.last
      prev_tag = tags.find_prev(tag)
      info = git.info(dir: dir, tag: tag)

      full_info = [
        ["Version", tag],
        ["Commit", info[:commit]],
        ["Date", info[:date]],
        ["", ""],
      ]

      merges = git
        .log(dir: dir, from: prev_tag, to: tag)
        .each_with_index
        .map { |merge, index| [index == 0 ? "Log #{prev_tag}..#{tag}" : "", merge] }

      rows = full_info + merges

      table = ASCIITable.new do |t|
        t.title = "Release info"
        t.rows = rows
      end

      puts table
    rescue => error
      puts error
    end
  end
end
