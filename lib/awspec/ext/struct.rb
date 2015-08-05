class Struct
  def tag_name
    tag = self[:tags].find do |t|
      t[:key] == 'Name'
    end
    tag[:value] if tag
  end
end
