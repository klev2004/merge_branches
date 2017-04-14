#!/bin/sh
#restart-all.sh
# ----------------------------------------------------------------------------
#  Copyright 2017 Ukrposhta. http://www.ukrposhta.ua
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

NAME=restart-all
# Daemon name, where is the actual executable
START_SCRIPT="$CARBON_HOME/bin/stop-all.sh"
STOP_SCRIPT="$CARBON_HOME/bin/start-all.sh"

# If the daemon is not there, then exit.

if [ ! -z "$*" ]; then
    exit;
else
    trap "sh $CARBON_HOME/bin/stop-all.sh; exit;" INT TERM
fi
sh $STOP_SCRIPT $* &
sleep 10
sh $START_SCRIPT $* &

if [ ! -z "$*" ]; then
    exit;
else
    trap "sh $CARBON_HOME/bin/stop-all.sh; exit;" INT TERM
    while :
    do
            sleep 60
    done
fi
