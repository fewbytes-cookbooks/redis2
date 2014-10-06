# Description
This cookbooks installs Redis 2 key-value datastore server. Redis can be installed from packages (where available) or source.

# Requirements
For compiling from source: build-essential, ark

# Attributes
- Set `node.default["redis2"]["install_from"] =  "package"` to install from distro packages, any other value to install from source.
- `node["redis2"]["instances"]["default"]` - default attributes for all redis instances, will be merged with per instance attributes
- `node["redis2"]["instances"][_instance_name_]`  per instance configuration attributes tree

If compiling from source using the `redis2::source` recipe, note the following attributes:

- `node["redis2"]["source"]["url"]` = Source tarball URL
- `node["redis2"]["source"]["checksum"]` = sha256 checksum of the source tarball
- `node["redis2"]["source"]["version"]` = Redis version

# Usage
This cookbook implements redis instances as a definition. If you plan to run only one instance, use the <tt>redis::default_instance</tt> recipe which call a "redis_default" <tt>redis_instance</tt>.
To spawn instances of redis, use the +redis_instance+ definition, usage is pretty straight forward:

    redis_instance "datastore" do
      port 8866
      data_dir "/mnt/redis/datastore"
      master master_node
      nofile 16384
    end

_nofile_, _port_, <em>data_dir</em> and _master_ are the only attributes directly configurable using the definition syntax. Other attributes can be configured using the normal attribute interface under the `node["redis2"]["instances"][instance_name]` scope. Missing attributes will be merged from `node["redis2"]["instances"]["default"]`

The _master_ attribute will set up redis as a slave of a the same redis instance on another server. It will not set `node["redis2"]["instances"][instance_name]["replication"]["role"]` (which can be _slave_ or _master_), because redis can be both at the same time (e.g. chained masters).

# Recipes
* `redis2::auto` - automagically call redis_instance for every instance defined in the `node["redis2"]["instances"]` tree.
* `redis2::default_instance` - use this if you want a simple recipe with a single redis instance called "redis_prime"
It's generally not a good idea to use the redis2::default_instance recipe. If you want a single redis instance, either use redis_instance definition or redis2::auto and define your instance in the attributes tree.
