class Debt < ActiveRecord::Base
  belongs_to :bill
  belongs_to :person_to, :class_name => 'Person', :validate => true, :autosave => true
  belongs_to :person_from, :class_name => 'Person', :validate => true, :autosave => true

  validates :amount, :presence => true, :numericality => { :greater_than => 0 }
  validates :bill, :presence => true
  validates :person_from, :presence => true
  validates :person_to, :presence => true
  validate :people_to_and_from_cannot_be_the_same

  private

  def people_to_and_from_cannot_be_the_same
    if person_to and person_to == person_from
      errors[:person_to] << 'must be different from the person from'
    end
  end

end
