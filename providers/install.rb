use_inline_resources

action :install do
  build_path = "#{new_resource.build_dir}/ruby-#{new_resource.version}"

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
    only_if { !::File.exist? "#{new_resource.install_prefix}/bin/ruby" }
    notifies :run, 'execute[ruby_install]', :immediately
  end

  # Execute install script
  execute 'ruby_install' do
    command '/usr/local/bin/ruby_install.sh'
    action :nothing
    notifies :delete, 'file[remove_buildscript]', :immediately
  end

  # Cleanup
  file 'remove_buildscript' do
    path '/usr/local/bin/ruby_install.sh'
    action :nothing
    notifies :delete, 'directory[source_dir]', :immediately
  end

  directory 'source_dir' do
    path build_path
    recursive true
    action :nothing
    notifies :delete, 'file[ruby_tarball]', :immediately
  end

  file 'ruby_tarball' do
    path "/tmp/ruby-#{new_resource.version}.tar.gz"
    action :nothing
  end
end
