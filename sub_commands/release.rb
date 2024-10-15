require_relative "../extensions/string"
require_relative "../extensions/array"
require_relative "../core/ascii_table"
require_relative "../core/git"

class ReleaseSubcommand < Thor
  desc "list", "List of the releases"
  option :limit, type: :numeric, default: 10, desc: "Max num of items"

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
        rows.each do |row|
          t.add_row row
        end
      end

      puts table
    rescue => error
      puts error
    end
  end

  desc "info", "Release info"
  option :version, default: "last", desc: "Version"
  option :show_dates, type: :boolean, default: false, desc: "Show dates"

  def info
    begin
      dir = options[:dir]
      git = Git.new

      tags = git.tags(dir: dir)
      tag = options[:version] == "last" ? tags.last : options[:version]
      prev_tag = tags.find_prev(tag)
      info = git.info(dir: dir, tag: tag)

      merges = git
        .log(dir: dir, from: prev_tag, to: tag, show_dates: options[:show_dates])
        .each_with_index
        .map { |merge, index| [index == 0 ? "Log #{prev_tag}..#{tag}" : "", merge] }

      table = ASCIITable.new do |t|
        t.title = "Release info"
        t.add_row ["Version", tag]
        t.add_row ["Commit", info[:commit]]
        t.add_row ["Date", info[:date]]
        t.add_row :separator
        merges.each do |merge|
          t.add_row merge
        end
      end

      puts table
    rescue => error
      puts error
    end
  end

  desc "find", "Find release by ticket"
  option :ticket, desc: "Ticket number"

  def find
    begin
      ticket = options[:ticket]

      unless ticket
        return help(:find)
      end

      dir = options[:dir]
      git = Git.new

      commit_hash = git.find_commit(dir: dir, ticket: ticket)
      tag = git
        .tags(dir: dir, contains: commit_hash)
        .first

      table = ASCIITable.new do |t|
        t.title = "Find release"
        t.add_row ["Ticket #{ticket} merged in #{tag}"]
      end

      puts table
    rescue => error
      puts error
    end
  end
end
