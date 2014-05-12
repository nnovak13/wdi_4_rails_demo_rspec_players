require 'spec_helper'

describe Player do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:job) }
  it { should validate_presence_of(:health) }
  it { should validate_presence_of(:magic) }
  it { should validate_uniqueness_of(:name) }
  it { should ensure_inclusion_of(:job).in_array(Player::JOBS) }
end
