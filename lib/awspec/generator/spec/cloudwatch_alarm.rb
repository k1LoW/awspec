module Awspec::Generator
  module Spec
    class CloudwatchAlarm
      include Awspec::Helper::Finder
      def generate_all
        alarms = select_all_cloudwatch_alarms
        raise 'Not Found alarm' if alarms.empty?
        ERB.new(alarm_spec_template, nil, '-').result(binding).chomp
      end

      def alarm_spec_template
        template = <<-'EOF'
<% alarms.each do |alarm| %>
describe cloudwatch_alarm('<%= alarm.alarm_name %>') do
  it { should exist }
<%- alarm.ok_actions.each do |action| -%>
  it { should have_ok_action('<%= action %>') }
<%- end -%>
<%- alarm.alarm_actions.each do |action| -%>
  it { should have_alarm_action('<%= action %>') }
<%- end -%>
<%- alarm.insufficient_data_actions.each do |action| -%>
  it { should have_insufficient_data_action('<%= action %>') }
<%- end -%>
  it { should belong_to_metric('<%= alarm.metric_name %>').namespace('<%= alarm.namespace %>') }
  its(:state_value) { should eq '<%= alarm.state_value %>' }
  its(:statistic) { should eq '<%= alarm.statistic %>' }
  its(:period) { should eq <%= alarm.period %> }
<%- if alarm.unit != nil -%>
  its(:unit) { should eq '<%= alarm.unit %>' }
<% end -%>
  its(:evaluation_periods)  { should eq <%= alarm.evaluation_periods %> }
  its(:datapoints_to_alarm)  { should eq <%= alarm.datapoints_to_alarm %> }
  its(:threshold)  { should eq <%= alarm.threshold %> }
  its(:comparison_operator)  { should eq '<%= alarm.comparison_operator %>' }
end
<% end %>
EOF
        template
      end
    end
  end
end
