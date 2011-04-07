class SearchIndicesController < ApplicationController
  def index
    render :json => SearchIndex.where('name LIKE ?', "%#{params[:term]}%")
  end
end
