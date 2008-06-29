require './lib/hella/version'

begin
  require 'echoe'
rescue LoadError
  abort "You'll need to have `echoe' installed to use this Rakefile"
end

version = Hella::Version.to_s.dup
if ENV['SNAPSHOT'].to_i == 1
  version << "." << Time.now.utc.strftime("%Y%m%d%H%M%S")
end

Echoe.new('hella-rb', version) do |p|

  p.author           = "Brennan Dunn"
  p.email            = "me@brennandunn.com"

  p.summary = <<-DESC.strip.gsub(/\n\s+/, " ")
    Hella allows for easy access via XMLRPC to Hellanzb
  DESC

  p.url              = "http://www.brennandunn.com"
  p.need_zip         = true
  p.rdoc_pattern     = /^(lib|README.rdoc)/


end
