require 'openssl'
require 'soap/wsdlDriver'

module PaymentsGateway
  dir = File.dirname(__FILE__) + '/payments_gateway'
  $LOAD_PATH.unshift(dir)
  Dir[File.join(dir, "*.rb")].each {|file| require File.basename(file) }
end

