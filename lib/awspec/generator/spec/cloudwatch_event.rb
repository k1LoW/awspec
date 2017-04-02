module Awspec::Generator
  module Spec
    class CloudwatchEvent
      include Awspec::Helper::Finder
      def generate_all
        events = select_all_cloudwatch_events
        raise 'Not Found event' if events.empty?
        ERB.new(event_spec_template, nil, '-').result(binding).chomp
      end

      def event_spec_template
        template = <<-'EOF'
<% events.each do |event| %>
describe cloudwatch_event('<%= event.name %>') do
  it { should exist }
<%- if event.state == 'ENABLED' -%>
  it { should be_enable }
<% end -%>
  it { should be_scheduled('<%= event.schedule_expression %>') }
end
<% end %>
EOF
        template
      end
    end
  end
end
