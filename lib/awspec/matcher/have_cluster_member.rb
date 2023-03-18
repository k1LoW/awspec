# frozen_string_literal: true

RSpec::Matchers.define :have_cluster_member do |name|
  match do |cluster_identifier|
    cluster_identifier.has_cluster_member?(name, @is_writer)
  end

  chain :is_writer do |is_writer|
    @is_writer = is_writer
  end
end
