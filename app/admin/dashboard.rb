# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "dashboard-container" do
      div class: "dashboard-column" do
        panel "Recent Admin Users" do
          table_for AdminUser.order(created_at: :desc).limit(5) do
            column :email
            column :current_sign_in_at
            column :sign_in_count
            column :created_at
            column { |user| link_to "View", admin_admin_user_path(user) }
          end
          div class: "my-4" do
            link_to "View All Admin Users",
                    admin_admin_users_path,
                    class: "button"
          end
        end
      end

      div class: "dashboard-column" do
        panel "System Information" do
          para "Environment: #{Rails.env}"
          para "Database: #{ActiveRecord::Base.connection.adapter_name}"
          para "Ruby version: #{RUBY_VERSION}"
          para "Rails version: #{Rails.version}"
        end

        panel "Recent Activity" do
          para "Last deployment: #{Time.now.strftime("%B %d, %Y at %I:%M %p")}"
          para "Total admin users: #{AdminUser.count}"
        end
      end
    end
  end
end
