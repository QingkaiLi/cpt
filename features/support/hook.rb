Before do
  body = '{"role":"DISTRICT_MANAGER","district":{"id":55,"active":true,"created":1358131690000,"modified":1358131690000,"tenantId":"201314","organizationId":"201314","name":"School2013","parent":null,"loginSecuritySetting":"SECURE","rpiEnabled":null,"autoPlacementEnabled":true,"orgSchedule":null},"success":true}'
  json_object = JSON.parse(body);
  SessionsController.any_instance.stubs(:get_user_principal).returns(json_object)
end


module Capybara
  module Node
    class Element
      def hover
        @session.driver.browser.action.move_to(self.native).perform
      end
    end
  end
end

module Capybara
  class Session
    def has_link_or_button?(locator)
      has_link?(locator) or has_button?(locator)
    end
  end
end
