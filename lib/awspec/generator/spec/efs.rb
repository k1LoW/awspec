module Awspec::Generator
  module Spec
    class Efs
      include Awspec::Helper::Finder
      def generate_all
        file_systems = select_all_file_systems
        raise 'EFS not found' if file_systems.empty?
        specs = file_systems.map do |file_system|
          file_system.name = get_name_by_id(file_system.file_system_id)
          content = ERB.new(file_system_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      def file_system_spec_template
        template = <<-'EOF'
describe efs('<%= file_system.name %>') do
  it { should exist }
  its(:number_of_mount_targets) { should eq <%= file_system.number_of_mount_targets %> }
  its(:life_cycle_state) { should eq '<%= file_system.life_cycle_state %>' }
  its(:performance_mode) { should eq '<%= file_system.performance_mode %>' }
end
EOF
        template
      end
    end
  end
end
