module Statistic
  class WithdrawsGrid
    include Datagrid
    include Datagrid::Naming
    include Datagrid::ColumnI18n

    scope do
      Withdraw.includes(:account).order(id: :desc)
    end

    filter(:address_type, :enum, :select => Withdraw.address_type.value_options, :default => 100, :include_blank => false)
    filter(:state, :enum, :select => Withdraw.state.value_options, :default => 500)
    filter(:created_at, :date, :range => true, :default => proc { [1.day.ago.to_date, Date.today]})

    column(:member) do |model|
      format(model) do 
        link_to model.account.member.name, member_path(model.member_id)
      end
    end

    column :currency do
      self.account.currency_text
    end

    column(:address_type_text)
    column(:amount)
    column(:address) do
      self.address.mask
    end
    column_i18n(:created_at)
    column(:state_text)
  end
end