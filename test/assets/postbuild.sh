tmsh modify  sys db iprep.autoupdate value disable
tmsh modify  sys httpd max-clients ${maxclients}
tmsh modify  sys db merged.merge.interval {value "${mergeinterval}"}
tmsh save /sys config
