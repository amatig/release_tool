require "open4"

class Shell
  def exec(command)
    pid, stdin, stdout, stderr = Open4::popen4 command

    error = stderr.read.strip
    raise error if !error.empty?

    stdout.read.strip.split "\n"
  end
end
