# == Schema Information
# Schema version: 20110504025624
#
# Table name: books
#
#  id         :integer         not null, primary key
#  language   :string(255)
#  category   :integer
#  volume     :integer
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Book < ActiveRecord::Base
  attr_accessible :language, :category, :title, :volume
end
