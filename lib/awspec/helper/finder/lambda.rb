module Awspec::Helper
  module Finder
    module Lambda
      def find_lambda(id)
        functions = []
        marker = nil
        loop do
          res = @lambda_client.list_functions(
            marker: marker
          )
          marker = res.next_marker
          break if res.functions.empty?
          res.functions.each do |function|
            if function.function_name == id || function.function_arn == id
              functions.push(function)
            end
          end
          break unless marker
        end
        return functions[0] if functions.count == 1
      end

      def select_event_source_by_function_arn(function_arn)
        res = @lambda_client.list_event_source_mappings({
                                                          function_name: function_arn
                                                        })
        res[:event_source_mappings]
      end
    end
  end
end
