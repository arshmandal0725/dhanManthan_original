
export PATH="$PATH:/Users/arshkumarmandal/flutter/bin"
export PATH="$PATH:/Users/arshkumarmandal/flutter/bin/cache/dart-sdk/bin"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib" 
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

__conda_setup="$('/Users/arshkumarmandal/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/arshkumarmandal/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/arshkumarmandal/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/arshkumarmandal/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup

