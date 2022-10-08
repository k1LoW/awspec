# frozen_string_literal: true

RSpec::Matchers.define :have_metric_filter do |filter_name|
  match do |log_group_name|
    log_group_name.has_metric_filter?(filter_name, @pattern)
  end

  chain :filter_pattern do |pattern|
    @pattern = pattern
  end
end
