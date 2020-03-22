# 环境变量
set -gx LANG zh_CN.UTF-8
set -gx RANGER_LOAD_DEFAULT_RC FALSE
set -gx http_proxy "http://127.0.0.1:8001/"
set -gx https_proxy "http://127.0.0.1:8001/"
set -gx no_proxy "localhost,127.0.0.1"
set -gx HTTP_PROXY "http://127.0.0.1:8001/"
set -gx HTTPS_PROXY "http://127.0.0.1:8001/"
set -gx NO_PROXY "localhost,127.0.0.1,localaddress"
set -gx LDFLAGS "-L/usr/local/opt/mysql@5.7/lib"
set -gx CPPFLAGS "-I/usr/local/opt/mysql@5.7/include"
set -gx ANDROID_HOME "/Users/orionpax/Library/Android/sdk"

# 设置 Path
set -x fish_user_paths "/usr/local/opt/mysql@5.7/bin" $fish_user_paths
set -x fish_user_paths "/usr/local/opt/openjdk/bin" $fish_user_paths
set -x fish_user_paths "/Users/orionpax/Library/flutter/bin" $fish_user_paths

