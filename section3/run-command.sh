#!/bin/bash
docker run --rm -d --name midterm -p 5000:5000 --read-only --cap-drop ALL --security-opt no-new-privileges:true --security-opt seccomp=seccomp-profile.json ia462-midterm
