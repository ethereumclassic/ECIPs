# frozen_string_literal: true

require_relative 'lib/ecip_validator'

desc 'Validate ECIP specifications'
task :validate do
  files = Dir['_specs/**/*.md']
  puts "Validating #{files.length} ECIP files..."
  EcipValidator::Runner.run(files)
end

task default: :validate
