#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

rm -rf feeds/packages/luci/themes/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/lean/luci-app-argon-config

chmod 0755 files/etc/init.d/softethervpnclient
chmod 0755 files/etc/init.d/tproxy
chmod 0755 files/etc/init.d/redsocks2
chmod 0755 files/etc/proxymonitor.sh
rm -rf package/lean/luci-theme-argon
mkdir files/etc/rc.d
cd files/etc/rc.d
ln -s ../init.d/redsocks2 S90redsocks2
ln -s ../init.d/tproxy S99tproxy
