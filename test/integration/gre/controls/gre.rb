# copyright: 2018, The Authors

title "sample section"

REMOTE_HOST     = input('remote_gre_address')
#REMOTE_HOST = "192.168.0.11"

# you add controls here
control "bigip-gre-ping" do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title "ping remote host on GRE tunnel"             # A human-readable title
  desc "An optional description..."
  describe host(REMOTE_HOST, protocol: 'icmp') do
    it { should be_reachable }
  end
  describe bigip_gre_tunnel('newGRE') do
    its('type') { should eq 'gre'}
    its('tunneltraffic') { should eq 'stuff'}
  end
end


