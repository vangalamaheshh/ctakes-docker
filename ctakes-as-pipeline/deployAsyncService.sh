#!/bin/sh
#   Licensed to the Apache Software Foundation (ASF) under one
#   or more contributor license agreements.  See the NOTICE file
#   distributed with this work for additional information
#   regarding copyright ownership.  The ASF licenses this file
#   to you under the Apache License, Version 2.0 (the
#   "License"); you may not use this file except in compliance
#   with the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing,
#   software distributed under the License is distributed on an
#   #  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
#   KIND, either express or implied.  See the License for the
#   specific language governing permissions and limitations
#   under the License.

if [ "$UIMA_HOME" = "" ]
then
  echo UIMA_HOME environment variable is not set
  exit 1
fi

if [ "$ctakes_umlsuser" = "" ]
then
  echo ctakes_umlsuser environment variable is not set
  exit 1
fi

if [ "$ctakes_umlspw" = "" ]
then
  echo ctakes_umlspw environment variable is not set
  exit 1
fi

if [ $# -lt 1 ]
  then echo "You must specify one or more deployment descriptors.  Usage: deployAsyncService.sh file-path-of-deployment-descriptor [another-dd ...]"
       exit 1;
fi;
if [ ! -f $1 ]
  then echo "File '"$1"' does not exist";
       exit 1;
fi;
export UIMA_CLASSPATH="$CTAKES_HOME/lib":$CTAKES_HOME/resources:/

"$UIMA_HOME/bin/runUimaClass.sh" org.apache.uima.adapter.jms.service.UIMA_Service -saxonURL "file:$UIMA_HOME/saxon/saxon8.jar" -xslt "$UIMA_HOME/bin/dd2spring.xsl" -dd $@
