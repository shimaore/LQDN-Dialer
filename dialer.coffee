client =  require('esl').createClient()
client.on 'esl_auth_request', (req,res) ->
   res.auth "ClueCon", () ->
   res.send 'event json HEARTBEAT'
client.connect(8021, '127.0.0.1')
target_list = JSON.parse fs.readFileSync '/etc/
require('zappa') ->
  @use 'bodyParser', 'methodOverride'
  @get '/:target/:caller': ->
      
