# Start/stop periodicly fetching events
startFeedDaemon = ->
  feedDaemon = setInterval fetchEvents, 60*60*1000 # 1 hour

stopFeedDaemon = ->
  clearInterval feedDaemon
