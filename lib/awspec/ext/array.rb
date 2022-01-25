# frozen_string_literal: true

class Array
  def single_resource(id = nil)
    if count > 1
      raise Awspec::DuplicatedResourceTypeError, "Duplicated resource type #{id}"
    end

    first if count == 1
  end
end
