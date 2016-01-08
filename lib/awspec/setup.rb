require 'fileutils'
require 'yaml'

module Awspec
  class Setup
    def self.run
      generate_spec_helper
      generate_rakefile
      generate_dotgitignore
      generate_dotrspec
    end

    def self.generate_spec_helper
      content = <<-'EOF'
require 'awspec'
Awsecrets.load(secrets_path: File.expand_path('./secrets.yml', File.dirname(__FILE__)))
EOF
      dir = 'spec'
      if File.exist? dir
        unless File.directory? dir
          $stderr.puts '!! #{dir} already exists and is not a directory'
        end
      else
        FileUtils.mkdir dir
        puts " + #{dir}/"
      end

      if File.exist? 'spec/spec_helper.rb'
        $stderr.puts '!! spec/spec_helper.rb already exists'
      else
        File.open('spec/spec_helper.rb', 'w') do |f|
          f.puts content
        end
        puts ' + spec/spec_helper.rb'
      end
    end

    def self.generate_rakefile
      content = <<-'EOF'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new('spec')
task :default => :spec
EOF

      if File.exist? 'Rakefile'
        $stderr.puts '!! Rakefile already exists'
      else
        File.open('Rakefile', 'w') do |f|
          f.puts content
        end
        puts ' + Rakefile'
      end
    end

    def self.generate_dotgitignore
      content = <<-'EOF'
secrets.yml
EOF
      if File.exist? 'spec/.gitignore'
        $stderr.puts '!! spec/.gitignore already exists'
      else
        File.open('spec/.gitignore', 'w') do |f|
          f.puts content
        end
        puts ' + spec/.gitignore'
      end
    end

    def self.generate_dotrspec
      content = <<-'EOF'
--color
--format documentation
EOF
      if File.exist? '.rspec'
        $stderr.puts '!! .rspec already exists'
      else
        File.open('.rspec', 'w') do |f|
          f.puts content
        end
        puts ' + .rspec'
      end
    end
  end
end
