# == Schema Information
# Schema version: 20110514142435
#
# Table name: authentications
#
#  id           :integer         not null, primary key
#  user_id      :integer
#  provider     :string(255)
#  uid          :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  token        :string(255)
#  secret_token :string(255)
#

class Authentication < ActiveRecord::Base
  attr_accessible :user_id, :provider, :uid, :token, :secret_token
  belongs_to :user
end
