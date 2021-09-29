# copyright: 2018, The Authors

title "GRE Tunnel validation"

TUNNEL_NAME  = input('gre_tunnel_name')
LOCAL_HOST   = sys_info.ip_address
REMOTE_HOST  = file(input('remote_gre_address')).content

# you add controls here
control "bigip-gre-tunnel" do                        
  impact 0.7                                
  title "ping remote host on GRE tunnel"            
  desc "check for basic configuration and tcp traffic indicators that a GRE tunnel is functioning on a BIG-IP" 


  describe host(REMOTE_HOST, protocol: 'icmp') do
    it { should be_reachable }
  end
  describe interface(TUNNEL_NAME) do
    it {should be_up}
    its ('name') { should eq TUNNEL_NAME }
  end
  describe bigip_gre_tunnel(TUNNEL_NAME,REMOTE_HOST) do
    its('type') { should eq 'gre'}
    its('tunneltraffic.tunnel_protocol') { should eq 'GREv0'}
    its('tunneltraffic.tunnel_listener') { should eq "_ucast_tunnel_/Common/#{TUNNEL_NAME}"}
  end
end


