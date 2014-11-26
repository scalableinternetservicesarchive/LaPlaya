require 'ostruct'

$:.unshift File.expand_path('../lib', __FILE__)
require 'csv'
require 'yaml'

def load_yaml_file(path)
  return nil unless File.file?(path)
  YAML.load(IO.read(path))
end


def load_configuration()
  root_dir = File.expand_path('..', __FILE__)

  hostname = `hostname`.strip
  username = `whoami`.strip

  global_config = load_yaml_file File.join(root_dir, 'secrets', 'config.yml')
  global_config = {'environments'=>{}, 'hosts'=>{}} unless global_config

  default_config = global_config['environments']['all'] || {}

  host_config = global_config['hosts'][hostname] || {}

  local_config = load_yaml_file(File.join(root_dir, 'locals.yml')) || {}

  env = local_config['env'] || host_config['env'] || ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'development'
  env_config = global_config['environments'][env] || {}

  secret_key_base = local_config['secret_key_base'] || host_config['secret_key_base'] || ENV['SECRET_KEY_BASE'] || nil

  rack_env = env.to_sym

  {
      'home_dir'                    => File.expand_path('~'),
      'hostname'                    => hostname,
      'appname'                     => 'LaPlaya',
      'rack_env'                    => rack_env,
      'rack_envs'                   => [:development, :production, :staging, :test],
      'root_dir'                    => root_dir,
      'username'                    => username,
      'newrelic_license_key'        => '237a983637ad3084d53c889ed49f51c5a4e281ae',
      'facebook_key'                => '1484943711771376',
      'facebook_secret'             => '449396682aca4316b39009e017fdddc2',
      'google_key'                  => '',
      'google_secret'               => '',
      'secret_key_base'             => secret_key_base

  }.tap do |config|
    raise "'#{rack_env}' is not known environment." unless config['rack_envs'].include?(rack_env)
    ENV['RACK_ENV'] = rack_env.to_s unless ENV['RACK_ENV']
    raise "RACK_ENV ('#{ENV['RACK_ENV']}') does not match configuration ('#{rack_env}')" unless ENV['RACK_ENV'] == rack_env.to_s

    config.merge! default_config
    config.merge! env_config
    config.merge! host_config
    config.merge! local_config
  end
end


####################################################################################################
##
## LaPlayaConfig - A singleton that contains our settings and integration helpers.
##
##########

class LaPlayaImpl < OpenStruct

  def initialize()
    super load_configuration
  end

  def canonical_hostname(domain)
    return "localhost.#{domain}" if rack_env?(:development)
    return "#{self.name}.#{domain}" if ['console', 'hoc-levels'].include?(self.name)
    return domain if rack_env?(:production)
    "#{rack_env}.#{domain}"
  end

  def dir(*dirs)
    File.join(root_dir, *dirs)
  end

  def hosts_by_env(env)
    hosts = []
    GlobalConfig['hosts'].each_pair do |key, i|
      hosts << i if i['env'] == env.to_s
    end
    hosts
  end

  def hostnames_by_env(env)
    hosts_by_env(env).map{|i| i['name']}
  end

  def rack_env?(env)
    rack_env == env
  end

end

LaPlayaConfig ||= LaPlayaImpl.new

