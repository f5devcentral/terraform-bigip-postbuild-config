# encoding: utf-8
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# InSpec custom resource for GRE Tunnel testing on BIG-IPs
# Author: Mark J Menger
# Source from 

# Custom resource based on the InSpec resource DSL
class GreTunnel < Inspec.resource(1)
    name 'bigip_gre_tunnel'

    desc " some description to be provided later "

    example "
      some example code to be provided later
    
    "

    def initialize(tunnelname)
      @tunnelname = tunnelname
    end

    def type
      @command = inspec.command("tmsh list net tunnels tunnel #{@tunnelname} profile")
      @command.stdout.scan(/profile ([a-z]+)/).first[0]
    end

    def tunneltraffic
      t1 = Thread.new{tcpdump()}
      t2 = Thread.new{pingpartner()}
      t2.join
      t1.join
      #t1["stdout"].match('IP (\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}) > (\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}): ([a-zA-Z0-9]+), length \d{1,4}: IP (\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}) > (\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}): ([A-Z]+).{1,4}\d{1,4}: ([A-Z]+) ([A-Za-z 0-9]+), (.+$)')
      @dumpresults = t1["stdout"].match('IP (\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}) > (\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}): ([a-zA-Z0-9]+), length \d{1,4}: IP (\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}) > (\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})')
      @anotherdump = t1["stdout"].match(' lis=([a-zA-Z_\/]+)')
      @simplehash = {
        "source_interface_address" => @dumpresults[1],
        "destination_interface_address" => @dumpresults[2],
        "source_tunnel_address" => @dumpresults[4],
        "destination_tunnel_address" => @dumpresults[5],
        "tunnel_protocol" => @dumpresults[3],
        "tunnel_listener" => @anotherdump[1]
      }
    end

    def tcpdump
      @command = inspec.command("timeout 5 tcpdump -i 0.0 -nnn proto GRE")
      Thread.current["stdout"] = @command.stdout
    end

    def pingpartner
      @command = inspec.command("ping 192.168.0.11 -c 2")
      Thread.current["stdout"] = @command.stdout
    end


end