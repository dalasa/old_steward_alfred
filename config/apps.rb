# frozen_string_literal: true

##
# This file mounts each app in the Padrino project to a specified sub-uri.
# You can mount additional applications using any of these commands below:
#
#   Padrino.mount('blog').to('/blog')
#   Padrino.mount('blog', :app_class => 'BlogApp').to('/blog')
#   Padrino.mount('blog', :app_file =>  'path/to/blog/app.rb').to('/blog')
#
# You can also map apps to a specified host:
#
#   Padrino.mount('Admin').host('admin.example.org')
#   Padrino.mount('WebSite').host(/.*\.?example.org/)
#   Padrino.mount('Foo').to('/foo').host('bar.example.org')
#
# Note 1: Mounted apps (by default) should be placed into the project root at '/app_name'.
# Note 2: If you use the host matching remember to respect the order of the rules.
#
# By default, this file mounts the primary app which was generated with this project.
# However, the mounted app can be modified as needed:
#
#   Padrino.mount('AppName', :app_file => 'path/to/file', :app_class => 'BlogApp').to('/')
#

##
# Setup global project settings for your apps. These settings are inherited by every subapp. You can
# override these settings in the subapps as needed.
#
Padrino.configure_apps do
  # enable :sessions
  set :session_secret, '275c761d476f71ddf037f2cbbee4b4ff8c8c3235fcdff6de942438569c11e817'
  set :protection, except: :path_traversal
  set :protect_from_csrf, true
end

# Mounts the core application for this project
Padrino.mount('StewardAlfred::App', app_file: Padrino.root('app/app.rb')).to('/')
