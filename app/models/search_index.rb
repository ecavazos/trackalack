class SearchIndex < ActiveRecord::Base
  def to_path_method
    "#{self.resource_type.downcase}_path"
  end
end
