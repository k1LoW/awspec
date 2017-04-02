module Awspec::Generator
  module Spec
    class CloudwatchLogs
      include Awspec::Helper::Finder
      def generate_all
        log_groups = select_all_cloudwatch_logs_log_groups
        raise 'Not Found Log Group' if log_groups.empty?
        specs = log_groups.map do |log_group|
          log_stream_line = generate_log_stream_spec(log_group.log_group_name)
          metric_filter_lines = generate_log_metric_filters_specs(log_group.log_group_name)
          subscription_filter_lines = generate_log_subscription_filters_specs(log_group.log_group_name)
          content = ERB.new(cloudwatch_logs_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      def generate_log_stream_spec(log_group)
        req = { log_group_name: log_group }
        log_streams = []
        loop do
          res = cloudwatch_logs_client.describe_log_streams(req)
          log_streams.push(*res.log_streams)
          break if res.next_token.nil?
          req[:next_token] = res.next_token
        end
        "it { should have_log_stream('#{log_streams.last.log_stream_name}') }" unless log_streams.last.nil?
      end

      def generate_log_metric_filters_specs(log_group)
        req = { log_group_name: log_group }
        metric_filters = []
        loop do
          res = cloudwatch_logs_client.describe_metric_filters(req)
          metric_filters.push(*res.metric_filters)
          break if res.next_token.nil?
          req[:next_token] = res.next_token
        end
        metric_filter_lines = []
        metric_filters.each do |metric_filter|
          line = "it { should have_metric_filter('#{metric_filter.filter_name}') }"
          metric_filter_lines.push(line)
        end
        metric_filter_lines
      end

      def generate_log_subscription_filters_specs(log_group)
        req = { log_group_name: log_group }
        subscription_filters = []
        loop do
          res = cloudwatch_logs_client.describe_subscription_filters(req)
          subscription_filters.push(*res.subscription_filters)
          break if res.next_token.nil?
          req[:next_token] = res.next_token
        end
        subscription_filter_lines = []
        subscription_filters.each do |subscription_filter|
          line = "it { should have_subscription_filter('#{subscription_filter.filter_name}')"
          unless subscription_filter.filter_pattern.empty?
            line += ".filter_pattern('#{subscription_filter.filter_pattern}')"
          end
          line += ' }'
          subscription_filter_lines.push(line)
        end
        subscription_filter_lines
      end

      def cloudwatch_logs_spec_template
        template = <<-'EOF'
describe cloudwatch_logs('<%= log_group.log_group_name %>') do
  it { should exist }
<%- unless log_group.retention_in_days.nil? -%>
  its(:retention_in_days) { should eq <%= log_group.retention_in_days %> }
<% end -%>
<%- unless log_stream_line.nil? -%>
  <%= log_stream_line %>
<% end -%>
<% metric_filter_lines.each do |metric_filter_line| %>
  <%= metric_filter_line %>
<% end %>
<% subscription_filter_lines.each do |subscription_filter_line| %>
  <%= subscription_filter_line %>
<% end %>
end
EOF
        template
      end
    end
  end
end
