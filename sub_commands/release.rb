require_relative "../core/common"
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
      list = list.select { |tag| Common.is_valid_tag(tag) }
      list = list.sort { |tagA, tagB| Common.compare_versions(tagA, tagB) }
      list = list.last options[:limit]

      list.each do |tag|
        commit, date = git.info(dir, tag)
        puts tag + " | " + date
      end
    rescue => error
      puts error
    end
  end
end
