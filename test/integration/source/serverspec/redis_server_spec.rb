require_relative 'spec_helper'

describe "Redis prime instance" do
  include_examples "redis::default"

  it "should install redis binary from source" do
    expect(file("/usr/local/bin/redis-server")).to be_file
    expect(file("/usr/local/bin/redis-server")).to be_mode "755"
  end
    
  describe process("redis-server") do
    its(:args) { should match /0.0.0.0:6379/ }
  end
end
