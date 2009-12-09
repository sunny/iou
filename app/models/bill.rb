class Bill < ActiveRecord::Base
  has_many :participations, :include => :user, :dependent => :destroy
  has_many :users, :through => :participations, :uniq => true

  validates_presence_of :made_on
  validates_presence_of :amount
  validates_numericality_of :amount, :greater_than => 0, :allow_nil => true
  # validates_size_of :users, :minimum => 1, :message => "must be at least two"
  validate :participations_must_be_equal_to_amount

  before_validation :default_values

  def default_values
    self.loan ||= true
  end

  # Is this a shared bill? (Not just two participants)
  def shared?
    self.participations.paying.size > 1 or self.participations.participating.size > 1
  end

  # Returns the positive or negative total that everybody owes to the given user
  def balance_for_user(user)
    user_participations = Participation.find_all_by_bill_id_and_user_id(id, user.id, :order => 'payer')
    owes, paid = user_participations
    (paid ? paid.amount : 0) - (owes ? owes.amount : 0)
  end


  def title
    return description unless description.blank?
    return "Bill ##{id}" if self.users.empty?
    "Bill between #{self.users.sort_by{|u| u.you? ? 0:1 }.map(&:name).to_sentence}"
  end

  def comma_seperated_friends_names
    users.friends.map(&:name).join(', ')
  end

  def comma_seperated_friends_names=(names)
    new_names = ['You'] + names.split(/,/).map(&:strip).uniq.compact
    old_names = users.map(&:name).uniq.compact

    users_to_create = new_names - old_names
    users_to_delete = old_names - new_names

    users_to_create.each { |name|
      user = User.find_or_create_by_name(:name => name)
      user.save!
      self.participations.push Participation.new(:user => user, :payer => 1, :bill => self)
      self.participations.push Participation.new(:user => user, :payer => 0, :bill => self)
    }

    users_to_delete.each { |name|
      self.participations.by_user_name(name).map(&:destroy)
    }
    names
  end

  def new_participations=(participations)
    participations.each do |id, attributes|
      Participation.find_or_create_by_id(id).update_attributes(attributes)
    end
  end

  def new_participations
    participations
  end

  private

    def participations_must_be_equal_to_amount
      total_payments = self.participations.paying.with_amount.map(&:amount).sum
      total_participations = self.participations.participating.with_amount.map(&:amount).sum
      return if total_payments == 0 and total_participations == 0
      errors.add_to_base("Total payments must be equal to the amount (got #{total_payments} € instead of #{amount} €)") \
        unless amount == total_payments
      errors.add_to_base("Total participations must be equal to the amount (got #{total_participations} € instead of #{amount} €)") \
        unless amount == total_participations
    end
end
