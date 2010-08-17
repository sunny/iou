
Factory.define :user do |u|
  u.name 'John'
  u.sequence(:email) {|n| "user#{n}@example.com" }

  u.password "fake password"
  u.password_salt "fake salt"
  u.encrypted_password "fake password hash"
end

Factory.define :friend do |f|
  f.name 'Ianto'
  f.association :creator, :factory => :user
end

Factory.define :debt do |d|
  d.amount 42
  d.association :person_from, :factory => :user
  d.association :person_to, :factory => :friend
end

Factory.define :bill do |b|
  b.amount 42
  b.description 'Restaurant'
  b.date Date.today
  b.bill_type 'Bill'
  b.association :creator, :factory => :user
  b.debts do |bill|
    [bill.association(:debt,
      :amount => bill.amount,
      :bill => bill.id,
      :person_from => bill.creator
    )]
  end
end

