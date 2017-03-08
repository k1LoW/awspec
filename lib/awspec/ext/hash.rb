class Hash
  def to_struct
    st = Struct.new(*self.keys)
    maps = self.values.map do |s|
      next s.to_struct if Hash == s
      s
    end
    st.new(*maps)
  end
end
