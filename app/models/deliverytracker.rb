# == Schema Information
#
# Table name: deliverytrackers
#
#  id         :integer          not null, primary key
#  arrivedate :date
#  content    :string
#  details    :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Deliverytracker < ApplicationRecord
end
