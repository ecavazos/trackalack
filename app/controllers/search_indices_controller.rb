class SearchIndicesController < ApplicationController
  def index
    results = SearchIndex.where('name LIKE ?', "%#{params[:term]}%")
      .map do |x|
        {
          :id   => x.resource_id,
          :name => x.name,
          :type => x.resource_type,
          :path => send(x.to_path_method, x.resource_id)
        }
      end
    render :json => results
  end
end
