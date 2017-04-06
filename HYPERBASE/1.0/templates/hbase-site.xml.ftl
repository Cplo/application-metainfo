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
>
<configuration>

<#--handle dependent.zookeeper-->
<#if dependencies.ZOOKEEPER??>
    <#assign zookeeper=dependencies.ZOOKEEPER quorum=[]>
    <#list zookeeper.roles.ZOOKEEPER as role>
        <#assign quorum += [role.hostname]>
    </#list>
    <@property "hbase.zookeeper.quorum" quorum?join(",")/>
    <@property "zookeeper.znode.parent" "/" + sid/>
</#if>

<#-- TODO handle the kerberos-->
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
    <#assign path="hdfs://" + dependencies.HDFS.nameservices[0] + "/" + service.sid + "_hregionindex">
    <@property "hregion.index.path" path/>
    <#assign rootdir="hdfs://" + dependencies.HDFS.nameservices[0] + "/" + service.sid>
    <@property "hbase.rootdir" rootdir/>
    <#assign dir="hdfs://" + dependencies.HDFS.nameservices[0] + "/" + service.sid + "/hbase_timediff">
    <@property "hbase.sservice.hdfs.dir" dir/>
    <@property "license.zookeeper.quorum" "172.16.1.41:2181"/>

    <@property "hbase.master.port" service['master.port']/>
    <@property "hbase.master.info.port" service['master.info.port']/>
    <@property "hbase.regionserver.port" service['regionserver.port']/>
    <@property "hbase.regionserver.info.port" service['regionserver.info.port']/>

<#--Take properties from the context-->
<#list service['hbase-site.xml'] as key, value>
    <@property key value/>
</#list>
</configuration>