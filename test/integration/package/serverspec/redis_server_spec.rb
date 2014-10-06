require_relative 'spec_helper'

describe "Redis prime instance" do
  include_examples "redis::default"

  it "should install package" do
    expect(package("redis-server")).to be_installed
  end

  describe process("redis-server") do
    its(:args) { should match /\/etc\/redis\/redis_prime.conf/ }
  end
end
