$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require_relative 'lib/huawei_cloud_sass/version'

Gem::Specification.new do |spec|
  spec.name          = "huawei_cloud_sass"
  spec.version       = HuaweiCloudSass::VERSION
  spec.authors       = ["anke1460"]
  spec.email         = ["zuosjob@gmail.com"]

  spec.summary       = %q{Support for huawei cloud sass market api.}
  spec.description   = %q{This gem provide the core encryption, decryption and signature methods that response to the request of huawei cloud market for sass category products
.}
  spec.homepage      = "https://github.com/anke1460/huawei_cloud_sass"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.files         = Dir['{lib}/**/*'] + %w(LICENSE README.md)
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
