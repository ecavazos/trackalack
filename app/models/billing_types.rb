class BillingTypes
  def self.all
    {
       :billable     => 'Billable',
       :non_billable => 'Non-Billable',
       :no_charge    => 'No Charge'
    }
  end

  def self.for_select
    self.all.map { |k,v| [ v, k ] }
  end
end

