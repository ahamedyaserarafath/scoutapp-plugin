class Elasticsearch_disk < Scout::Plugin
  OPTIONS=<<-EOS
  EOS

  def build_report
    report_hash={}
    
    # subtract one for header row
    report_hash["Elasticsearch Disk Capacity - /dev/root"] = shell("df -h | grep /dev/root | awk '{print $5}' ").to_i - 1
    report_hash["Elasticsearch Disk Capacity - elasticsearch"] = shell("df -h | grep  elasticsearch | awk '{print $5}'").to_i - 1

    report(report_hash)
  end

  # Use this instead of backticks. It's a separate method so it can be stubbed for tests
  def shell(cmd)
    `#{cmd}`
  end
end
