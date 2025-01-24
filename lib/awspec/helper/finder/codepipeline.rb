# frozen_string_literal: true

module Awspec::Helper
  module Finder
    module Codepipeline
      def find_codepipeline(id)
        res = codepipeline_client.get_pipeline({ name: id })
        res.pipeline
      end

      def select_all_codepipelines
        req = {}
        pipelines = []
        loop do
          res = codepipeline_client.list_pipelines(req)
          pipelines.push(*res.pipelines)
          break if res.next_token.nil?

          req[:next_token] = res.next_token
        end
        pipelines
      end
    end
  end
end
