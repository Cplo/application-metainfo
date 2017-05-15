<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<#--Simple macro definition-->
<#macro property key value>
<property>
    <name>${key}</name>
    <value>${value}</value>
</property>
</#macro>
<#--------------------------->
<configuration>

<#--handle dependent.zookeeper-->
<#if dependencies.ZOOKEEPER??>
    <#assign zookeeper=dependencies.ZOOKEEPER quorum=[]>
    <#list zookeeper.roles.ZOOKEEPER as role>
        <#assign quorum += [role.hostname]>
    </#list>
    <@property "hive.zookeeper.quorum" quorum?join(",")/>
    <@property "hbase.zookeeper.quorum" quorum?join(",")/>
    <@property "holodesk.zookeeper.quorum" quorum?join(",")/>
    <@property "zookeeper.znode.parent" "/" + (dependencies.HYPERBASE??)?then(dependencies.HYPERBASE.sid, service.sid)/>
</#if>

<#-- TODO handle the kerberos-->
<#if service.auth == "kerberos">
    <@property "hive.metastore.sasl.enabled" "true"/>
    <@property "hive.metastore.kerberos.keytab.file" service.keytab/>
    <@property "hive.metastore.kerberos.principal" "hive/_HOST@" + service.realm/>
    <#if service['hive.server2.authentication'] != "LDAP">
    <@property "hive.server2.authentication" "KERBEROS"/>
    <#else>
    <@property "hive.server2.authentication" "LDAP"/>
    </#if>
    <@property "hive.server2.authentication.kerberos.principal"  "hive/_HOST@" + service.realm/>
    <@property "hive.server2.authentication.kerberos.keytab" service.keytab/>
    <#if service['hive.server2.enabled'] == "true">
    <@property "hive.security.authorization.manager" "org.apache.hadoop.hive.ql.security.authorization.plugin.sqlstd.SQLStdHiveAuthorizerFactory"/>
    <@property "hive.security.authenticator.manager" "org.apache.hadoop.hive.ql.security.SessionStateUserAuthenticator"/>
    <@property "hive.security.authorization.enabled" "true"/>
    <#if service.plugins?seq_contains("guardian")>
    <@property "hive.security.authorization.manager" "io.transwarp.guardian.plugins.inceptor.GuardianHiveAuthorizerFactory"/>
    <@property "hive.service.id" service.sid/>
    <@property "hive.metastore.event.listeners" "io.transwarp.guardian.plugins.inceptor.GuardianMetaStoreListener"/>
    </#if>
    </#if>
<#else>
    <#if service['hive.server2.authentication'] != "LDAP">
    <@property "hive.server2.authentication" "NONE"/>
    <#else>
    <@property "hive.server2.authentication" "LDAP"/>
    </#if>
</#if>

<#if dependencies.TXSQL??>
    <#assign mysqlHostPorts = []/>
    <#list dependencies.TXSQL.roles['TXSQL_SERVER'] as role>
        <#assign mysqlHostPorts = mysqlHostPorts + [role.hostname + ':' + dependencies.TXSQL['mysql.rw.port']]>
    </#list>
<#else>
    <#assign mysqlHostPorts = [service.roles.INCEPTOR_MYSQL[0]['hostname'] + ":" + service['mysql.port']]/>
</#if>

    <#assign dbconnectionstring="jdbc:mysql://" + mysqlHostPorts?join(",") + "/metastore_" + service.sid + "?createDatabaseIfNotExist=true&amp;user=" + service['javax.jdo.option.ConnectionUserName'] + "&amp;password=" + service['javax.jdo.option.ConnectionPassword'] + "&amp;characterEncoding=UTF-8">
    <@property "hive.stats.dbconnectionstring" dbconnectionstring/>
    <#assign scratchdir="hdfs://" + dependencies.HDFS.nameservices[0] + "/" + service.sid + "/tmp/hive">
    <@property "hive.exec.scratchdir" scratchdir/>
    <#assign uris="thrift://" + service.roles.INCEPTOR_METASTORE[0]['hostname'] + ":" + service['hive.metastore.port']>
    <@property "hive.metastore.uris" uris/>
    <#assign tracker=service.roles.INCEPTOR_METASTORE[0]['hostname'] + ":8031">
    <@property "mapred.job.tracker" tracker/>
    <#assign connectionURL="jdbc:mysql://" + mysqlHostPorts?join(",") + "/metastore_" + service.sid + "?createDatabaseIfNotExist=false&amp;characterEncoding=UTF-8">
    <@property "javax.jdo.option.ConnectionURL" connectionURL/>
    <#if dependencies.LICENSE_SERVICE??>
    <#assign  license=dependencies.LICENSE_SERVICE license_servers=[]>
    <#list license.roles["LICENSE_NODE"] as role>
        <#assign license_servers += [(role.hostname + ":" + license[role.hostname]["zookeeper.client.port"])]>
    </#list>
    <@property "license.zookeeper.quorum" license_servers?join(",")/>
    </#if>
<#--Take properties from the context-->
<#list service['hive-site.xml'] as key, value>
    <@property key value/>
</#list>
</configuration>