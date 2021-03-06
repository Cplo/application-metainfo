<#assign servers=service.roles.GUARDIAN_APACHEDS?sort_by("id") master=servers[0].hostname>
<#if (servers?size >1)>
	<#assign slaves=servers[1..(servers?size-1)] slaves_with_port=[]>
	<#list slaves as slave>
		<#assign slaves_with_port += [slave.hostname + ":" + service['guardian.apacheds.ldap.port']]>
	</#list>
</#if>
#   Licensed to the Apache Software Foundation (ASF) under one
#   or more contributor license agreements.  See the NOTICE file
#   distributed with this work for additional information
#   regarding copyright ownership.  The ASF licenses this file
#   to you under the Apache License, Version 2.0 (the
#   "License"); you may not use this file except in compliance
#   with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing,
#   software distributed under the License is distributed on an
#   "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
#   KIND, either express or implied.  See the License for the
#   specific language governing permissions and limitations
#   under the License.
#
# Fortress slapd.conf default settings.
# Note: Directives that begin with '@' are substitution parms for Fortress' build.xml 'init-slapd' target.

# Used as the transwarp manager configurations

# Host name and port of LDAP DIT:
host=${master}
port=${service['guardian.apacheds.ldap.port']}

# Options are openldap or apacheds (default):
ldap.server.type=apacheds

# Audit only works if ldap.server.type == openldap:
enable.audit=false

# Used for SSL Connection to LDAP Server:
enable.ldap.ssl=false
enable.ldap.ssl.debug=false
trust.store=not_used
trust.store.password=not_used
trust.store.set.prop=not_used

# Used for SSL Demo with Tomcat:
key.store=not_used
key.store.password=not_used

# These credentials are used for read/write access to all nodes under suffix:
admin.user=uid=admin,ou=system
# LDAP admin root pass is encrypted using 'encrypt' target in build.xml:
admin.pw=${service['guardian.ds.root.password']}

# LDAP connection timeout in ms:
connection.timeout = 10000

# This is min/max settings for LDAP administrator pool connections that have read/write access to all nodes under suffix:
min.admin.conn=1
max.admin.conn=10

# This is min/max connection pool settings for LDAP User authentication connection pool:
min.user.conn=1
max.user.conn=10

# These credentials are used for read/write access to all nodes under slapd access log suffix:
log.admin.user=cn=Manager,cn=log
# For corresponding log user:
log.admin.pw=secret

# This is min/max settings for LDAP connections to read slapo access log:
min.log.conn=1
max.log.conn=3

# This node contains fortress properties stored on behalf of connecting LDAP clients:
config.realm=DEFAULT
config.root=ou=Config,${service['guardian.ds.domain']}

# enable this to see trace statements when connection pool allocates new connections:
debug.ldap.pool=true

# Default for pool reconnect flag is false:
enable.pool.reconnect=true

ehcache.config.file=ehcache.xml

# If for any reason echcache must be DISABLED for DSD, make sure this parameter is set to 'true' which is the default.  Otherwise performance penalty will be incurred during multi-role activations.
disable.dsd.cache=false

# This will override default LDAP manager implementations for the RESTful ones:
enable.mgr.impl.rest=false
# Optional parameters needed when Fortress client is connecting with the En Masse (rather than LDAP) server:
http.user=demouser4
http.pw=password
http.host=localhost
http.port=8080
http.protocol=http
dao.connector=apache

GroupTest=org.apache.directory.fortress.core.group.GroupAntTest

# These may be used to override default LDAP or REST with OTHER implementations:
#reviewmgr.implementation=org.apache.directory.fortress.core.rest.ReviewMgrOtherImpl
#adminmgr.implementation=org.apache.directory.fortress.core.rest.AdminMgrOtherImpl
#accessmgr.implementation=org.apache.directory.fortress.core.rest.AccessMgrOtherImpl
#delegated.adminmgr.implementation=org.apache.directory.fortress.core.rest.DelAdminMgrOtherImpl
#delegated.reviewmgr.implementation=org.apache.directory.fortress.core.rest.DelReviewMgrOtherImpl
#policymgr.implementation=org.apache.directory.fortress.core.rest.PwPolicyMgrOtherImpl
#delegated.accessmgr.implementation=org.apache.directory.fortress.core.rest.DelAccessMgrOtherImpl
#auditmgr.implementation=org.apache.directory.fortress.core.rest.AuditMgrOtherImpl
#configmgr.implementation=org.apache.directory.fortress.core.rest.ConfigMgrOtherImpl


<#if (servers?size > 1)>
ldap.slaves=${slaves_with_port?join(";")}
</#if>



