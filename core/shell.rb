require "open3"

class Shell
  def exec(command)
    stdin, stdout, stderr, wait_thr = Open3.popen3 command

    error = stderr
      .read
      .strip

    raise error unless error.empty?

    stdout
      .read
      .strip
      .split("\n")
  end
end
