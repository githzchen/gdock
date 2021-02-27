#!/bin/sh

wget --timeout=5 --tries=1 https://www.baidu.com -q -O /dev/null
if [ $? -ne 0 ]; then
	echo "网络不畅通，重新启动代理"
	/etc/init.d/redsocks2 restart
	/etc/init.d/tproxy restart
fi
