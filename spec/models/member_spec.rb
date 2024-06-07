require 'rails_helper'

RSpec.describe Member, type: :model do
  it { is_expected.to validate_length_of(:name).is_at_least(5) }
  it { is_expected.to validate_length_of(:password).is_at_least(3) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:name) }
end