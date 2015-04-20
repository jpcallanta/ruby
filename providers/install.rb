use_inline_resources

action :install do
  # Install ruby dependecy packages needed to build ruby source.
  dep_packages = [
    'build-essential',
    'libreadline-dev',
    'curl',
    'zlib1g',
    'zlib1g-dev',
    'libssl-dev',
    'libyaml-dev',
    'libxml2-dev',
    'libxslt-dev',
    'autoconf',
    'libc6-dev',
    'ncurses-dev',
    'automake',
    'libtool',
    'bison',
    'libcurl4-openssl-dev',
    'ssl-cert',
    'libsqlite3-dev',
    'libffi-dev',
    'libgdbm-dev',
    'gawk'
  ]

  dep_packages.each do |pkg|
    package pkg do
      action :install
    end
  end

  # Build the install script
  template '/usr/local/bin/ruby_install.sh' do
    source 'ruby_install.sh.erb'
    mode '0700'
    owner 'root'
    group 'root'
    variables(
      :version => new_resource.version,
      :source_url => new_resource.source_url,
      :install_prefix => new_resource.install_prefix,
      :build_dir => new_resource.build_dir

    )
    only_if { !::File.exist? '/usr/local/bin/ruby_install.sh' }
    notifies :run, 'execute[ruby_install]', :immediately
  end

  # Execute install script
  execute 'ruby_install' do
    command '/usr/local/bin/ruby_install.sh'
    action :nothing
  end
end

action :remove do
end
