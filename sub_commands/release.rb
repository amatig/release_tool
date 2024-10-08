require_relative "../core/common"
require_relative "../core/git"

class ReleaseSubcommand < Thor
  desc "list", "List of the releases"
  option :dir, default: ".", aliases: "-d", desc: "Git repo directory"
  option :limit, type: :numeric, default: 10, aliases: "-l", desc: "Limit of the list length"

  def list
    begin
      git = Git.new

      list = git.tags options[:dir]
      list = list.select { |tag| Common.is_valid_tag(tag) }
      list = list.sort { |tagA, tagB| Common.compare_versions(tagA, tagB) }

      puts list.last options[:limit]
    rescue => error
      puts error
    end
  end
end
