module Awspec
  class DuplicatedResourceTypeError < StandardError
  end
  class InvalidAccountError < StandardError
  end
  ##
  # The exception when sending message to a unavailable AWS resource.
  #
  # It should be raised everytime a resource is not available (or doesn't
  # exist) before trying to invoke a method from it and raising instead
  # NoMethodError exception.
  class NoExistingResource < StandardError
    ##
    # Overrides the superclass initialize method to include more information
    # and default error message.
    # Expected parameters:
    # - resource_type: the name of the resource type. Probably the class method return is the best option to be used.
    # - id: the string used to search for the AWS resource. It will vary depending on the resource type, but probably
    # will be an string.

    def initialize(resource_type, id)
      @resource_type = resource_type
      @id = id
      message = "The resource type #{resource_type} with id #{id} does not exist"
      super message
    end
  end

  # Let the user know the configuration they provided is not known.
  class UnknownConfiguration < StandardError
  end
end
