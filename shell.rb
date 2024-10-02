require 'open4'

class Shell

  def execute(command)
    pid, stdin, stdout, stderr = Open4::popen4 command 

    puts stdout.read.strip
  end

end