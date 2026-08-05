--[[ this is no longer needed, but being kept around in case it is needed again.
if NetworkHelper:IsClient() then return end
Hooks:PostHook(BaseNetworkSession, "on_peer_sync_complete", "CrimDusk_PeerSync", function(self, _, peer_id)
  -- SYNC SHIT HERE
end)
]]