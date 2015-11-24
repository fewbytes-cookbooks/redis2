require 'serverspec'

set :backend, :exec

shared_examples 'redis::default' do
  describe "Redis instances pre-requisites" do
    describe file("/etc/redis") do
      it { should be_directory }
      it { should be_owned_by "root" }
      it { should be_mode "755" }
    end

    describe file("/var/lib/redis") do
      it { should be_directory }
      it { should be_owned_by "redis" }
      it { should be_mode "750" }
    end

    describe file("/var/log/redis") do
      it { should be_directory }
      it { should be_owned_by "redis" }
      it { should be_mode "750" }
    end
  end

  describe "Redis prime instance" do
    
    it "should have a data directory" do
      expect(file("/var/lib/redis/prime")).to be_directory
      expect(file("/var/lib/redis/prime")).to be_owned_by("redis")
      expect(file("/var/lib/redis/prime")).to be_grouped_into("redis")
      expect(file("/var/lib/redis/prime")).to be_mode("750")
    end

    it "should have a log file" do
      expect(file("/var/log/redis/redis_prime.log")).to be_file
      expect(file("/var/log/redis/redis_prime.log")).to be_owned_by("redis")
      expect(file("/var/log/redis/redis_prime.log")).to be_mode("644")
    end

    it "is listening on port 6379" do
      expect(port(6379)).to be_listening
    end

    it "has a running service of redis-prime" do
      expect(service("redis-server")).to be_running
    end

  end
end
