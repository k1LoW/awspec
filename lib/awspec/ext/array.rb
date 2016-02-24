class Array
  def single_resource(id = nil)
    if self.count > 1
      raise Awspec::DuplicatedResourceTypeError, "Duplicated resource type #{id}"
    end
    self.first if self.count == 1
  end
end
