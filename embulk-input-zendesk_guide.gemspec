
Gem::Specification.new do |spec|
  spec.name          = "embulk-input-zendesk_guide"
  spec.version       = "0.1.0"
  spec.authors       = ["Yasuhisa Yoshida"]
  spec.summary       = "Zendesk Guide input plugin for Embulk"
  spec.description   = "Loads records from Zendesk Guide."
  spec.email         = ["syou6162@gmail.com"]
  spec.licenses      = ["MIT"]
  spec.homepage      = "https://github.com/syou6162/embulk-input-zendesk_guide"

  spec.files         = `git ls-files`.split("\n") + Dir["classpath/*.jar"]
  spec.test_files    = spec.files.grep(%r{^(test|spec)/})
  spec.require_paths = ["lib"]

  #spec.add_dependency 'YOUR_GEM_DEPENDENCY', ['~> YOUR_GEM_DEPENDENCY_VERSION']
  spec.add_development_dependency 'embulk', ['>= 0.9.23']
  spec.add_development_dependency 'bundler', ['>= 1.10.6']
  spec.add_development_dependency 'rake', ['>= 10.0']
end
