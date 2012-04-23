module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name, record_id=nil)
    case page_name

    when /home page/
      '/'
    when /new user registrations page/
      new_user_registration_path
    when /manage domains page/
      manage_domains_path
    when /manage domain page/
      #domain = Domain.where(:name => record_id).first
      manage_domain_path(record_id)
    when /new domain page/
      new_manage_domain_path

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
