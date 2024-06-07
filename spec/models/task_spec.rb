require 'rails_helper'

RSpec.describe Task, type: :model do
  it { is_expected.to validate_length_of(:name).is_at_least(5) }
  it { is_expected.to validate_presence_of(:priority) }
  it { is_expected.to validate_presence_of(:name) }
  it {should validate_inclusion_of(:completed).in_array([true, false])}
  it { is_expected.to belong_to :member }
end