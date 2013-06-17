require 'puppet'
require 'yaml'

begin
  require 'sematext/metrics'
rescue LoadError => e
  Puppet.info "You need the `sematext-metrics` gem to use the Sematext report"
end

unless Puppet.version >= '2.6.5'
  fail "This report processor requires Puppet version 2.6.5 or later"
end

Puppet::Reports.register_report(:sematext) do

  configfile = File.join([File.dirname(Puppet.settings[:config]), "sematext.yaml"])
  raise(Puppet::ParseError, "Sematext report config file #{configfile} not readable") unless File.exist?(configfile)
  CONFIG = YAML.load_file(configfile)

  desc <<-DESC
  Send metrics to Sematext.
  DESC

  def process
    @host = self.host
    @status = self.status

    send_metrics(self.metrics)
  end

  def send_metrics(metrics)
    Sematext::Metrics.initialize("#{CONFIG[:token]}")
    metrics.each { |metric,data|
      data.values.each { |val|
        name = "puppet_#{val[1]}_#{metric}".downcase.gsub(" ", "_")
        value = val[2]
        Sematext::Metrics.send(
          :name => name,
          :value => value,
          :agg_type => :sum,
          :filter1 => @host,
          :filter2 => @status
        )
      }
    }
  end
end
