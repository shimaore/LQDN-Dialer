esl = require 'esl'

json_file = (f) -> JSON.parse fs.readFileSync f

config = json_file '/etc/lqdn/config.json'
target_list = json_file '/etc/lqdn/targets.json'
authorized_destinations = json_file '/etc/lqdn/destinations.json'

make_call = (from,to) ->
  client =  esl.createClient()
  client.on 'esl_auth_request', (req,res) ->
     res.auth "ClueCon", () ->
     res.send 'event json HEARTBEAT'
  client.connect(8021, '127.0.0.1')

require('zappa') ->
  @use 'bodyParser', 'methodOverride'

  @get '/:target/:caller': ->
    if not target_list[@params.target]?
      return @send error:'No such target'
    exten_from = config.exten_from
    context = config.context
    for p in authorized_destinations
      if caller.match p
        client =  esl.createClient()
        client.on 'esl_auth_request', (req,res) =>
          res.auth "ClueCon", (req,res) =>
            res.api "originate #{call_url} #{exten_from} xml #{context}", (req,res) =>
              @send ok:true
