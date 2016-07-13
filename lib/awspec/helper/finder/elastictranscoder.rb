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
          (res.next_page? && res = res.next_page) || break
        end

        selected.single_resource(id)
      end
    end
  end
end
