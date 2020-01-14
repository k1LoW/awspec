module Awspec::Helper
  module Finder
    module Elastictranscoder
      def find_pipeline(id)
        selected = []
        res = elastictranscoder_client.list_pipelines
        loop do
          selected += res.pipelines.select do |pipeline|
            pipeline.id == id || pipeline.name == id
          end
          break if res.next_page_token.nil?
          res = elastictranscoder_client.list_pipelines({
                                                          page_token: res.next_page_token
                                                        })
        end

        selected.single_resource(id)
      end
    end
  end
end
