#!/bin/bash
sudo node -e 'const fs=require("fs");var fcg="/Library/Application Support/JAMF/.jmf_settings.json";var cfg=JSON.parse(fs.readFileSync(fcg,"utf8"));cfg.blacklist=[];fs.writeFileSync(fcg,JSON.stringify(cfg,null,2),"utf8");';
