class WorkTypes
  def self.all
    {:feature => 'Feature', :task => 'Task', :incident => 'Incident'}
  end

  def self.for_select
    self.all.map { |k,v| [ v, k ] }
  end
end

