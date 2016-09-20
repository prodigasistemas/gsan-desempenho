module LinksHelper
  def root_application_path
    ENV['GSAN_ROOT_PATH'] || "http://localhost:3000"
  end

  def logout_url
    root_application_path + "/session"
  end

  def login_url
    root_application_path + "/session/new"
  end

end