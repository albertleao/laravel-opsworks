case node[:platform]
when "debian", "ubuntu"
  execute "add_repo" do
    user "root"
    command "add-apt-repository ppa:ondrej/php"
    notifies :run, 'execute[apt_update]', :immediately
  end

  execute "apt_update" do
    user "root"
    command "apt-get update"
    notifies :run, 'execute[apt_install]', :immediately
  end

  execute "apt_install" do
    user "root"
    command "apt-get -y --force-yes install php5.6 php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-xml"
    notifies :run, 'execute[disable_php5_apache]', :delayed
  end

  execute "disable_php5_apache" do
    user "root"
    command "a2dismod php5"
    notifies :run, 'execute[enable_php5_apache]', :immediately
  end

  execute "enable_php5_apache" do
    user "root"
    command "a2enmod php5.6"
    notifies :run, 'execute[restart_apache]', :immediately
  end

  execute "restart_apache" do
    user "root"
    command "service apache2 restart"
  end
end
