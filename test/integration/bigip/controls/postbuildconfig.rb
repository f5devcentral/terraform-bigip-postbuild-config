title "Verify Post Build Config"

BIGIP_HOST     = input('bigip_address')
BIGIP_PORT     = input('bigip_port')
BIGIP_USER     = input('user')
BIGIP_PASSWORD = input('password')
NAMESERVER     = input('nameserver')

# compare the following tests to the 
# declaration in assets/do.json

control "bigip-postbuildconfig-do-self" do
    impact 1.0
    title "expected selfIps"
    describe json(content: http("https://#{BIGIP_HOST}:#{BIGIP_PORT}/mgmt/tm/net/self/external-self",
              auth: {user: BIGIP_USER, pass: BIGIP_PASSWORD},
              method: 'GET',
              ssl_verify: false).body) do
        its('address') { should cmp "10.20.0.9/24" }
        its('vlan') { should cmp "/Common/external" }
        its('allowService') { should cmp "tcp:443"}   
    end
    describe json(content: http("https://#{BIGIP_HOST}:#{BIGIP_PORT}/mgmt/tm/net/self/internal-self",
        auth: {user: BIGIP_USER, pass: BIGIP_PASSWORD},
        method: 'GET',
        ssl_verify: false).body) do
        its('address') { should cmp "10.30.0.10/24" }
        its('vlan') { should cmp "/Common/internal" }
        its('allowService') { should cmp "default"}
    end
end

control "bigip-postbuildconfig-do-dns" do
    impact 1.0
    title "expected dns"
    describe json(content: http("https://#{BIGIP_HOST}:#{BIGIP_PORT}/mgmt/tm/sys/dns",
              auth: {user: BIGIP_USER, pass: BIGIP_PASSWORD},
              method: 'GET',
              ssl_verify: false).body) do
          its('nameServers') { should cmp NAMESERVER }
    end
end

control "bigip-postbuildconfig-do-vlan" do
    impact 1.0
    title "expected vlans"
    describe json(content: http("https://#{BIGIP_HOST}:#{BIGIP_PORT}/mgmt/tm/net/vlan/external",
              auth: {user: BIGIP_USER, pass: BIGIP_PASSWORD},
              method: 'GET',
              ssl_verify: false).body) do
          its('tag') { should cmp "10" }
          its('mtu') { should cmp "1500" }
    end
    describe json(content: http("https://#{BIGIP_HOST}:#{BIGIP_PORT}/mgmt/tm/net/vlan/internal",
              auth: {user: BIGIP_USER, pass: BIGIP_PASSWORD},
              method: 'GET',
              ssl_verify: false).body) do
          its('tag') { should cmp "20" }
          its('mtu') { should cmp "1500" }
    end
end

control "bigip-postbuildconfig-do-provision" do
    impact 1.0
    title "expected provisioning"
    describe json(content: http("https://#{BIGIP_HOST}:#{BIGIP_PORT}/mgmt/tm/sys/provision/ltm",
              auth: {user: BIGIP_USER, pass: BIGIP_PASSWORD},
              method: 'GET',
              ssl_verify: false).body) do
          its('level') { should cmp "nominal" }
    end
    describe json(content: http("https://#{BIGIP_HOST}:#{BIGIP_PORT}/mgmt/tm/sys/provision/asm",
              auth: {user: BIGIP_USER, pass: BIGIP_PASSWORD},
              method: 'GET',
              ssl_verify: false).body) do
          its('level') { should cmp "nominal" }
    end
end