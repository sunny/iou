Factory.define :user do |u|
  u.name 'Ussain'
  u.sequence(:email) {|n| "user#{n}@example.com" }
  u.password "fake password"
  u.password_salt "fake salt"
  u.encrypted_password "fake password hash"
end

Factory.define :friend do |f|
  f.name 'Friday'
  f.association :creator, :factory => :user
end

Factory.define :debt do |d|
  d.amount { |debt| debt.bill.amount }
  d.association :person_from, :factory => :user
  d.association :person_to, :factory => :friend
end

Factory.define :bill do |b|
  b.bill_type 'Bill'
  b.amount 42
  b.description 'Restaurant'
  b.date Date.today
  b.association :creator, :factory => :user
end

Factory.define :shared_bill, :parent => :bill do |s|
  s.bill_type 'Shared'
end

