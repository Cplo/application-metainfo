<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<#--Simple macro definition-->
<#macro property key value>
<property>
    <name>${key}</name>
    <value>${value}</value>
</property>
</#macro>
<#--------------------------->
<#assign
    sid=service.sid
    auth=service.auth
    historyServer=service.roles.YARN_HISTORYSERVER[0]['hostname']
    resourceManager=service.roles.YARN_RESOURCEMANAGER[0]['hostname']
    timelineServer=service.roles.YARN_TIMELINESERVER[0]['hostname']
>
<configuration>
    <@property "yarn.resourcemanager.scheduler.address" resourceManager + ":8030"/>
    <@property "yarn.resourcemanager.resource-tracker.address" resourceManager + ":8031"/>
    <@property "yarn.resourcemanager.address" resourceManager + ":8032"/>
    <@property "yarn.resourcemanager.admin.address" resourceManager + ":8033"/>
    <@property "yarn.resourcemanager.webapp.address" resourceManager + ":8088"/>
    <@property "yarn.nodemanager.remote-app-log-dir" "/" + sid + "/var/log/hadoop-yarn/apps"/>
    <@property "yarn.log.server.url" "http://" + historyServer + ":19888/jobhistory/logs/"/>
    <@property "yarn.timeline-service.hostname" timelineServer/>
    <@property "yarn.timeline-service.webapp.https.address" timelineServer + ":8190"/>
    <@property "yarn.timeline-service.webapp.address" timelineServer + ":8188"/>
    <@property "yarn.resourcemanager.nodes.exclude-path" "/etc/" + sid + "/conf/yarn.exclude"/>
<#--Take properties from the context-->
<#list service['yarn-site.xml'] as key, value>
    <@property key value/>
</#list>
</configuration>