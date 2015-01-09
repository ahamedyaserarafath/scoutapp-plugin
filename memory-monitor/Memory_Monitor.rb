class MemoryMonitor < Scout::Plugin
  MEM_CONVERSION = 1024
  OPTIONS=<<-EOS
  EOS

  def build_report
    report_hash={}
    
    # subtract one for header row
    report_hash["Page Tables"] = shell("cat /proc/meminfo | grep PageTables | awk '{print $2}'").to_i / MEM_CONVERSION 
    report_hash["Swap Cache"] = shell("cat /proc/meminfo | grep SwapCached | awk '{print $2}'").to_i / MEM_CONVERSION 
    report_hash["Vmalloc Used"] = shell("cat /proc/meminfo | grep VmallocUsed | awk '{print $2}'").to_i / MEM_CONVERSION
    report_hash["Cache"] = shell("cat /proc/meminfo | grep -w Cached | awk '{print $2}'").to_i / MEM_CONVERSION
    report_hash["Buffer"] = shell("cat /proc/meminfo | grep -w Buffers | awk '{print $2}'").to_i / MEM_CONVERSION
    report_hash["Active"] = shell("cat /proc/meminfo | grep -w Active | awk '{print $2}' | head -n 1").to_i / MEM_CONVERSION
    report_hash["InActive"] = shell("cat /proc/meminfo | grep -w Inactive | awk '{print $2}' | head -n 1").to_i / MEM_CONVERSION


    report(report_hash)
  end

  # Use this instead of backticks. It's a separate method so it can be stubbed for tests
  def shell(cmd)
    `#{cmd}`
  end
end
