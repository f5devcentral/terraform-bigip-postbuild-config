# copyright: 2018, The Authors

title "sample section"

REMOTE_HOST  = input('remote_gre_address')
TUNNEL_NAME  = input('gre_tunnel_name')
#REMOTE_HOST = "192.168.0.11"

# you add controls here
control "bigip-gre-ping" do                        
  impact 0.7                                
  title "ping remote host on GRE tunnel"            
  desc "An optional description..."
  describe host(REMOTE_HOST, protocol: 'icmp') do
    it { should be_reachable }
  end
  describe bigip_gre_tunnel(TUNNEL_NAME) do
    its('type') { should eq 'gre'}
    its('tunneltraffic') { should eq 'stuff'}
  end
end


