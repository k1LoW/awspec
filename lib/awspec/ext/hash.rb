# frozen_string_literal: true

class Hash
  def to_struct
    st = Struct.new(*keys)
    maps = values.map do |s|
      next s.to_struct if s.is_a?(Hash)

      s
    end
    st.new(*maps)
  end
end
