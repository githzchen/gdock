#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
sed -i '$a src-git helloworld https://github.com/fw876/helloworld' feeds.conf.default

git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config

# Add disable-ss.patch for redsocks2
mkdir package/lean/redsocks2/patches
touch package/lean/redsocks2/patches/disable-ss.patch
cat >> package/lean/redsocks2/patches/disable-ss.patch << EOF
diff --git a/Makefile b/Makefile
index 70237a2..58b708e 100644
--- a/Makefile
+++ b/Makefile
@@ -52,7 +52,7 @@ override CFLAGS += -DENABLE_HTTPS_PROXY
 override FEATURES += ENABLE_HTTPS_PROXY
 $(info Compile with HTTPS proxy enabled.)
 endif
-override LIBS += -lssl -lcrypto -ldl
+#override LIBS += -lssl -lcrypto -ldl
 override CFLAGS += -DUSE_CRYPTO_OPENSSL
 endif
 ifdef ENABLE_STATIC
diff --git a/redsocks.c b/redsocks.c
index 4c1b58d..4a426d6 100644
--- a/redsocks.c
+++ b/redsocks.c
@@ -57,7 +57,7 @@ extern relay_subsys http_relay_subsys;
 extern relay_subsys socks4_subsys;
 extern relay_subsys socks5_subsys;
 #if !defined(DISABLE_SHADOWSOCKS)
-extern relay_subsys shadowsocks_subsys;
+//extern relay_subsys shadowsocks_subsys;
 #endif
 static relay_subsys *relay_subsystems[] =
 {
@@ -67,7 +67,7 @@ static relay_subsys *relay_subsystems[] =
     &socks4_subsys,
     &socks5_subsys,
 #if !defined(DISABLE_SHADOWSOCKS)
-    &shadowsocks_subsys,
+//    &shadowsocks_subsys,
 #endif
 #if defined(ENABLE_HTTPS_PROXY)
     &https_connect_subsys,
diff --git a/redudp.c b/redudp.c
index d58f9b2..1b7bef9 100644
--- a/redudp.c
+++ b/redudp.c
@@ -66,13 +66,13 @@ struct bound_udp4 {
 
 extern udprelay_subsys socks5_udp_subsys;
 #if !defined(DISABLE_SHADOWSOCKS)
-extern udprelay_subsys shadowsocks_udp_subsys;
+//extern udprelay_subsys shadowsocks_udp_subsys;
 #endif
 static udprelay_subsys *relay_subsystems[] =
 {
     &socks5_udp_subsys,
     #if !defined(DISABLE_SHADOWSOCKS)
-    &shadowsocks_udp_subsys,
+//    &shadowsocks_udp_subsys,
     #endif
 };
 /***********************************************************************
EOF

