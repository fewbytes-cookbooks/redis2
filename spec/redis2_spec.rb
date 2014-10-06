require_relative 'spec_helper'

describe "redis2::default" do
  let(:chef_run) { ChefSpec::Runner.new }

  it "Runs redis2::source and correctly sets node['redis2']['daemon']" do
    chef_run.node.set['redis2']['install_from'] = "source"
    chef_run.converge(described_recipe)
    expect(chef_run).to include_recipe("redis2::source")
    expect(chef_run.node["redis2"]["daemon"]).to eq("/usr/local/bin/redis-server") 
  end

  it "Runs redis2::package if install_from is set to package" do
    chef_run.node.set['redis2']['install_from'] = "package"
    chef_run.converge(described_recipe)
    expect(chef_run).to include_recipe("redis2::package")
  end
end

describe "redis2::package" do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
  it "Install redis package" do
    expect(chef_run).to install_package("redis-server")
  end
end  

describe "redis2::default_instance" do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
  it "Install redis-prime instance" do
    #expect(chef_run).to enable_runit_service("redis_prime")
    #expect(chef_run).to start_runit_service("redis_prime")
    expect(chef_run).to create_directory("/var/lib/redis/prime")
  end
end  
