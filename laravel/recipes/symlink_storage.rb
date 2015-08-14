node[:deploy].each do |application, deploy|
  script "symlink_storage" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}"
    code <<-EOH
    mv current/storage/* shared
    rm -rf current/storage
    ln -s #{deploy[:deploy_to]}/shared #{deploy[:deploy_to]}/current/storage
    EOH
  end
end