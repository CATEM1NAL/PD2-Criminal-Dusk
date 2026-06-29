if NetworkHelper:IsClient() then return end
Hooks:PostHook(BaseNetworkSession, "on_peer_sync_complete", "CrimDusk_PeerSync", function(self, _, peer_id)
  NetworkHelper:SendToPeer(peer_id, "CrimDusk_HeistCount", Global.CrimDusk.data.heists_won)
end)