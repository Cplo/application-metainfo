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
    fsid=dependencies.HDFS!sid
    federation=service.nameservices?? && service.nameservices?size gt 0
>
<configuration>
<#assign fs_default_uri = "hdfs://" + fsid >
<#if federation>
    <#if service.nameservices?size == 1>
        <#assign fs_default_uri = "hdfs://" + service.nameservices[0]>
    </#if>
<#else>
    <#assign
        namenode=service.roles['HDFS_NAMENODE'][0].hostname
        namenodeport=service['namenode.rpc-port']
        fs_default_uri = "hdfs://" + namenode + ":" + namenodeport
    >
</#if>
<@property "fs.defaultFS" fs_default_uri/>
<#if federation>
<#list service.nameservices as ns>
<#if service[ns].mountPoint??>
<#assign mountPoint=service[ns].mountPoint mps=mountPoint?split(",")>
    <#list mps as mp>
        <@property "fs.viewfs.mounttable." + fsid + ".link." + mp "hdfs://" + ns + mp/>
    </#list>
</#if>
</#list>
</#if>
<#--handle dependent.zookeeper-->
<#if dependencies.ZOOKEEPER??>
    <#assign zookeeper=dependencies.ZOOKEEPER quorum=[]>
    <#list zookeeper.roles.ZOOKEEPER as role>
        <#assign quorum += [role.hostname + ":" + zookeeper[role.hostname]["zookeeper.client.port"]]>
    </#list>
    <@property "ha.zookeeper.quorum" quorum?join(",")/>
    <@property "ha.zookeeper.parent-znode" "/" + sid + "-ha"/>
</#if>
<#--handle the kerberos-->
<#if auth == "kerberos">
    <@property "hadoop.security.authentication" auth/>
    <#if service["hadoop.http.authentication.type"]=="kerberos">
    <@property "hadoop.http.filter.initializers" "org.apache.hadoop.security.AuthenticationFilterInitializer"/>
    <@property "hadoop.http.authentication.simple.anonymous.allowed" "false"/>
    <#assign realm=service['kerberos.realm'] principal="HTTP/" + localhostname?lower_case + "@" + realm>
    <@property "hadoop.http.authentication.kerberos.principal" principal/>
    <@property "hadoop.http.authentication.kerberos.keytab" "/etc/"+ fsid + "/hdfs.keytab"/>
    <@property "hadoop.http.authentication.signature.secret.file" "/etc/hadoop-http-auth-signature-secret"/>
    </#if>
</#if>
<#--hadoop.proxyuser.[hive, hue, httpfs, oozie].[hosts,groups]-->
<#assign services=["hbase","hive", "hue", "httpfs", "oozie"]>
<#list services as s>
    <@property "hadoop.proxyuser." + s + ".hosts" "*"/>
    <@property "hadoop.proxyuser." + s + ".groups" "*"/>
</#list>
<#assign user=.data_model['current.user']>
<@property "hadoop.proxyuser." + user + ".hosts" "*"/>
<@property "hadoop.proxyuser." + user + ".groups" "*"/>
<@property "net.topology.node.switch.mapping.impl" "org.apache.hadoop.net.ScriptBasedMapping"/>
<@property "net.topology.script.file.name" "/usr/lib/transwarp/scripts/rack_map.sh"/>
<@property "hadoop.security.group.mapping" "org.apache.hadoop.security.ShellBasedUnixGroupsMapping"/>
<#--Take properties from the context-->
<#list service['core-site.xml'] as key, value>
    <@property key value/>
</#list>
</configuration>