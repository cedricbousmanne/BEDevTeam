set :stage, :production

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
role :app, %w{deploy@188.166.55.156}
role :web, %w{deploy@188.166.55.156}
role :db,  %w{deploy@188.166.55.156}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server '188.166.55.156', user: 'deploy', roles: %w{web app}

set :branch, 'master'
set :deploy_to, '/home/deploy/bedevteam/production'
