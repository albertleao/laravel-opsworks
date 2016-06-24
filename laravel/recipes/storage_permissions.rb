node[:deploy].each do |application, deploy|
  script "storage_permissions" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    chmod -R 777 storage
    EOH
  end
end
