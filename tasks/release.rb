require_relative "../core/common"
require_relative "../core/git"

class Release
  def initialize
    @git = Git.new
  end

  def list(path)
    begin
      list = @git.tags path
      list = list.select { |tag| Common.is_valid_tag(tag) }
      puts list.sort { |tagA, tagB| Common.compare_versions(tagA, tagB) }
    rescue => error
      puts error
    end
  end
end
