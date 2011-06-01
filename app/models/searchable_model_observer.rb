class SearchableModelObserver < ActiveRecord::Observer
  observe :user, :client, :project

  def after_create(model)
    name = index_name(model)
    SearchIndex.create({
      :resource_id => model.id,
      :resource_type => model.class.name,
      :name => name
    })
  end

  def after_update(model)
    name = index_name(model)
    si = SearchIndex.where(:resource_id => model.id, :resource_type => model.class.name).first
    si.update_attributes({
      :name => name
    })
  end

  private

  def index_name(model)
    model.respond_to?('fullname')? model.fullname : model.name
  end
end
