module Awspec::Generator
  module Doc
    module Type
      class ElastictranscoderPipeline < Base
        def initialize
          super
          @type_name = 'ElastictranscoderPipeline'
          @type = Awspec::Type::ElastictranscoderPipeline.new('my-elastic-transcoder-pipeline')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::ElastictranscoderPipeline::STATUSES.map { |status| 'be_' + status.underscore }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::ElastictranscoderPipeline::STATUSES.map do |status|
            'be_' + status.underscore
          end
          @describes = []
        end
      end
    end
  end
end
