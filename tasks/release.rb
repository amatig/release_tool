require_relative "../core/config"
require_relative "../core/git"

class Release
  def initialize
    @git = Git.new
  end

  def list(path)
    begin
      list = @git.tags path
      list = list.select { |tag| Config.isValidTag(tag) }
      puts list.sort { |tagA, tagB| Config.compareVersions(tagA, tagB) }
    rescue => error
      puts error
    end
  end
end
